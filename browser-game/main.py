from flask import Flask, request
from .context import Context
from .game import Game
from .settings import getDefaultSettings
import bcrypt

app = Flask(__name__)

#TODO: I think there's some other way to actually implement logins?
context = Context(None, None)

gameCounter = 0
uids = []
hashSaltPws = {}
games = []
waitingUsers = []
userToGame = {}
salt = bcrypt.gensalt()

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
        context.uid = request.form['uid']
        if (context.uid not in userToGame):
            waitingUsers.append(context.uid)
            if (len(waitingUsers) == 12):
                nextGame = Game(waitingUsers, str(gameCounter), getDefaultSettings()) #TODO: Generate name
                for user in waitingUsers:
                    userToGame[user] = nextGame
                waitingUsers = []
                games.append(nextGame)
                gameCounter += 1
        else:
            pass#TODO: display game