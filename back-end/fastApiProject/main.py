import sqlalchemy as db
from fastapi import FastAPI, Form

from utils import *


app = FastAPI()

<<<<<<< HEAD:back-end/fastApiProject/main.py
engine = db.create_engine('sqlite:///../../database/login')
=======
engine = db.create_engine('sqlite:///login')
>>>>>>> e2fcc3d2bc5e0a800eeb64b3e77c451ff5f3d83c:back-end/main.py
metadata = db.MetaData()
connection = engine.connect()
table = db.Table('login', metadata, autoload=True, autoload_with=engine)


@app.on_event("shutdown")
async def shutdown_event():
    connection.close()


@app.post("/signin")
async def sign_in(user_id: str = Form(...), password: str = Form(...)):
    query = db.select([table]).where(table.columns.user_account == user_id)

    result_proxy = connection.execute(query)
    result = result_proxy.fetchall()

    print(result)
    if not result:
        return {"state": 400, "message": "no login information"}

    hashed_password = result[0][2]
    if verify_password(password, hashed_password):
        return {"state": 200,
                "access_token": generate_access_token(user_id),
                "refresh_token": generate_refresh_token(user_id),
                "message": "sign in successfully"}
    else:
        return {"state": 400, "message": "login information not matched"}


@app.post("/signup")
async def sign_up(user_id: str = Form(...), password: str = Form(...), user_name: str = Form(...)):
    query = db.select([table]).where(table.columns.user_account == user_id)

    result_proxy = connection.execute(query)
    result = result_proxy.fetchall()

    if result:
        return {"state": 400, "message": "Account already exist"}
    else:
        query = db.insert(table).values([None,
                                         user_id,
                                         get_hashed_password(password),
                                         user_name,
                                         0,
                                         None,
                                         None])
        result_proxy = connection.execute(query)
        result_proxy.close()
        return {"state": 200, "message": "sign up successfully"}
