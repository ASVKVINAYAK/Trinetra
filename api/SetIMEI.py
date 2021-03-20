from flask_restful import Resource
from flask import jsonify, request
from app import users, not_found
from werkzeug.security import generate_password_hash


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

    def put(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })
