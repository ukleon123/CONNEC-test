import uuid

import sqlalchemy as db
from fastapi import FastAPI, Form
from pydantic import BaseModel

from utils import *


app = FastAPI()


# need to change this area
engine = db.create_engine('sqlite:///../../database/Connec')
metadata = db.MetaData()
connection = engine.connect()
user_table = db.Table('user', metadata, autoload=True, autoload_with=engine)
auth_table = db.Table('login', metadata, autoload=True, autoload_with=engine)


class User(BaseModel):
    user_id: Union[str, None]
    user_name: str
    user_job: str
    user_career: str
    user_location: str
    user_gender: str
    user_capable: str
    user_introduction: str


class Auth(BaseModel):
    user_id: Union[str, None]
    user_email: str
    user_password: str
    user_authority: Union[str, None]
    social_code: Union[str, None]


@app.on_event("shutdown")
async def shutdown_event():
    connection.close()


@app.post("/signin")
async def sign_in(auth: Auth) -> dict:
    print(auth)
    query = db.select([auth_table]).where(auth_table.columns.user_email == auth.user_email)

    result_proxy = connection.execute(query)
    result = result_proxy.fetchall()

    print(result)
    if not result:
        return {"state": 400, "message": "no login information"}

    user_id = result[0][0]
    hashed_password = result[0][2]

    if verify_password(auth.user_password, hashed_password):
        return {"state": 200,
                "access_token": generate_access_token(user_id),
                "refresh_token": generate_refresh_token(user_id),
                "message": "sign in successfully"}
    else:
        return {"state": 400, "message": "login information not matched"}


@app.post("/signup")
async def sign_up(user: User, auth: Auth):
    user_id = generate_user_id()
    query = db.select([auth_table]).where(auth_table.columns.user_email == auth.user_email)

    result_proxy = connection.execute(query)
    result = result_proxy.fetchall()

    if result:
        return {"state": 400, "message": "Account already exist"}
    else:
        user.user_id = user_id
        auth.user_id = user_id

        auth.user_authority = 0
        auth.user_password = get_hashed_password(auth.user_password)
        print(user)
        print(auth)

        query = db.insert(user_table).values(user.__dict__)
        result_proxy = connection.execute(query)
        result_proxy.close()

        query = db.insert(auth_table).values(auth.__dict__)
        result_proxy = connection.execute(query)
        result_proxy.close()

        return {"state": 200, "message": "sign up successfully"}
