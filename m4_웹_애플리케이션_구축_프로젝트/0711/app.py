from flask import Flask, request, jsonify, request, redirect, url_for, render_template, flash, session
from flask_migrate import Migrate
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
from form import TaskForm, LoginForm, RegistrationForm
from models import Task, db, User

# 앱 초기화
app = Flask(__name__)
app.config.from_pyfile("config.py")  # 시크릿 키 설정 - 악의적 공격을 막기 위해 사용

# 앱 실행전 준비작업
# 개별 파일로 분리할 수 있음. models.py
db.init_app(app)  # db 객체 생성, db와 app을 연결, 관계형 디비를 객체지향형 테이블로 사용
migrate = Migrate(app, db)  # migrate 객체 생성, migrate와 app을 연결, db 변경사항을 관리
csrf = CSRFProtect(app)

# 로그인하면 세션 생성, 저장된 세션을 통해 로그인 유지,  세션은 커뮤니케이션하는 상태
# 유저 id로 세션이 생성되어 있으면 로그인 상태로 판단, 로그아웃하면 세션 삭제

# @app.before_request
# def create_admin():
#     with app.app_context():
#         if not User.query.filter_by(username='admin').first():
#             admin = User(username='admin', is_admin=True)
#             admin.set_password('admin')
#             db.session.add(admin)
#             db.session.commit()


@app.route("/register", methods=["GET", "POST"])
def register():
    csrf_token = form.csrf_token._value()
    form = RegistrationForm()
    if form.validate_on_submit():
        # 사용자명 중복 확인
        existing_user = User.query.filter_by(username=form.username.data).first()
        if existing_user:
            flash(
                "Username already exists. Please choose a different username.", "danger"
            )
            return render_template("register.html", form=form)
        username = form.username.data
        password = form.password.data
        user = User(username=username)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        flash("Registration successful. Please log in.", "success")
        return redirect(url_for("login"))
    return render_template("register.html", form=form)


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user and check_password_hash(user.password, form.password.data):
            session['user_id'] = user.id
            session['username'] = user.username
            session['is_admin'] = user.is_admin
            flash('로그인 성공', 'success')
            return redirect(url_for('index'))
        else:
            flash('로그인 실패', 'danger')
    return render_template('login.html', form=form)

@app.route('/logout')
def logout():
    session.clear()
    flash('로그아웃 성공', 'success')
    return redirect(url_for('login'))

@app.route('/')
def index():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    form = TaskForm()
    csrf_token = form.csrf_token._value()
    return render_template('index.html', form=form, csrf_token=csrf_token)

@app.route('/tasks') #자바스크립트로 처리, session에서 user_id별로 관리
def task():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    tasks = Task.query.filter_by(user_id=session['user_id']).all()
    return jsonify(
        [
            {
                'id':task.id,
                'title':task.title,
                'contents':task.contents, 
                'input_date':task.input_date.strftime('%Y-%m-%d'),
                'due_date': task.due_date.strftime('%Y-%m-%d'),
            }
            for task in tasks
        ]
    )

@app.route('/', methods=['POST'])
def add_task():
    if "user_id" not in session:
        return redirect(url_for("login"))
    
    form = TaskForm()
    if form.validate_on_submit():
        title = form.title.data
        contents = form.contents.data

        kst = pytz.timezone('Asia/Seoul')
        input_date = datetime.now(kst).date()

        due_date = form.due_date.data

        new_task = Task(
            title=title, 
            contents=contents, 
            input_date=input_date, 
            due_date=due_date, 
            user_id=session['user_id']
        )

        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()
    return render_template('index.html', form=form, csrf_token=csrf_token)

@app.route('/edit/<int:task_id>', methods=['GET', 'POST'])
def edit(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    
    task = Task.query.get_or_404(task_id)
    
    if task.user_id != session['user_id']:
        flash('edit 권한이 없습니다.', 'danger')
        return redirect(url_for('index'))
    
    form = TaskForm(obj=task)
    if request.method == 'POST' and form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.commit()
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()

    return render_template(
        'edit_task.html',
        form=form,
        task_id=task_id,
        csrf_token=csrf_token,
        task_title=task.title,
        task_contents=task.contents,
        task_input_date=task.input_date.strftime('%Y-%m-%d'),
        task_due_date=task.due_date.strftime('%Y-%m-%d'),
    )

@app.route('/delete/<int:task_id>')
def delete_task(task_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    task = Task.query.get_or_404(task_id)
    
    if task.user_id != session['user_id']:
        flash('delete 권한이 없습니다.', 'danger')
        return redirect(url_for('index'))
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('index'))


@app.route('/admin')
def admin():
    if 'user_id' not in session or not session.get('is_admin'):
        return redirect(url_for('login'))
    
    users = User.query.all()
    return render_template('admin.html', users=users)


if __name__ == '__main__':
    app.run(debug=True)
