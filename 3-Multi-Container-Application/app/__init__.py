from flask import Flask
from app.config import Config
from app.db import db
from flask_migrate import Migrate
from app.routes import routes

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    Migrate(app, db)

    app.register_blueprint(routes)

    return app
