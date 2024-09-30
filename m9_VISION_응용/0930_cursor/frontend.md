# Coin Detect App에서 사용된 React 문법 및 주요 내용

이 문서에서는 Coin Detect App에서 사용된 React 문법과 주요 내용을 설명합니다.

## 주요 개념

### 1. React 컴포넌트
React 컴포넌트는 UI를 구성하는 기본 단위입니다. 함수형 컴포넌트와 클래스형 컴포넌트가 있으며, 이 앱에서는 함수형 컴포넌트를 사용합니다.

### 2. useState 훅
`useState` 훅은 함수형 컴포넌트에서 상태를 관리하기 위해 사용됩니다. 이 앱에서는 파일 선택, 결과, 오류 상태를 관리하기 위해 `useState` 훅을 사용합니다.

## 상세 가이드 라인

### 1. 프로젝트 설정
1. `create-react-app`을 사용하여 프로젝트를 생성합니다.
   ```bash
   npx create-react-app coin-detect-app
   cd coin-detect-app
   ```
   ```bash 강사님 코드
   npx create-react-app client
   cd client
   ```

2. 필요한 패키지를 설치합니다.
   ```bash
   npm install axios react-bootstrap bootstrap
   ```

3. `src` 디렉토리에 `App.js`, `App.css`, `index.js` 파일을 수정합니다.
   - `App.js`: 메인 컴포넌트 파일로, 파일 선택 및 업로드 기능을 구현합니다. `useState` 훅을 사용하여 상태를 관리하고, `handleFileChange`와 `handleSubmit` 함수를 정의합니다.
   - `App.css`: 스타일 시트 파일로, 앱의 전반적인 스타일을 정의합니다. 결과 컨테이너, 요약, 항목 등의 스타일을 포함합니다.
   - `index.js`: 진입점 파일로, ReactDOM을 사용하여 `App` 컴포넌트를 루트 엘리먼트에 렌더링합니다.

### 2. 주요 컴포넌트 및 훅 사용

#### App 컴포넌트
- `useState` 훅을 사용하여 파일, 결과, 오류 상태를 관리합니다. `useState`는 React에서 상태 관리를 위해 제공하는 훅으로, 상태 변수와 해당 상태를 갱신할 수 있는 함수를 반환합니다. 예를 들어, `[file, setFile] = useState(null)`은 `file` 상태 변수와 `setFile` 상태 갱신 함수를 정의합니다.
- 파일 선택을 처리하는 `handleFileChange` 함수와 파일 업로드를 처리하는 `handleSubmit` 함수를 정의합니다. `handleFileChange` 함수는 사용자가 파일을 선택할 때 호출되며, 선택된 파일을 상태로 저장합니다. `handleSubmit` 함수는 사용자가 파일을 업로드할 때 호출되며, 서버로 파일을 전송하고 결과를 받아 상태로 저장합니다. 이 함수는 비동기 함수로 작성되어, `async`와 `await` 키워드를 사용하여 비동기 작업을 처리합니다.
