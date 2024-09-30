from flask import Flask, request, jsonify
import os
import numpy as np
from coindetect import preprocessing, find_coins, make_coin_img, calc_histo_hue, grouping, classify_coins

app = Flask(__name__)

# 업로드된 파일을 저장할 디렉토리 설정
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/detect', methods=['POST'])
def detect():
    if 'image' not in request.files:
        return jsonify({'error': '이미지 파일을 업로드해주세요.'}), 400

    file = request.files['image']
    image_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
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