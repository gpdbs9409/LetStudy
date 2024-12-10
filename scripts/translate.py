from googletrans import Translator

def translate_text(text, target_language):
    """
    텍스트를 지정된 언어로 번역합니다.
    :param text: 번역할 텍스트
    :param target_language: 번역 대상 언어 ('zh-cn' 또는 'en')
    :return: 번역된 텍스트
    """
    translator = Translator()
    try:
        translated = translator.translate(text, dest=target_language)
        return translated.text
    except Exception as e:
        return f"번역 중 오류 발생: {str(e)}"

def main():
    print("LetStudy 번역 프로그램")
    print("번역 모드: 'zh-cn'(중국어), 'en'(영어) 중 선택")
    target_language = input("번역할 언어를 선택하세요 ('zh-cn' 또는 'en'): ").strip()

    if target_language not in ['zh-cn', 'en']:
        print("잘못된 언어 코드입니다. 프로그램을 종료합니다.")
        return

    print("번역할 문장을 입력하세요. 종료하려면 'exit'를 입력하세요.")

    while True:
        text = input("입력: ").strip()
        if text.lower() == 'exit':
            print("프로그램을 종료합니다.")
            break

        translated_text = translate_text(text, target_language)
        print(f"번역 결과: {translated_text}")

if __name__ == "__main__":
    main()
