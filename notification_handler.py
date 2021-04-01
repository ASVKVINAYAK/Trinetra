
import requests
import pymongo
import time
import datetime
from .app import ProfileView

client = pymongo.MongoClient(
    "mongodb+srv://gnosticplayer:pass12345@"
    "cluster0.qarzu.mongodb.net/hackathon"
    "?retryWrites=true&w=majority")
db = client.hackathon
users = db.users
profile = ProfileView()
timezone = datetime.timezone(datetime.timedelta(
    seconds=-19800), 'India Standard Time')


def send_notification(user_token):
    if not user_token:
        return 400

    url = "https://fcm.googleapis.com/fcm/send"

    headers = dict()
    headers["Authorization"] = "key=AAAATyvUHn8:APA91bEGhI-RblLnlAf1-e0R-xgKKe9zSDTD1HtLGGiB_OXk8vIfv-Sz6t7w17OoaBVi4dG7C5Mu8fX2IdHHPMcxjckXygoKZsWfFoUWzsRkrKg0WOhFs_-uJofLjtKBCKg8aqdlheEK"

    data = {
        "to": user_token,
        "collapse_key": "New Message",
        "notification": {
            "body": "Mark your Atendance within 10 min",
            "title": "ALERT !! ⚠⚠⚠"
        },
        "data": {
            "body": "alert",
            "title": "alert"
        }
    }

    resp = requests.post(url, headers=headers, json=data)

    return resp.status_code


def ask_attendance():
    users.update_many(
        {"is_admin": False},
        {
            "$set": {
                "active": 0
            }
        })
    [send_notification(data.get("fcm"))
     for data in users.find({"active": 0, "fcm": {"$exists": True}}, {"fcm": 1})]


def revoke_attendance():

    log = {
        "timestamp": datetime.datetime.now(timezone),
        "lat": 0, "lon": 0,
        "available": False
    }
    user_list = users.find({"active": 0}, {"phone": 1})
    [profile.update(user["phone"], log) for user in user_list]


if __name__ == '__main__':
    logs = []
    while True:
        h, m = map(int, time.strftime("%H %M").split())
        if len(logs) < 5:
            if 8 < h < 17:
                if h in logs:
                    time.sleep(10*60)
                    continue
                else:
                    print("Fetching Attendance at {}:{}".format(h, m))
                    ask_attendance()
                    time.sleep(10*60)
                    revoke_attendance()
                    logs.append(h)
                time.sleep(((18-h)/(5-len(logs)))*60*60)
            else:
                time.sleep(10*60)
        else:
            logs = []
