from flask import Flask, jsonify, request, send_from_directory
from flask_restful import Resource, Api
from flask_pymongo import PyMongo
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import os
import datetime
import jwt
# from api.login import Login
# from api.register import Register
# from flask_jwt import JWT, jwt_required, current_identity


app = Flask(__name__)
timezone = datetime.timezone(datetime.timedelta(
    seconds=19800), 'India Standard Time')


class LoginView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        phone = data.get('phone') or data.get('username')
        password = data.get('imei') or data.get('password')
        if phone and password:
            user = users.find_one({'phone': phone})
            if user:
                password_hash = user.get("password", "")
                if (not check_password_hash(password_hash, password)
                        and password_hash):
                    return jsonify(
                        {
                            'success': False,
                            'token': None,
                            'message': "Invalid Password"
                        })
                response = {
                    'success': True,
                    "first_run": False,
                    'token': encode_auth_token(phone, user.get("is_admin"))}
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
            return not_found("Some fields are missing.")


class UserView(Resource):

    def get(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        if resp["admin"]:
            user_list = users.find({"is_admin": False})
            profile_list = []
            for user in user_list:
                user.pop("password", None)
                user.pop("_id", None)
                profile_list.append(user)
            return jsonify(
                {
                    "success": True,
                    "count": user_list.count(),
                    "users": profile_list
                })
        else:
            return not_found("Unauthorized User")

    def post(self):
        data = request.form
        if not data:
            return not_found("Some fields are missing.")
        employee_id = data.get('employee_id')
        name = data.get('name')
        phone = data.get('phone')
        photo = request.files.get('photo')
        if all([employee_id, name, phone, photo]):
            photo_name = str(uuid.uuid4())+"." + \
                photo.filename.split('.')[-1]
            photo.save(os.path.join("uploads", photo_name))
            photo_name = "/uploads/"+photo_name
            users.update_one(
                {
                    'employee_id': employee_id,
                    "phone": phone
                },
                {
                    '$set': {
                        "employee_id": employee_id,
                        "name": name,
                        "phone": phone,
                        "photo": photo_name,
                        "is_admin": False
                    }
                }, upsert=True)
            attendance.update_one(
                {'phone': phone},
                {
                    '$set': {
                        'phone': phone
                    }
                }, upsert=True)
            user = users.find_one({'employee_id': employee_id})
            user.pop("password", None)
            user.pop("_id", None)
            return jsonify({'success': True, **user})
        else:
            return not_found("Some fields are missing.")


class PasswordView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        data = request.get_json()
        if not data:
            return not_found("Missing IMEI Field")
        phone = resp['id']
        password = data.get('imei')
        if password:
            user = users.find_one({'phone': phone})
            if user.get("password") is None:
                users.update_one(
                    {'phone': phone},
                    {
                        '$set':
                        {
                            "password": generate_password_hash(password)
                        }
                    })
                return jsonify({'success': True})
            else:
                return jsonify(
                    {
                        'success': False,
                        "message": "IMEI already registered."
                    })
        else:
            return not_found("Some fields are missing.")


class ProfileView(Resource):

    def get(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        user = users.find_one({'phone': resp['id']})
        user.pop("password", None)
        user.pop("_id", None)
        return jsonify({"success": True, **user})

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        lat = data.get("lat")
        lon = data.get("lon")
        if lat and lon:
            now = datetime.datetime.now(timezone)
            now_str = now.strftime("%d-%m-%Y")
            log = {"timestamp": now, "lat": lat, "lon": lon}
            attendance.update_one(
                {"phone": resp['id']},
                {
                    '$push': {now_str: log}
                })
            return jsonify({"success": True})
        else:
            return not_found("Some fields are missing.")


class AdminRegisterView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        username = data.get('username')
        password = data.get('password')
        if username and password:
            users.insert_one(
                {
                    'employee_id': None,
                    "phone": username,
                    "password": generate_password_hash(password),
                    "is_admin": True
                })
            user = users.find_one({'phone': username})
            user.pop("password", None)
            user.pop("_id", None)
            return jsonify({'success': True, **user})
        else:
            return not_found("Some fields are missing.")


@app.route("/uploads/<filename>")
def uploaded_file(filename):
    return send_from_directory("uploads", filename, as_attachment=True)


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'success': False,
        'message': str(error)
    }
    return jsonify(message)


def decode_auth_token(auth_token):
    """
    Decodes the auth token
    :param auth_token:
    :return: integer|string
    """
    try:
        payload = jwt.decode(
            auth_token,
            app.config.get('SECRET_KEY'),
            algorithm='HS256')
        return payload
    except jwt.ExpiredSignatureError:
        return 'Signature expired. Please log in again.'
    except jwt.InvalidTokenError:
        return 'Invalid token. Please log in again.'


def encode_auth_token(user_id, is_admin=False):
    """
    Generates the Auth Token
    :return: string
    """
    try:
        now = datetime.datetime.utcnow()
        payload = {
            'exp': now + datetime.timedelta(days=1),
            'iat': now,
            'id': user_id,
            'admin': is_admin
        }
        return jwt.encode(
            payload,
            app.config.get('SECRET_KEY'),
            algorithm='HS256'
        ).decode()
    except Exception as e:
        return e


app.config['MONGODB_NAME'] = 'hackathon'
app.config['MONGO_URI'] = 'mongodb+srv://gnosticplayer:pass12345@cluster0.qarzu.mongodb.net/hackathon?retryWrites=true&w=majority'
app.config['SECRET_KEY'] = 'secret_key'

mongo = PyMongo(app)
users = mongo.db.users
attendance = mongo.db.attendance

restServer = Api(app)

restServer.add_resource(LoginView, "/login")
restServer.add_resource(UserView, "/register", '/users')
restServer.add_resource(PasswordView, "/setIMEI")
restServer.add_resource(ProfileView, "/profile")
restServer.add_resource(AdminRegisterView, "/admin/register")
# restServer.add_resource(AddLocation, "/saveLocation")
# restServer.add_resource(TaskById, "/api/v1/task/<string:taskId>")


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True, use_reloader=True)
