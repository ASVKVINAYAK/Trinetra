from flask_restful import Api
from app import app
from .Login import Login
from .Register import Register
from .SetIMEI import IMEI
# from .TaskById import TaskById
from flask import jsonify

restServer = Api(app)

restServer.add_resource(Login, "/api/login")
restServer.add_resource(Register, "/api/register")
restServer.add_resource(IMEI, "/api/set-imei")
# restServer.add_resource(TaskById, "/api/v1/task/<string:taskId>")


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'success': False,
        'message': error
    }
    return jsonify(message)
