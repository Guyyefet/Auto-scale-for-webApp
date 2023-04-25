from flask import Flask, request

# def create_app():
#     app = Flask(__name__)
    
app = Flask(__name__)

dummyData = 'dummyData'


@app.route('/dummy')
def getdummy():
    return dummyData

if __name__ == '__main__':
    app.run(debug=True)
    app.run(host="0.0.0.0", port=8080)