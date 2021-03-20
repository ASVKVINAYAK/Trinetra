from flask import Flask, jsonify
from flask_pymongo import PyMongo
from api.Login import Login
from api.Register import Register
from flask_restful import Api
# from flask_jwt import JWT, jwt_required, current_identity


app = Flask(__name__)

app.config['MONGODB_NAME'] = 'hackathon'
app.config['MONGO_URI'] = 'mongodb+srv://gnosticplayer:pass12345@cluster0.qarzu.mongodb.net/ccdatabase?retryWrites=true&w=majority'

mongo = PyMongo(app)
users = mongo.db.users

"""def authenticate(username, password):
    user = mongo.db.users.find_one(
        {"username": username, "password": password})
    return user


def identity(payload):
    user_id = payload['identity']
    return userid_table.get(user_id, None)"""


# jwt = JWT(app, authenticate, identity)

restServer = Api(app)

restServer.add_resource(Login, "/api/login")
restServer.add_resource(Register, "/api/register")
# restServer.add_resource(TaskById, "/api/v1/task/<string:taskId>")


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'success': False,
        'message': error
    }
    return jsonify(message)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True, use_reloader=True)
