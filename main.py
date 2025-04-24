from flask import Flask, render_template, jsonify, request, url_for
import os

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/index.html')
def index():
    return render_template('index.html')

@app.route('/login.html')
def login():
    return render_template('login.html')

@app.route('/main.html')
def main():
    return render_template('main.html')

@app.route('/Nutrition_Guidance.html')
def nutrition_guidance():
    return render_template('nutrition_guidance.html')

@app.route('/workout.html')
def workout():
    return render_template('workout.html')

@app.route('/progress_tracking.html')
def progress_tracking():
    return render_template('progress_tracking.html')
    
if __name__ == "__main__":
    app.run(debug=True)
