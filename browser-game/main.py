from flask import Flask, request
from .context import Context
from .game import Game
from .settings import getDefaultSettings
from .strategy import Strategy
import bcrypt
import psycopg2

app = Flask(__name__)

conn = psycopg2.connect("dbname=PLACEHOLDER user=PLACEHOLDER")

cur = conn.cursor()

#TODO: I think there's some other way to actually implement logins?
context = Context(None, None)

#Decompose a string of integers separated by commas
def decomposeStringOfInts(stringOfNums):
    numberStrings = stringOfNums.split(",")
    return [int(string) for string in numberStrings]

#Turn an array of integers into a comma-separated string
def createStringOfInts(arr):
    stringOfNums = ""
    for elem in arr:
        stringOfNums += str(elem) + ","
    return stringOfNums[0:len(stringOfNums) - 1]

gameCounter = 0
cur.execute("SELECT uid FROM users;")
uids = cur.fetchAll()

cur.execute("SELECT uid, hashSaltPw FROM users;")
hashSaltPws = {}
hashSaltArray = cur.fetchAll()
for tuple in hashSaltArray:
    hashSaltPws[tuple[0]] = tuple[1]
games = []
cur.execute("SELECT * FROM games;")
gameInfos = cur.fetchAll()
for gameInfo in gameInfos:
    name = gameInfo[len(gameInfo) - 1]
    players = decomposeStringOfInts(gameInfo[0])
    resources = decomposeStringOfInts(gameInfo[1])
    cur.execute("SELECT * FROM strategies WHERE game=%s", name)
    strategies = []
    strategyData = cur.fetchAll()
    for strat in strategyData:
        proportionNonAllocated = strat[1]
        proportionDirect = strat[2]
        proportionMatching = strat[3]
        directSplit = decomposeStringOfInts(strat[4])
        matchingComp = decomposeStringOfInts(strat[5])
        strategies.append(Strategy(proportionNonAllocated, proportionDirect, proportionMatching, directSplit, matchingComp))
    currPlayer = gameInfo[2]
    period = gameInfo[3]
    payoffs = decomposeStringOfInts(gameInfo[4])
    finalRound = gameInfo[5]
    funds = getDefaultSettings().funds #TODO: set this to a non-default when needed
    games.append(Game(players, resources, strategies, currPlayer, period, payoffs, finalRound, funds, name))




cur.execute("SELECT uid FROM waitingUsers;")
waitingUsers = cur.fetchAll()
userToGame = {}
cur.execute("SELECT uid, game FROM users WHERE game != null;")
usersAndGames = cur.fetchAll()
for userAndGame in usersAndGames:
    for game in games:
        if game.name == userAndGame[1]:
            userToGame[userAndGame[0]] = game
            continue
salt = bcrypt.gensalt() #TODO: only do this once, or generate a salt with a constant seed

@app.route('/login', methods=['GET', 'POST'])
def login():
    nonlocal gameCounter
    nonlocal waitingUsers
    if (request.method == 'POST'):
        hashedPw = bcrypt.hashpw(request.form['pw'], salt)
        if request.form['uid'] in hashSaltPws:
            if hashedPw != hashSaltPws[request.form['uid']]:
                return
        else:
            uids.append(request.form['uid'])
            hashSaltPws[request.form['uid']] = bcrypt.hashpw(request.form['pw'], salt)
            cur.execute("INSERT INTO users (uid, hashSaltPw) VALUES (%s, %s);", (request.form['uid'], hashSaltPws[request.form['uid']]))
            cur.commit()
        context.uid = request.form['uid']
        if (context.uid not in userToGame):
            waitingUsers.append(context.uid)
            if (len(waitingUsers) == 12):
                nextGame = Game(waitingUsers, str(gameCounter), getDefaultSettings()) #TODO: Generate name
                for user in waitingUsers:
                    userToGame[user] = nextGame
                    cur.execute("UPDATE users SET game = %s WHERE uid = %s", (nextGame.name, user))
                waitingUsers = []
                games.append(nextGame)
                cur.execute("INSERT INTO games VALUES (%s, %s, %s, %s, %s, %s)",
                            (createStringOfInts(nextGame.players), createStringOfInts(nextGame.resources), nextGame.currPlayer, nextGame.period, createStringOfInts(nextGame.payoffs), nextGame.finalRound, nextGame.name))
                for strat in nextGame.strategies:
                    cur.execute("INSERT INTO strategies VALUES (%s, %s, %s, %s, %s, %s)", (nextGame.name, strat.proportionNotAllocated, strat.proportionDirect, strat.proportionMatching, createStringOfInts(strat.directSplit), createStringOfInts(strat.matchingComp)) )
                gameCounter += 1
        else:
            pass#TODO: display game


@app.route('/getStrategies', methods=['GET'])
def getStrategies():
    if context.uid not in userToGame:
        return ""
    else:
        return userToGame[context.uid].strategies
