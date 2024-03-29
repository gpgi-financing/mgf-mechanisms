from random import random
import os
from flask import Flask, request, render_template
from browsergame.context import Context
from browsergame.game import Game
from browsergame.settings import getDefaultSettings
from browsergame.strategy import Strategy
import bcrypt
import psycopg2


# Decompose a string of integers separated by commas
def decomposeStringOfInts(stringOfNums):
    numberStrings = stringOfNums.split(",")
    return [int(string) for string in numberStrings]


# Turn an array of integers into a comma-separated string
def createStringOfInts(arr):
    stringOfNums = ""
    for elem in arr:
        stringOfNums += str(elem) + ","
    return stringOfNums[0:len(stringOfNums) - 1]

def create_app(test_config=None):
    app = Flask(__name__)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    conn = psycopg2.connect("dbname=postgres user=postgres password=gibberish")

    cur = conn.cursor()

    # TODO: I think there's some other way to actually implement logins?
    context = Context(None, None)

    gameCounter = 0
    cur.execute("SELECT uid FROM users;")
    uids = cur.fetchall()

    cur.execute("SELECT uid, hashSaltPw FROM users;")
    hashSaltPws = {}
    hashSaltArray = cur.fetchall()
    for tuple in hashSaltArray:
        hashSaltPws[tuple[0]] = tuple[1]
    games = []
    cur.execute("SELECT * FROM games;")
    gameInfos = cur.fetchall()
    for gameInfo in gameInfos:
        name = gameInfo[len(gameInfo) - 1]
        players = decomposeStringOfInts(gameInfo[0])
        resources = decomposeStringOfInts(gameInfo[1])
        cur.execute("SELECT * FROM strategies WHERE game=%s;", name)
        strategies = [None for elem in players]
        strategyData = cur.fetchAll()
        for strat in strategyData:
            proportionNonAllocated = strat[1]
            proportionDirect = strat[2]
            proportionMatching = strat[3]
            directSplit = decomposeStringOfInts(strat[4])
            matchingComp = decomposeStringOfInts(strat[5])
            strategies[strat[6]] = Strategy(proportionNonAllocated, proportionDirect, proportionMatching, directSplit,
                                            matchingComp)
        currPlayer = gameInfo[2]
        period = gameInfo[3]
        payoffs = decomposeStringOfInts(gameInfo[4])
        finalRound = gameInfo[5]
        funds = getDefaultSettings().funds  # TODO: set this to a non-default when needed
        games.append(Game(players, resources, strategies, currPlayer, period, payoffs, finalRound, funds, name))

    cur.execute("SELECT uid FROM waitingUsers;")
    waitingUsers = cur.fetchall()
    userToGame = {}
    cur.execute("SELECT uid, game FROM users WHERE game != null;")
    usersAndGames = cur.fetchall()
    for userAndGame in usersAndGames:
        for game in games:
            if game.name == userAndGame[1]:
                userToGame[userAndGame[0]] = game
                continue
    salt = bcrypt.gensalt()  # TODO: only do this once, or generate a salt with a constant seed

    @app.route('/login', methods=['GET', 'POST'])
    def login():
        nonlocal gameCounter
        nonlocal waitingUsers
        if (request.method == 'POST'):
            hashedPw = bcrypt.hashpw(request.json['pw'].encode('utf8'), salt)
            if request.json['uid'] in hashSaltPws:
                if hashedPw != hashSaltPws[request.json['uid']]:
                    return
            else:
                uids.append(request.json['uid'])
                print(request.json['pw'])
                hashSaltPws[request.json['uid']] = bcrypt.hashpw(request.json['pw'].encode('utf8'), salt)
                cur.execute("INSERT INTO users (uid, hashSaltPw) VALUES (%s, %s);",
                            (request.json['uid'], hashSaltPws[request.json['uid']]))
            context.uid = request.json['uid']
            if (context.uid not in userToGame and context.uid not in waitingUsers):
                waitingUsers.append(context.uid)
                if (len(waitingUsers) == 12):
                    nextGame = Game(waitingUsers, str(gameCounter), getDefaultSettings())  # TODO: Generate name
                    for user in waitingUsers:
                        userToGame[user] = nextGame
                        cur.execute("UPDATE users SET game = %s WHERE uid = %s;", (nextGame.name, user))
                    waitingUsers = []
                    cur.execute("TRUNCATE TABLE waitingUsers;")
                    games.append(nextGame)
                    cur.execute("INSERT INTO games VALUES (%s, %s, %s, %s, %s, %s);",
                                (createStringOfInts(nextGame.players), createStringOfInts(nextGame.resources),
                                 nextGame.currPlayer, nextGame.period, createStringOfInts(nextGame.payoffs),
                                 nextGame.finalRound, nextGame.name))
                    for strat in nextGame.strategies:
                        cur.execute("INSERT INTO strategies VALUES (%s, %s, %s, %s, %s, %s);", (
                        nextGame.name, strat.proportionNotAllocated, strat.proportionDirect, strat.proportionMatching,
                        createStringOfInts(strat.directSplit), createStringOfInts(strat.matchingComp)))
                        cur.commit()
                    gameCounter += 1
                    return render_template("index.html") # TODO: display game
                else:
                    cur.execute("INSERT INTO waitingUsers VALUES (%s);", (context.uid,))
                    return render_template("wait.html")
            else:
                if context.uid in waitingUsers:
                    return render_template("wait.html")
                return render_template("index.html")  # TODO: display game
        else:
            return render_template("login.html")

    @app.route('/getStrategies', methods=['GET'])
    def getStrategies():
        if context.uid not in userToGame:
            return ""
        else:
            return userToGame[context.uid].strategies

    @app.route("/submit", methods=['POST'])
    def receiveStrategy():
        if (userToGame[context.uid].currPlayer != context.uid):
            return
        strategy = request.json['strategy']
        game = userToGame[context.uid]
        game.strategies[game.currPlayer] = strategy
        currPayoffs = game.getRoundPayoffs()
        game.payoffs = [game.payoffs[i] + currPayoffs[i] for i in range(len(game.players))]
        game.currPlayer = random.choice(game.players)
        cur.execute("UPDATE TABLE games SET currPlayer = %s, payoffs = %s WHERE name = %s",
                    (game.currPlayer, game.payoffs, game.name))
        cur.execute(
            "UPDATE TABLE strategies SET proportionNonAllocated = %s, proportionDirect = %s, proportionMatching = %s, directSplit = %s, matchingComp = %s WHERE game = %s AND player = %s",
            (strategy.proportionNonAllocated, strategy.proportionDirect, strategy.proportionMatching,
             createStringOfInts(strategy.directSplit), createStringOfInts(strategy.matchingComp), game.name,
             context.uid))
        if game.period > game.finalRound:
            game.end()
        else:
            game.period += 1
            cur.execute("UPDATE TABLE games SET period = %s", game.period)

    @app.route("/game")
    def displayDefaultGame():
        return render_template("index.html")
    
    @app.route("/gameInfo", methods=['GET'])
    def getGameInfo():
        for game in games:
            if game.name == request.json['name']:
                return game
    return app