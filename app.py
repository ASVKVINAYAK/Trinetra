from flask import Flask, jsonify, request
from flask_restful import Resource, Api
from flask_pymongo import PyMongo
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import requests
# from api.login import Login
# from api.register import Register
# from flask_jwt import JWT, jwt_required, current_identity


app = Flask(__name__)

app.config['MONGODB_NAME'] = 'hackathon'
app.config['MONGO_URI'] = 'mongodb+srv://gnosticplayer:pass12345@cluster0.qarzu.mongodb.net/ccdatabase?retryWrites=true&w=majority'
app.config['SECRET_KEY'] = 'secret_key'

mongo = PyMongo(app)
users = mongo.db.users


class Login(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Missing Fields Found")
        phone = data.get('phone')
        password = data.get('imei')
        if phone and password:
            user = users.find_one({'phone': phone})
            if user:
                password_hash = user.get("imei", "")
                token = str(uuid.uuid4())
                if not check_password_hash(password_hash, password):
                    return jsonify(
                        {
                            'success': False,
                            'token': None,
                            'message': "Invalid Password"
                        })
                users.update_one({"_id": user["_id"]}, {
                                 '$set': {"token": token}})
                response = {'success': True,
                            "first_run": False, 'token': token}
                if not password_hash:
                    response.update({"first_run": True})
                return jsonify(response)
            else:
                return jsonify(
                    {
                        'success': False,
                        'token': None,
                        'message': "No such user exists"
                    })
        else:
            return not_found("Missing Fields Found")


class Register(Resource):

    def upload_img(self, image_data):
        url = "https://api.imgbb.com/1/upload"
        payload = {
            "key": "3585d30ba35c4412cb1dd93e1522118e",
            "image": image_data,
        }
        response = requests.post(url, payload).json()
        imgurl = ""
        if response['success']:
            imgurl = response["data"]["url"]
        return imgurl

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Missing Fields Found")
        employee_id = data.get('employee_id')
        name = data.get('name')
        phone = data.get('phone')
        photo = data.get('photo')
        if all(employee_id, name, phone, photo):
            user_id = users.update(
                {'employee_id': employee_id},
                {
                    '$set': {
                        "employee_id": employee_id,
                        "name": name,
                        "phone": phone,
                        "photo": self.upload_img(photo)
                    }
                }, upsert=True)
            user = users.find_one({'_id': user_id})
            user.pop("password")
            return jsonify({'success': True, **user})
        else:
            return not_found("Missing Fields Found")

class IMEI(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Missing Fields Found")
        token = data.get('token')
        phone = data.get('phone')
        password = data.get('imei')
        if phone and token:
            user = users.find_one({'phone': phone})
            if user.get("imei") is None:
                users.update(
                    {'phone': phone},
                    {
                        '$set':
                        {
                            "imei": generate_password_hash(password)
                        }
                    })
                return jsonify({'success': True})
            else:
                return jsonify(
                    {'success': False, "message": "IMEI already registered."})
        else:
            return not_found("Missing Fields Found")


restServer = Api(app)

restServer.add_resource(Login, "/api/login")
restServer.add_resource(Register, "/api/register")
restServer.add_resource(IMEI, "/api/set-imei")
# restServer.add_resource(TaskById, "/api/v1/task/<string:taskId>")


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'success': False,
        'message': str(error)
    }
    return jsonify(message)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True, use_reloader=True)
