from crypt import methods
from flask import Flask, request, jsonify # flutter은 json을 씀
import pandas as pd
import numpy as np
from konlpy.tag import Okt
import markov
import json
import urllib.request
from bs4 import BeautifulSoup
import random

app = Flask(__name__)

@app.route('/markov')
def markov():
# 감정값으로 happy를 받았을때----------------------------------------------------------
    emotion = request.args.get("emotion") # emotion 감정값 받아오기
    if emotion == 'happy':
        import markov
        file = open("../Data/ballad_lyrics_happy.csv",encoding='UTF-8')
        text = str(file.readlines())
        text = text.split(",")[1:]
        total = ""
        for i in range(len(text)):
            total += " " + text[i] + "."

        # txt
        dict_file = "markov_ballad.json"
        ballad_file = total

        # 텍스트를 한 줄씩 처리하기
        twitter = Okt()
        lines = total.split("\n")
        for line in lines:
            malist = twitter.pos(line,norm=True,stem=False)
            words = []
            for word in malist:
                if not word[1] in ['Alpha','Punctuation']: # .(마침표)제외한 ? "" ! 를 사용하지 않음
                    words.append(word[0])
                if word[0] == ".":
                    words.append(word[0])
        # 딕셔너리 생성
        dic = markov.make_dic(words)
        json.dump(dic,open(dict_file,"w",encoding="utf-8"))
        dic = json.load(open(dict_file,"r"))


        def make_sentence(dic):
            ret = []
            if not "@" in dic: return "no dic" 
            top = dic["@"]
            w1 = word_choice(top)
            w2 = word_choice(top[w1])
            ret.append(w1)
            ret.append(w2)
            while True:
                try:
                    w3 = word_choice(dic[w1][w2])
                    ret.append(w3)
                except:
                    continue
                # if w3 == ".": break
                if len(ret) >= 100: break
                w1, w2 = w2, w3
            ret = "".join(ret)
            # 띄어쓰기
            params = urllib.parse.urlencode({
                "_callback": "",
                "q": ret
            })
            # 네이버 맞춤법 검사기를 사용합니다.
            # data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?" + params)
            data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/spellchecker.nhn?" + params)
            data = data.read().decode("utf-8")[1:-2]
            data = json.loads(data)
            data = data["message"]["result"]["html"]
            data = soup = BeautifulSoup(data, "html.parser").getText()
            # 리턴
            return data

        def word_choice(sel):
            keys = sel.keys()
            return random.choice(list(keys))
        s = make_sentence(dic)  
        return jsonify({'result' : s})


#감정값으로 sad를 받았을때 ---------------------------------------------------------------------------- 
    elif emotion== "sad":
        import markov
        file = open("../Data/ballad_lyrics_sad.csv",encoding='UTF-8')
        text = str(file.readlines())
        text = text.split(",")[1:]
        total = ""
        for i in range(len(text)):
            total += " " + text[i] + "."

        # txt
        dict_file = "markov_ballad_sad.json"
        ballad_file = total

        # 텍스트를 한 줄씩 처리하기
        twitter = Okt()
        lines = total.split("\n")
        for line in lines:
            malist = twitter.pos(line,norm=True,stem=False)
            words = []
            for word in malist:
                if not word[1] in ['Alpha','Punctuation']: # .(마침표)제외한 ? "" ! 를 사용하지 않음
                    words.append(word[0])
                if word[0] == ".":
                    words.append(word[0])
        # 딕셔너리 생성
        dic = markov.make_dic(words)
        json.dump(dic,open(dict_file,"w",encoding="utf-8"))
        dic = json.load(open(dict_file,"r"))

        def make_sentence(dic):
            ret = []
            if not "@" in dic: return "no dic" 
            top = dic["@"]
            w1 = word_choice(top)
            w2 = word_choice(top[w1])
            ret.append(w1)
            ret.append(w2)
            while True:
                try:
                    w3 = word_choice(dic[w1][w2])
                    ret.append(w3)
                except:
                    continue
                # if w3 == ".": break
                if len(ret) >= 100: break
                w1, w2 = w2, w3
            ret = "".join(ret)
            # 띄어쓰기
            params = urllib.parse.urlencode({
                "_callback": "",
                "q": ret
            })
            # 네이버 맞춤법 검사기를 사용합니다.
            # data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?" + params)
            data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/spellchecker.nhn?" + params)
            data = data.read().decode("utf-8")[1:-2]
            data = json.loads(data)
            data = data["message"]["result"]["html"]
            data = soup = BeautifulSoup(data, "html.parser").getText()
            # 리턴
            return data

        def word_choice(sel):
            keys = sel.keys()
            return random.choice(list(keys))
        s = make_sentence(dic)  
        return jsonify({'result' : s})

# 감정값으로 무관심을 받았을떄--------------------------------------------------------------------------------
    else:
        import markov
        file = open("../Data/ballad_lyrics_indf.csv",encoding='UTF-8')
        text = str(file.readlines())
        text = text.split(",")[1:]
        total = ""
        for i in range(len(text)):
            total += " " + text[i] + "."

        # txt
        dict_file = "markov_ballad_indf.json"
        ballad_file = total

        # 텍스트를 한 줄씩 처리하기
        twitter = Okt()
        lines = total.split("\n")
        for line in lines:
            malist = twitter.pos(line,norm=True,stem=False)
            words = []
            for word in malist:
                if not word[1] in ['Alpha','Punctuation']: # .(마침표)제외한 ? "" ! 를 사용하지 않음
                    words.append(word[0])
                if word[0] == ".":
                    words.append(word[0])
        # 딕셔너리 생성
        dic = markov.make_dic(words)
        json.dump(dic,open(dict_file,"w",encoding="utf-8"))
        dic = json.load(open(dict_file,"r"))


        def make_sentence(dic):
            ret = []
            if not "@" in dic: return "no dic" 
            top = dic["@"]
            w1 = word_choice(top)
            w2 = word_choice(top[w1])
            ret.append(w1)
            ret.append(w2)
            while True:
                try:
                    w3 = word_choice(dic[w1][w2])
                    ret.append(w3)
                except:
                    continue
                # if w3 == ".": break
                if len(ret) >= 100: break
                w1, w2 = w2, w3
            ret = "".join(ret)
            # 띄어쓰기
            params = urllib.parse.urlencode({
                "_callback": "",
                "q": ret
            })
            # 네이버 맞춤법 검사기를 사용합니다.
            # data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?" + params)
            data = urllib.request.urlopen("https://m.search.naver.com/p/csearch/ocontent/spellchecker.nhn?" + params)
            data = data.read().decode("utf-8")[1:-2]
            data = json.loads(data)
            data = data["message"]["result"]["html"]
            data = soup = BeautifulSoup(data, "html.parser").getText()
            # 리턴
            return data

        def word_choice(sel):
            keys = sel.keys()
            return random.choice(list(keys))
        s = make_sentence(dic)  
        return jsonify({'result' : s})


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5010, debug=True)