from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash

# 관계형 데이터베이스를 사용하기 위한 객체 생성
# 각 다른 데이터베이스를 사용할 수 있음
db = SQLAlchemy()  # db 객체 생성, db와 app을 연결

# Task 테이블 생성

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)


class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.Date, nullable=False, default=datetime.utcnow)
    due_date = db.Column(db.Date, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    user = db.relationship("User", backref=db.backref("tasks", lazy=True))
