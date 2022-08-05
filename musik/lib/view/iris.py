from flask import Flask, jsonify, render_template, request
import joblib

app = Flask(__name__)

@app.route("/iris")
def iris():
    sepalLength = float(request.args.get("sepalLength"))
    sepalWidth = float(request.args.get("sepalWidth"))
    petalLength = float(request.args.get("petalLength"))
    petalWidth = float(request.args.get("petalWidth"))

    clf = joblib.load("./rf_iris.h5")
    pre = clf.predict([[sepalLength, sepalWidth, petalLength, petalWidth]])
    print(pre)
    return jsonify({'result' : pre[0][5:]})

def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)