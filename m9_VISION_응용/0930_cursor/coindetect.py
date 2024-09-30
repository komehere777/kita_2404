import cv2
import os
import numpy as np
import matplotlib.pyplot as plt
import sys
from flask import Flask, request, jsonify

app = Flask(__name__)

# 1. 전처리 함수 (Preprocessing Function)
def preprocessing(image_path):
    print(f"이미지 파일 경로: {image_path}")
    img = cv2.imread(image_path, cv2.IMREAD_COLOR)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blur = cv2.GaussianBlur(gray, (7, 7), 2, 2)
    flag = cv2.THRESH_BINARY + cv2.THRESH_OTSU
    _, th_img = cv2.threshold(blur, 130, 255, flag)
    mask = np.ones((3, 3), np.uint8)
    th_img = cv2.morphologyEx(th_img, cv2.MORPH_OPEN, mask)
    return img, th_img

# 2. 동전 찾기 함수 (Coin Detection Function)
def find_coins(img):
    result = cv2.findContours(img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    countours = result[0] if int(cv2.__version__[0]) >= 4 else result[1]

    circles = [cv2.minEnclosingCircle(c) for c in countours]
    circles = [(tuple(map(int, center)), int(radius)) for center, radius in circles if radius > 25]
    return circles

# 3. 각각의 동전 이미지를 추출 (Coin Image Creation Function)
def make_coin_img(src, circles):
    coins = []
    for center, radius in circles:
        r = radius * 3
        cen = (r // 2, r // 2)
        mask = np.zeros((r, r, 3), np.uint8)
        cv2.circle(mask, cen, radius, (255, 255, 255), cv2.FILLED)

        coin = cv2.getRectSubPix(src, (r, r), center)
        coin = cv2.bitwise_and(coin, mask)
        coins.append(coin)
    return coins

# 4. 동전 이미지에서 히스토그램 계산 (Histogram Calculation Function)
def calc_histo_hue(coin):
    hsv = cv2.cvtColor(coin, cv2.COLOR_BGR2HSV)
    hsize, ranges = [32], [0, 180]
    hist = cv2.calcHist([hsv], [0], None, hsize, ranges)
    return hist.flatten()

# 5. 동전의 히스토그램을 이용해 그룹 분류 (Coin Grouping Function)
def grouping(coin_hists):
    ws = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3,
          4, 5, 6, 8, 6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0]

    if len(coin_hists) == 0:
        print("경고: coin_hists가 비어 있습니다.")
        return []
    
    hists = np.array(coin_hists)
    if hists.shape[0] == 0:
        print("경고: hists 배열이 비어 있습니다.")
        return []

    sim = np.multiply(hists, ws)
    similaritys = np.sum(sim, axis=1) / np.sum(hists, axis=1)
    groups = [1 if s > 1.2 else 0 for s in similaritys]

    return groups

# 6. 동전 분류 및 카운팅 (Coin Classification Function)
def classify_coins(circles, groups):
    ncoins = [0] * 4

    g = np.full((2, 70), -1, np.int32)
    g[0, 26:47], g[0, 47:50], g[0, 50:] = 0, 2, 3
    g[1, 36:44], g[1, 44:50], g[1, 50:] = 1, 2, 3

    for group, (_, radius) in zip(groups, circles):
        coin = g[group, radius]
        ncoins[coin] += 1

    return np.array(ncoins)

def put_string(frame, text, pt, value=None, color=(120,200,90)):
  text = str(text) + str(value)
  shade = (pt[0] + 2, pt[1] + 2)
  font = cv2.FONT_HERSHEY_SIMPLEX
  cv2.putText(frame, text, shade, font, 0.7, (0, 0, 0), 2)
  cv2.putText(frame, text, pt, font, 0.7, color, 2)

@app.route('/detect', methods=['POST'])
def detect():
    if 'image' not in request.files:
        return jsonify({'error': '이미지 파일을 업로드해주세요.'}), 400

    file = request.files['image']
    image_path = os.path.join('uploads', file.filename)
    file.save(image_path)

    img, th_img = preprocessing(image_path)
    circles = find_coins(th_img)
    coin_imgs = make_coin_img(img, circles)
    coin_hists = [calc_histo_hue(coin) for coin in coin_imgs]
    groups = grouping(coin_hists)
    ncoins = classify_coins(circles, groups)
    coin_value = np.array([10,50,100,500])
    result = {f"{coin_value[i]}원": int(ncoins[i]) for i in range(4)}
    
    total = sum(coin_value * ncoins)
    result['total'] = f"{total:,} Won"

    return jsonify(result)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)