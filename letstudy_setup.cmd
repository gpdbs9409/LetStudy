@echo off
:: 프로젝트 이름 설정
set projectRoot=LetStudy

:: 디렉토리 생성
mkdir %projectRoot%\src
mkdir %projectRoot%\scripts
mkdir %projectRoot%\include
mkdir %projectRoot%\data

:: 파일 생성 및 초기화
echo // main.c - 메인 프로그램 > %projectRoot%\src\main.c
echo // translation.c - 번역 호출 및 처리 > %projectRoot%\src\translation.c
echo // quiz.c - 퀴즈 생성 및 실행 > %projectRoot%\src\quiz.c
echo // file_io.c - 파일 입출력 처리 > %projectRoot%\src\file_io.c

echo # translation.h - 번역 관련 헤더 > %projectRoot%\include\translation.h
echo # quiz.h - 퀴즈 관련 헤더 > %projectRoot%\include\quiz.h
echo # file_io.h - 파일 입출력 관련 헤더 > %projectRoot%\include\file_io.h

echo # 학습 데이터 > %projectRoot%\data\input.txt
echo # 번역 출력 데이터 > %projectRoot%\data\output.txt

:: Python 스크립트 생성
echo # translate.py - 번역 처리 스크립트 > %projectRoot%\scripts\translate.py
echo # word_analysis.py - 단어 분석 스크립트 > %projectRoot%\scripts\word_analysis.py

:: Makefile 생성
echo CC=gcc > %projectRoot%\Makefile
echo CFLAGS=-Wall -Iinclude >> %projectRoot%\Makefile
echo OBJ=src/main.o src/translation.o src/quiz.o src/file_io.o >> %projectRoot%\Makefile
echo TARGET=letstudy_program >> %projectRoot%\Makefile
echo all: $(TARGET) >> %projectRoot%\Makefile
echo $(TARGET): $(OBJ) >> %projectRoot%\Makefile
echo ^    $(CC) $(CFLAGS) -o $(TARGET) $(OBJ) >> %projectRoot%\Makefile
echo src/main.o: src/main.c include/translation.h include/quiz.h include/file_io.h >> %projectRoot%\Makefile
echo ^    $(CC) $(CFLAGS) -c src/main.c -o src/main.o >> %projectRoot%\Makefile
echo src/translation.o: src/translation.c include/translation.h >> %projectRoot%\Makefile
echo ^    $(CC) $(CFLAGS) -c src/translation.c -o src/translation.o >> %projectRoot%\Makefile
echo src/quiz.o: src/quiz.c include/quiz.h >> %projectRoot%\Makefile
echo ^    $(CC) $(CFLAGS) -c src/quiz.c -o src/quiz.o >> %projectRoot%\Makefile
echo src/file_io.o: src/file_io.c include/file_io.h >> %projectRoot%\Makefile
echo ^    $(CC) $(CFLAGS) -c src/file_io.c -o src/file_io.o >> %projectRoot%\Makefile
echo clean: >> %projectRoot%\Makefile
echo ^    rm -f $(OBJ) $(TARGET) >> %projectRoot%\Makefile

:: README 생성
echo # LetStudy 프로젝트 > %projectRoot%\README.md
echo > %projectRoot%\README.md
echo ## 프로젝트 소개 >> %projectRoot%\README.md
echo CLI 기반 다국어 학습 시스템. >> %projectRoot%\README.md
echo - 파일 입출력 처리 >> %projectRoot%\README.md
echo - 번역 및 퀴즈 기능 >> %projectRoot%\README.md

:: 완료 메시지 출력
echo LetStudy 프로젝트 디렉토리와 파일 생성 완료!
