

# LetStudy - 멀티모드 학습 시스템

LetStudy는 소켓 기반 네트워크 프로그래밍을 활용하여 영어/중국어 학습을 위한 **퀴즈 모드**와 **번역 모드**를 제공하는 학습 플랫폼입니다. 멀티스레딩과 파일 입출력을 활용하여 효율적이고 유연한 서버-클라이언트 구조로 구현되었습니다.

---

## 📜 주요 기능
### 1. 퀴즈 모드
- 서버에서 영어/중국어 학습용 퀴즈를 제공하며, 클라이언트는 정답을 제출할 수 있습니다.
- 정답자와 정답은 모든 클라이언트에게 브로드캐스트됩니다.
- 퀴즈 데이터는 텍스트 파일(`data/input.txt`)에서 불러와 사용합니다.

### 2. 번역 모드
- 클라이언트에서 입력한 텍스트를 **영어** 또는 **중국어**로 번역합니다.
- Python `googletrans` 라이브러리를 활용하여 번역 기능을 구현했습니다.

### 3. 멀티클라이언트 지원
- 멀티스레드를 사용하여 여러 클라이언트가 동시에 서버에 연결 가능합니다.
- `mutex`를 사용하여 클라이언트 리스트를 안전하게 관리합니다.

---

## 🛠️ 기술 스택
- **프로그래밍 언어**: C, Python
- **네트워킹**: Socket API
- **멀티스레드**: pthread
- **파일 입출력**: fopen, fgets
- **번역**: googletrans (Python)
- **운영 체제**: Linux (Ubuntu)

---

## 🗂️ 디렉토리 구조
```
LetStudy/
├── src/                    # C 소스 파일
│   ├── server.c            # 서버 프로그램
│   ├── client.c            # 클라이언트 프로그램
├── scripts/                # Python 스크립트
│   ├── translate.py        # 번역 모드 구현
├── data/                   # 퀴즈 데이터
│   ├── input.txt           # 퀴즈 데이터 파일
├── README.md               # 리드미 파일
├── Makefile                # 컴파일 스크립트
```

---

## 🚀 실행 방법

### 1. 환경 설정
1. Python3 및 `googletrans` 라이브러리 설치:
   ```bash
   sudo apt update
   sudo apt install python3 python3-pip -y
   pip3 install googletrans==4.0.0-rc1
   ```
2. C 컴파일러 설치:
   ```bash
   sudo apt install build-essential -y
   ```

### 2. 컴파일
1. 프로젝트 루트 디렉토리에서 아래 명령어를 실행하여 컴파일:
   ```bash
   make
   ```

### 3. 실행
#### 서버 실행
```bash
./bin/server
```

#### 클라이언트 실행
```bash
./bin/client
```

---

## ⚙️ 시스템 구조
### 1. 서버-클라이언트 통신
- **Socket API**를 통해 클라이언트와 서버 간의 통신을 구현.
- 멀티스레드를 사용하여 동시에 여러 클라이언트 요청을 처리.

### 2. 파일 입출력
- `data/input.txt` 파일에서 퀴즈 데이터를 읽어 서버에서 클라이언트로 제공.

### 3. 멀티스레드와 Mutex
- 각 클라이언트 연결은 별도의 스레드로 처리.
- `mutex`를 활용하여 클라이언트 리스트의 안전한 동시 접근을 보장.

---

## 🧐 한계점 및 개선 사항
1. **멀티스레드 디버깅의 어려움**:
   - 여러 클라이언트가 동시에 연결될 때 발생하는 메시지 출력 오류가 간헐적으로 나타남.
2. **번역 정확도**:
   - Google Translate API를 사용하므로 번역 품질은 API에 의존.
3. **에러 처리 부족**:
   - 클라이언트가 강제로 종료될 경우, 해당 연결이 즉시 해제되지 않을 가능성이 있음.

---


---

## 📌 참고
- [Googletrans 라이브러리](https://github.com/ssut/py-googletrans)
- [POSIX Threads (pthreads)](https://man7.org/linux/man-pages/man7/pthreads.7.html)

---
