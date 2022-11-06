import os

from passlib.context import CryptContext

import os
from typing import Union, Any
from datetime import datetime, timedelta

from jose import jwt

password_context = CryptContext(schemes=['bcrypt'], deprecated='auto')

AccessTokenExpireMinutes = 30
RefreshTokenExpireMinutes = 30

SecretAccessKey = os.environ['JWT_ACCESS_SECRET_KEY']
SecretRefreshKey = os.environ['JWT_REFRESH_SECRET_KEY']


def get_hashed_password(password: str) -> str:
    return password_context.hash(password)


def verify_password(password: str, hashed_password: str) -> bool :
    return password_context.verify(password, hashed_password)


def generate_access_token(subject: Union[str, Any], expires_delta: int = None) -> str:
    if expires_delta:
        expires_delta = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=AccessTokenExpireMinutes)

    target = {"exp": expires_delta, "sub": subject}
    encoded_token = jwt.encode(target, SecretAccessKey)

    return encoded_token


def generate_refresh_token(subject: Union[str, Any], expires_delta: int = None):
    if expires_delta:
        expires_delta = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=RefreshTokenExpireMinutes)

    target = {"exp": expires_delta, "sub": subject}
    encoded_token = jwt.encode(target, SecretRefreshKey)

    return encoded_token

