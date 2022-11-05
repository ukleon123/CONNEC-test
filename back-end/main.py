from uuid import uuid4
import sqlalchemy as db
from fastapi import FastAPI, Form

app = FastAPI()

engine = db.create_engine('sqlite:////Users/sungwoochoi/login')
metadata = db.MetaData()
connection = engine.connect()


@app.on_event("shutdown")
async def shutdown_event():
    connection.close()


@app.post("/signup")
async def login(user_id: str = Form(...), password: str = Form(...), user_name: str = Form(...)):
    table = db.Table('login', metadata, autoload=True, autoload_with=engine)
    query = db.select([table]).where(table.columns.user_account == user_id)

    result_proxy = connection.execute(query)
    result = result_proxy.fetchall()

    if result:
        return {"state": 400, "message": "Account already exist"}
    else:
        query = db.insert(table).values([None, user_id, password, user_name, 0, None, None])
        result_proxy = connection.execute(query)
        result_proxy.close()
        return {"state": 200, "message": "sign up successfully"}
