from flask import Flask, jsonify, render_template, request
import joblib
from bayes import BayesianFilter
import pandas as pd

app = Flask(__name__)

@app.route("/bayes")
def bayes():
    diary = request.args.get("diary") # diary 감정값 받아오기

    emotion_df = pd.read_csv("../../Data/Bayes_emotion_df.csv")

    bf = BayesianFilter()
    for i in range(len(emotion_df)):
        bf.fit(str(emotion_df.iloc[i].문장),str(emotion_df.iloc[i].감정))

    pre, scorelist = bf.predict(diary)

    # 비율 구하기
    import math
    # list안에 tuple 꺼내기
    test = [x[1] for x in scorelist]
    max_score = max(test)

    # 결과값 0주기
    test_list = []
    for i in range(3):
        test_list.append((test[i] - (max_score)))

    #전체값 합
    sum_score = sum(test_list)

    # 결과 값
    test_list_sum = []
    for i in range(3):
        test_list_sum.append(test_list[i] - sum_score)

    test_list_result = []
    for i in range(3):
        test_list_result.append(test_list_sum[i] /sum(test_list_sum)*100)
    test_list_result
    # 각 감정들의 결과값을 리스트에 넣음 index - 0 : positive / 1 : neutral / 2 : negative
    result = []
    for i in range(3):
        result.append(round(test_list_result[i],1))

    # 결과값(result)을 jsonify로 넘김
    return jsonify({'result' : pre, # 최종 감정의 결과값
                    'positive' : result[0], # 긍정
                    'neutral' : result[1], # 중립
                    'negative' : result[2] # 부정
                    })

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)