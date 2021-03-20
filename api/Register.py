from flask_restful import Resource
from flask import jsonify, request
from app import users, not_found
import requests


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
