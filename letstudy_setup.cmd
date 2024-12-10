@echo off
:: ������Ʈ �̸� ����
set projectRoot=LetStudy

:: ���丮 ����
mkdir %projectRoot%\src
mkdir %projectRoot%\scripts
mkdir %projectRoot%\include
mkdir %projectRoot%\data

:: ���� ���� �� �ʱ�ȭ
echo // main.c - ���� ���α׷� > %projectRoot%\src\main.c
echo // translation.c - ���� ȣ�� �� ó�� > %projectRoot%\src\translation.c
echo // quiz.c - ���� ���� �� ���� > %projectRoot%\src\quiz.c
echo // file_io.c - ���� ����� ó�� > %projectRoot%\src\file_io.c

echo # translation.h - ���� ���� ��� > %projectRoot%\include\translation.h
echo # quiz.h - ���� ���� ��� > %projectRoot%\include\quiz.h
echo # file_io.h - ���� ����� ���� ��� > %projectRoot%\include\file_io.h

echo # �н� ������ > %projectRoot%\data\input.txt
echo # ���� ��� ������ > %projectRoot%\data\output.txt

:: Python ��ũ��Ʈ ����
echo # translate.py - ���� ó�� ��ũ��Ʈ > %projectRoot%\scripts\translate.py
echo # word_analysis.py - �ܾ� �м� ��ũ��Ʈ > %projectRoot%\scripts\word_analysis.py

:: Makefile ����
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

:: README ����
echo # LetStudy ������Ʈ > %projectRoot%\README.md
echo > %projectRoot%\README.md
echo ## ������Ʈ �Ұ� >> %projectRoot%\README.md
echo CLI ��� �ٱ��� �н� �ý���. >> %projectRoot%\README.md
echo - ���� ����� ó�� >> %projectRoot%\README.md
echo - ���� �� ���� ��� >> %projectRoot%\README.md

:: �Ϸ� �޽��� ���
echo LetStudy ������Ʈ ���丮�� ���� ���� �Ϸ�!
