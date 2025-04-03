# HarryPotterReadingGuide
### Harry Potter 책 시리즈 정보를 제공하는 iOS 앱입니다. 
<img src = "https://teamsparta.notion.site/image/attachment%3A12af12eb-c9c2-4b91-b090-33faa38486cd%3A%E1%84%80%E1%85%AA%E1%84%8C%E1%85%A6_%E1%84%8A%E1%85%A5%E1%86%B7%E1%84%82%E1%85%A6%E1%84%8B%E1%85%B5%E1%86%AF_%E1%84%86%E1%85%A1%E1%84%89%E1%85%B3%E1%84%90%E1%85%A5_%E1%84%8B%E1%85%A2%E1%86%B8_%E1%84%80%E1%85%A2%E1%84%87%E1%85%A1%E1%86%AF_%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%86%E1%85%AE%E1%86%AB.png?table=block&id=1bf2dc3e-f514-818b-ab58-f7d0e4195ccc&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1420&userId=&cache=v2">

## 요구사항
<details>
<summary>Level 1</summary>
<div markdown="1">

### Level 1
<table>
  <tr>
    <td>
      <img src="https://teamsparta.notion.site/image/attachment%3A15d239ce-420c-491a-b230-f40499478da6%3Alevel_1.png?table=block&id=1bf2dc3e-f514-811a-a741-e87eb5585c83&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=400&userId=&cache=v2" width="200">
    </td>
    <td>
    <aside>
🧑🏻‍💻 `UILabel` 을 사용해서 책 제목을 표시하는 UILabel을 구현합니다.

- `data.json` 파일에 있는 데이터 가져오기
    - json 파일에 있는 데이터를 가져오기 위한 로직은 `DataService.swift`파일을 참고하여 구현합니다.
        
        [DataService.swift](attachment:81ed4e32-f601-42b1-8c07-072ad43ee9ad:DataService.swift)
        
- `data.json`에 있는 시리즈 전권에 대한 데이터 중 한 권 데이터를 UI에 표시합니다.
- 전체 시리즈(총 7권) 중에 한 권의 데이터를 UI로 표시합니다.
예를 들어 1권(시리즈 첫번째)인 경우 `1`, 
3권(시리즈 세번째)인 경우 `3`을 표시합니다. 
과제의 요구사항은 1권(시리즈 첫번째)를 예시로 작성했습니다.

---

- Json 데이터에서 해리포터 시리즈 첫번째 제목인 `Harry Potter and the Philosopher’s Stone` 을 표시합니다.
- 책 제목 밑에 시리즈 순서를 표시합니다.
    - 이후 도전 구현으로 해리포터 시리즈 7권의 책에 대해서 모두 확인할 수 있도록 구현합니다.
    - 지금 필수 구현에서는 하나의 숫자만 표시합니다.
- 책 제목 속성
    - 텍스트 가운데 정렬
    - Font = 시스템 볼드체, 사이즈 24
- 시리즈 순서 속성
    - 가운데 정렬
    - Font = 사이즈 16
    - `cornerRadius` 이용해 원형으로 표시
    - `backgroundColor` = `.systemBlue`
- **AutoLayout**
    - superView와 safeArea를 고려하여 제약 조건을 설정합니다.
    - 책 제목
        - `leading`, `trailing` = superView 로 부터 20 떨어지도록 세팅
        - `top` = safeArea 로 부터 10씩 떨어지도록 세팅
    - 시리즈 순서
        - `leading`, `trailing` = superView 로 부터 20 이상 떨어지도록 세팅
        - `top` = 책 제목으로부터 16 떨어지도록 세팅
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 2</summary>
<div markdown="1">

### Level 2
<table>
  <tr>
    <td>
      <img src="https://teamsparta.notion.site/image/attachment%3Add0e67ae-0f0d-423f-a8c8-41fe778ef992%3Alevel2.png?table=block&id=1bf2dc3e-f514-8197-a37d-e2e75687759b&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=400&userId=&cache=v2" width="200">
    </td>
    <td>
<aside>
🧑🏻‍💻 책 정보 영역을`UIStackView` 를 최대한 사용해 이미지와 텍스트를 왼쪽과 같이 구성해보세요.

- ‘책 정보 영역’은 이 영역을 의미합니다.
    
    ![Screenshot 2025-03-21 at 7.12.41 PM.png](attachment:691bec27-0e07-44a4-8368-535c7498367c:Screenshot_2025-03-21_at_7.12.41_PM.png)
    
- `DataService.loadBooks()`를 통해 Json 데이터를 가지고 오기 실패한 경우 Alert 창으로 에러의 원인을 사용자에게 알립니다.
- **책 표지 이미지 속성**
    - `width` = 100
    - height : width 비율은 `1:1.5`
    - `contentMode`는 어떤걸로 하면 좋을지 고민해보세요.
- **책 제목 속성**
    - Font = 시스템 볼드체, 사이즈 20, 색상 black
- **저자 속성**
    - 타이틀(*Author*) 속성
        - Font = 시스템 볼드체, 사이즈 16, 색상 black
    - 저자(*J. K. Rowling*) 속성
        - Font = 사이즈 18, 색상 darkGray
- **출간일 속성**
    - 타이틀(*Released*) 속성
        - Font = 시스템 볼드체, 사이즈 14, 색상 black
    - 출간일(*June 26, 1997*) 속성
        - Font = 사이즈 14, 색상 gray
    - `1998-07-02` 형태로 되어있는 Json 데이터를 변형하여 `June 26, 1997` 형태로 표시
- **페이지 속성**
    - 타이틀(*Pages*) 속성
        - Font = 시스템 볼드체, 사이즈 14, 색상 black
    - 페이지 수(*223*) 속성
        - Font = 사이즈 14, 색상 gray
- **저자, 출간일, 페이지 수 속성**
    - 타이틀(*Author*)과 저자(*J. K. Rowling*) 사이 간격 8
    - 타이틀(*Released*)과 출간일(*June 26, 1997*) 사이 간격 8
    - 타이틀(*Pages*)과 페이지 수(*223*) 사이 간격 8
- **AutoLayout**
    - `leading`, `trailing` = safeArea에서 5만큼씩 떨어지도록 세팅
    - 책 정보 영역이 시리즈 순서 영역 하단에 위치
        - ‘시리즈 순서’는 이 view를 의미합니다.
            
            ![Screenshot 2025-03-21 at 7.12.35 PM.png](attachment:1a4be9e9-2885-4ab6-8695-755b5e2dc2eb:Screenshot_2025-03-21_at_7.12.35_PM.png)
            
    - 이 외의 다른 부분은 자유롭게 구현합니다.
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 3</summary>
<div markdown="1">

### Level 3
<table>
  <tr>
    <td>
      <img src="https://teamsparta.notion.site/image/attachment%3Af885b487-d75f-4ea0-ac6d-cb8e3cc12f2d%3Alevel3.png?table=block&id=1bf2dc3e-f514-81e4-860e-df40c204fc7a&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=400&userId=&cache=v2" width="200">
    </td>
    <td>
<aside>
🧑🏻‍💻 `UIStackView` 와 `UILabel`을 사용해서 Dedication과 Summary 를 왼쪽과 같이 구성해보세요.

- Dedication과 Summary 영역은 이 부분을 의미합니다.
    
    ![Screenshot 2025-03-21 at 7.12.46 PM.png](attachment:558bcd66-5e2e-4835-8396-7ac76d5dfed2:Screenshot_2025-03-21_at_7.12.46_PM.png)
    
- **Dedication 속성**
    - 타이틀(*Dedication*) 속성
        - Font = 시스템 볼드체, 사이즈 18, 색상 black
    - 헌정사 내용 속성
        - Font = 사이즈 14, 색상 darkGray
- **Summary 속성**
    - 타이틀(*Summary*) 속성
        - Font = 시스템 볼드체, 사이즈 18, 색상 black
    - 요약 속성
        - Font = 사이즈 14, 색상 darkGray
- **Autolayout**
    - Dedication 영역
        - `top` = 책 정보 영역과 24 떨어져 있도록 세팅
        - `leading`, `trailing` = superView와 20씩 떨어지도록 세팅
        - 타이틀(*Dedication*)과 헌정사(*내용*) 사이 간격 8
    - Summary 영역
        - `top` = Dedication 영역과 24만큼 떨어져 있도록 세팅
        - `leading`, `trailing` = superView와 20씩 떨어지도록 세팅
        - 타이틀(*Summary*)과 요약(*내용*) 사이 간격 8
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 4</summary>
<div markdown="1">

### Level 4
<table>
  <tr>
    <td>
      <img src="https://teamsparta.notion.site/image/attachment%3A42cdb968-fcb1-4f3c-ab1d-ab7fb37e4942%3Alevel4.png?table=block&id=1bf2dc3e-f514-8148-8f92-d5103c88f0f3&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=400&userId=&cache=v2" width="200">
    </td>
    <td>
<aside>
🧑🏻‍💻 `UIScrollView` 를 추가하여 스크롤할 수 있도록 구현한 후 목차(Chapters)를 왼쪽과 같이 구성해보세요.

- **스크롤 속성**
    - 책 제목과 시리즈 순서는 화면 상단에 고정
        - ‘책 제목과 시리즈 순서’는 이 부분을 의미합니다.
            
            ![Screenshot 2025-03-21 at 7.18.49 PM.png](attachment:140dd8be-3874-459f-85e7-ece2a9395745:Screenshot_2025-03-21_at_7.18.49_PM.png)
            
    - 책 정보(책 표지, 책 제목, 저자, 출간일, 페이지수) 영역부터 목차(Chapters)까지 스크롤 가능하도록 구현
    - 스크롤 바가 보이지 않도록 구현
- 목차 속성
    - `UIScrollView` 안에 `UIStackView`를 추가하고 해당 `UIStackView`안에`UILabel` 추가하여 구현
        - 전체적인 포함 관계:
        `UIScrollView` 안에 `UIStackView` 안에 `UILabel`들어 있는 구조
    - 각 챕터 사이 간격은 8
    - 타이틀(*Chapters*) 속성
        - Font = 시스템 볼드체, 사이즈 18, 색상 black
    - 목차 속성
        - Font = 사이즈 14, 색상 darkGray
- **Autolayout**
    - 목차 영역의 `top` = Summary 영역과 24만큼 떨어져 있도록 세팅
    - `leading`, `trailing` = superView와 20씩 떨어지도록 세팅
    - 타이틀(*Chapters*)과 첫번째 챕터 사이 간격 8
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 5</summary>
<div markdown="1">

### Level 5
<table>
  <tr>
    <td>
<video width="400" height="800" controls>
  <source src="https://file.notion.so/f/f/83c75a39-3aba-4ba4-a792-7aefe4b07895/579d2d1f-fa4d-4718-b121-b6f9f17aff4e/level5.mp4?table=block&id=1bf2dc3e-f514-81c3-bcbc-c225fae0ab11&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&expirationTimestamp=1743667200000&signature=gJcbqiw6KzYdT0XmXK946QpKJ66PYVFq5yLeewMoJKA&downloadName=level5.mp4" type="video/mp4">
</video>
    </td>
    <td>
<aside>
🧑🏻‍💻 Summary 접기/더보기 기능을 구현해보세요.

- 글자수가 450자 이상인 경우 `…` 말줄임표 표시 및 `더보기` 버튼 표시
    - 참고로, 2권(시리즈 두번째)의 요약 내용은 글자수가 450자 미만이므로 더보기 버튼이 표시되지 않아야 합니다.
- `더보기` 버튼을 누르면 요약 텍스트 전체가 표시되고 `더보기` 버튼은 `접기` 버튼으로 변경
- 더보기/접기 상태를 저장해 앱을 종료했다가 다시 실행했을 때에도 마지막 상태를 기억하여 표시
    - `더보기` 버튼을 눌러 Summary를 펼친 상태로 앱을 종료했다면, 앱을 다시 실행했을 때 펼쳐진 상태로 표시되어 있습니다.
    반대로 `접기`버튼을 눌러 접은 상태로 종료했다면 앱 종료 후 다시 실행했을 때 접은 상태로 표시되어 있습니다.
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 6</summary>
<div markdown="1">

### Level 6
<table>
  <tr>
    <td>
        <video width="400" height="800" controls>
  <source src="https://file.notion.so/f/f/83c75a39-3aba-4ba4-a792-7aefe4b07895/f3f66cef-4ebd-405a-a567-eea10020705e/level6.mp4?table=block&id=1bf2dc3e-f514-81be-9bef-c350fc0a84bf&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&expirationTimestamp=1743667200000&signature=R30dS1TC1w7bmNec1T5Kxb3E5X3VAzKOSJRYlqyEA3k&downloadName=level6.mp4" type="video/mp4">
</video>
    </td>
    <td>
<aside>
🧑🏻‍💻 시리즈 전체(7권) 순서 중 원하는 권수의 책 정보를 볼 수 있도록 왼쪽과 같이 구현해보세요.

- 전체 데이터는 `data.json`에 있으며 시리즈 순서대로 데이터가 제공됩니다.
- 시리즈 순서 버튼을 누르면 아래 부분의 데이터가 업데이트 되어야 합니다.
    - 화면 상단에 있는 책 제목도 함께 변경
        
        ![Screenshot 2025-03-21 at 8.41.44 PM.png](attachment:3c7f222c-2f07-44f2-aeba-97853ffc06d7:Screenshot_2025-03-21_at_8.41.44_PM.png)
        
    - 책 정보 영역: 책표지 이미지, 책제목, 저자, 출간일, 페이지수
        
        ![Screenshot 2025-03-21 at 8.41.49 PM.png](attachment:f805839e-dee4-468c-bff5-73ec3c7c5a10:Screenshot_2025-03-21_at_8.41.49_PM.png)
        
    - 헌정사(Dedication)
        
        ![Screenshot 2025-03-21 at 8.41.53 PM.png](attachment:53c8c0ab-98ac-425e-94c3-d52d74b5614f:Screenshot_2025-03-21_at_8.41.53_PM.png)
        
    - 요약(Summary)
        
        ![Screenshot 2025-03-21 at 8.41.58 PM.png](attachment:0c26ee9a-44e4-4801-a199-640e3ee75a11:Screenshot_2025-03-21_at_8.41.58_PM.png)
        
    - 목차(Chapters)
        
        ![Screenshot 2025-03-21 at 9.25.35 PM.png](attachment:21cedaa9-3bc1-4d64-b619-bbc896ba0faa:Screenshot_2025-03-21_at_9.25.35_PM.png)
        
- level 5에서 시리즈 권별로 더보기/접기 상태를 저장하는 기능을 잘 구현했다면, 각 시리즈 권별 마지막 더보기/접기 상태를 기억하고 있어야 합니다.
    - ‘시리즈 순서’는 이 view를 의미합니다.
</aside>
    </td>
  </tr>
</table>
</div>
</details>

<details>
<summary>Level 7</summary>
<div markdown="1">

### Level 7
<table>
  <tr>
    <td>
    <video width="400" height="800" controls>
  <source src="https://file.notion.so/f/f/83c75a39-3aba-4ba4-a792-7aefe4b07895/647bbfa9-143e-4d55-8024-b9697e64af9e/level7.mp4?table=block&id=1bf2dc3e-f514-819f-9718-c16adc912b1c&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&expirationTimestamp=1743667200000&signature=egUYKbdWFm6CbMF_O3B-qF-y1lrrWd3rqHNMi2L72Uw&downloadName=level7.mp4" type="video/mp4">
</video>
    </td>
    <td>
<aside>
🧑🏻‍💻 iOS 16.0과 호환 가능한 iPhone 모델(SE 2세대, 16 Pro Max 등)의 다양한 디바이스 지원과 Portrait 모드/ Landscape 모드를 대응하여 왼쪽과 같이 구현해보세요.

- iOS 16.0 호환 모델 확인: [https://support.apple.com/ko-kr/guide/iphone/iphe3fa5df43/16.0/ios/16.0](https://support.apple.com/ko-kr/guide/iphone/iphe3fa5df43/18.0/ios/18.0)
- iOS 16 이상 모든 버전을 지원할 수 있도록 구현
- Portrait 모드와 Landscape 모드 대응
- 콘텐츠가 노치나 다이나믹 아일랜드 영역에 가려지지 않도록 구현해보세요.
- Autolayout이 제대로 구현되어있지 않다면 콘솔창에 Autolayout 관련 경고 메시지가 출력됩니다. 디바이스 방향을 바꾸더라도 (Portrait 모드 ↔ Landscape 모드) 콘솔창에 Autolayout 관련 경고 메시지가 뜨지 않도록 구현해보세요.
</aside>
    </td>
  </tr>
</table>
</div>
</details>

## 레이아웃
![Image](https://github.com/user-attachments/assets/e098bd08-53df-48a0-b53e-7955e13f5ca6) 

## 시연영상 (1, 7번 더보기)
![Simulator Screen Recording - iPhone 16 Pro - 2025-03-31 at 21 51 35](https://github.com/user-attachments/assets/a092627a-d29b-4b0e-94c9-7b9fb9cc175c)

## 스크린샷
<table>
  <tr>
    <td colspan="2" style="text-align: leading; font-weight: bold;">
    16 PRO
    </td>
  </tr>
    <tr>
    <td style="text-align: center;"><img src="https://github.com/user-attachments/assets/5ae301af-0abf-4c06-ae4d-d1e58aa83683" width="400"/></td>
    <td style="text-align: center;"><img src="https://github.com/user-attachments/assets/43a5591e-2b45-4306-a297-efbeb94f4514" width="400"/></td>
  </tr>

  <tr>
    <td colspan="2" style="text-align: leading; font-weight: bold;">
    SE
    </td>
  </tr>
    <tr>
    <td style="text-align: center;"><img src="https://github.com/user-attachments/assets/d5f27090-3962-4946-a40d-2e0a4d1e0f0d" width="400"/></td>
    <td style="text-align: center;"><img src="https://github.com/user-attachments/assets/66407f31-7555-4715-8599-e3798bd83e04" width="400"/></td>
  </tr>
</table>

## PR 
- [Level 1](https://github.com/nbcamp-prplz/HarryPotterBooks/pull/5)
- [Level 2](https://github.com/nbcamp-prplz/HarryPotterBooks/pull/8)
- [Level 3-4](https://github.com/nbcamp-prplz/HarryPotterBooks/pull/15)
- [Level 5-6-7](https://github.com/nbcamp-prplz/HarryPotterBooks/pull/19)


## 트러블 슈팅
- [날짜 설정 DateFormmater VS Date.FormatStyle](https://soo-hyn.tistory.com/143)
- [RxSwift에서 observe(on:)으로도 UI 업데이트가 즉시 반영되지 않는 이유와 해결법](https://soo-hyn.tistory.com/144)