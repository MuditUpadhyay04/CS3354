from flask import Flask, render_template, jsonify, request
import subprocess
import os

app = Flask(__name__)

# Load dataset
# file_path = "data1.csv"
# data = pd.read_csv(file_path)

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
def Nutrition_Guidance():
    return render_template('Nutrition_Guidance.html')

@app.route('/workout.html')
def Workout():
    return render_template('workout.html')

@app.route('/progresstracker.html')
def Progresstracker():
    return render_template('progresstracker.html')


    
if __name__ == "__main__":
    app.run(debug=True)
