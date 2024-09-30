# Coin Detect App에서 사용된 Backend 주요 내용

이 문서에서는 Coin Detect App의 백엔드에서 사용된 주요 내용과 구현 방법을 설명합니다.

강사님은 백엔드 폴더 안만듬

app.py, coindetect.py, server.js로 구성

## 주요 개념

### 1. Flask
Flask는 Python으로 작성된 마이크로 웹 프레임워크로, 간단하고 유연한 웹 애플리케이션을 개발할 수 있게 해줍니다. 이 앱에서는 Flask를 사용하여 서버를 구축하고, 클라이언트와의 통신을 처리합니다.

### 2. Flask-CORS
Flask-CORS는 Flask 애플리케이션에서 Cross-Origin Resource Sharing (CORS)을 쉽게 설정할 수 있게 해주는 확장입니다. 이 앱에서는 클라이언트와 서버 간의 CORS 문제를 해결하기 위해 사용됩니다.

### 3. OpenCV
OpenCV는 컴퓨터 비전 작업을 위한 라이브러리로, 이미지 처리 및 분석에 사용됩니다. 이 앱에서는 OpenCV를 사용하여 이미지에서 동전을 감지하고 분류합니다.

### 4. NumPy
NumPy는 수치 연산을 위한 라이브러리로, 배열 및 행렬 연산을 효율적으로 처리할 수 있게 해줍니다. 이 앱에서는 동전의 히스토그램 계산 및 분류에 사용됩니다.

## 상세 가이드 라인

### 1. 프로젝트 설정

1. 가상 환경을 설정하고 필요한 패키지를 설치합니다.
   ```bash
   python -m venv myenv
   source myenv/bin/activate  # Windows에서는 myenv\Scripts\activate
   pip install flask flask-cors numpy opencv-python
   ```

2. 프로젝트 디렉토리 구조를 설정합니다.
   ```
   coin-detect-app/
   ├── app.py # api 만들기
   ├── coindetect.py # 동전 감지 로직
   ├── uploads/
   └── requirements.txt
   ```

3. `requirements.txt` 파일에 필요한 패키지를 명시합니다.
   ```text
   flask
   flask-cors
   numpy
   opencv-python
   ```

### 2. 주요 파일 설명

#### app.py
Flask 애플리케이션의 진입점으로, 서버를 설정하고 클라이언트 요청을 처리합니다. 이 파일에서는 Flask 애플리케이션 객체를 생성하고, 필요한 라우트를 정의하며, CORS 설정을 포함합니다. 또한, 클라이언트로부터 업로드된 이미지를 처리하고, 동전 감지 및 분류 결과를 반환하는 API 엔드포인트를 제공합니다. 서버는 `app.run()` 메서드를 호출하여 실행됩니다.

`app.run()` 메서드는 Flask 애플리케이션을 실행하는 데 사용됩니다. 이 메서드는 Flask 개발 서버를 시작하고, 지정된 호스트와 포트에서 클라이언트 요청을 수신 대기합니다. 기본적으로 `app.run()`은 로컬 호스트(`127.0.0.1`)와 포트 `5000`에서 실행되지만, `host`와 `port` 매개변수를 사용하여 이를 변경할 수 있습니다. 예를 들어, `app.run(host='0.0.0.0', port=8000)`은 모든 네트워크 인터페이스에서 포트 `8000`으로 서버를 실행합니다. 또한, `debug=True` 옵션을 사용하면 디버그 모드가 활성화되어 코드 변경 시 자동으로 서버가 재시작되고, 에러 메시지가 브라우저에 표시됩니다.

### 3. Node.js Express 서버

Node.js는 JavaScript 런타임 환경으로, 서버 사이드 애플리케이션을 개발할 수 있게 해줍니다. Express는 Node.js를 위한 빠르고 간결한 웹 프레임워크로, 다양한 HTTP 유틸리티 메서드와 미들웨어를 제공하여 강력한 API를 쉽게 구축할 수 있게 해줍니다. 이 앱에서는 Express를 사용하여 `클라이언트와 Flask 서버 간의 프록시 역할`을 수행합니다. 이게 중요함, 프록시 역할 - 중간에서 대신 처리하는 역할 

#### Express 서버 설정

1. Node.js와 npm을 설치합니다.
   ```bash
   sudo apt install nodejs npm
   ```

2. 프로젝트 디렉토리에서 `package.json` 파일을 생성하고 필요한 패키지를 설치합니다.
   ```bash
   npm init -y
   npm install express http-proxy-middleware path
   ```

3. `server.js` 파일을 생성하고 Express 서버를 설정합니다.
   ```javascript
   const express = require('express');
   const { createProxyMiddleware } = require('http-proxy-middleware');
   const path = require('path');

   const app = express();
   const port = 3000;

   app.use(express.static(path.join(__dirname, 'client/build')));

   // Flask 서버로 프록시 설정
   app.use('/upload', createProxyMiddleware({ target: 'http://localhost:5000', changeOrigin: true }));

   app.get('*', (req, res) => {
     res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
   });

   app.listen(port, () => {
     console.log(`Server is running on port ${port}`);
   });
   ```

### 4. Node.js Express와 Flask의 연동

이 앱에서는 Node.js Express 서버와 Flask 서버가 함께 작동하여 클라이언트 요청을 처리합니다. 클라이언트는 React 애플리케이션을 통해 이미지를 업로드하고, 이 요청은 Express 서버로 전달됩니다. Express 서버는 `http-proxy-middleware`를 사용하여 해당 요청을 Flask 서버로 프록시합니다. Flask 서버는 이미지를 처리하고 동전을 감지 및 분류한 결과를 반환합니다. 이 결과는 다시 Express 서버를 통해 클라이언트로 전달됩니다.

개발 단계에서는 Flask 서버를 사용하여 이미지를 처리하고 결과를 반환하지만, 프로덕션 단계에서는 Express 서버가 이 역할을 대신하게 됩니다. 이로 인해 기존 개발 코드가 변경될 수 있습니다. 예를 들어, Flask 서버에서 처리하던 이미지 업로드 및 동전 감지 로직을 Express 서버로 이전해야 하며, 이에 따라 API 엔드포인트와 관련된 코드도 수정이 필요합니다. 또한, Express 서버에서 Flask 서버로 프록시하던 로직을 제거하고, 직접 이미지를 처리하는 로직을 추가해야 합니다.

개발 단계와 프로덕션 단계의 차이
개발 단계: Flask 서버가 이미지를 처리하고 결과를 반환합니다.
프로덕션 단계: Express 서버가 이미지를 처리하고 결과를 반환합니다. 이로 인해 기존 개발 코드가 변경될 수 있습니다.
코드 변경 사항
Flask 서버에서 이미지 처리 로직 제거:
Flask 서버에서 이미지 업로드 및 동전 감지 로직을 제거합니다.
API 엔드포인트와 관련된 코드를 수정합니다.
Express 서버에서 이미지 처리 로직 추가:
Express 서버에서 직접 이미지를 처리하는 로직을 추가합니다.
http-proxy-middleware를 사용한 프록시 로직을 제거합니다.

코드 예시
Flask 서버 (app.py)
기존 Flask 서버에서 이미지 처리 로직을 제거합니다.
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/upload', methods=['POST'])
def upload_file():
    # 이미지 처리 로직 제거
    return jsonify({"message": "This endpoint is deprecated."})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

Express 서버 (server.js)
Express 서버에서 이미지를 처리하는 로직을 추가합니다.
const express = require('express');
const multer = require('multer');
const path = require('path');
const cv = require('opencv4nodejs'); // OpenCV 사용을 위한 라이브러리

const app = express();
const port = 3000;

// 이미지 업로드 설정
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

app.use(express.static(path.join(__dirname, 'client/build')));

// 이미지 업로드 및 처리 엔드포인트
app.post('/upload', upload.single('image'), (req, res) => {
  const imageBuffer = req.file.buffer;
  const image = cv.imdecode(imageBuffer);

  // OpenCV를 사용한 이미지 처리 로직 추가
  // 예: 동전 감지 및 분류
  const result = detectAndClassifyCoins(image);

  res.json(result);
});

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

// 동전 감지 및 분류 함수 (예시)
function detectAndClassifyCoins(image) {
  // OpenCV를 사용한 동전 감지 및 분류 로직 구현
  return { message: "Coins detected and classified." };
}