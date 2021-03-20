from flask_restful import Resource
from flask import jsonify, request
from werkzeug.security import check_password_hash
from app import users, not_found
import uuid


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
