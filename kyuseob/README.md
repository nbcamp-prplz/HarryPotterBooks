# HarryPotterReadingGuide

Harry Potter 책 시리즈 정보를 제공하는 iOS 앱입니다.

## 📱 프로젝트 소개

Harry Potter 시리즈 책 정보를 제공하는 애플리케이션입니다.

![image](https://github.com/user-attachments/assets/b0c2061b-3b96-4f9e-ba6f-eb68ec9715d2)

## 🛠 개발 환경

![Swift](https://img.shields.io/badge/Swift-6.0-F05138)  ![Xcode](https://img.shields.io/badge/Xcode-16.2-147EFB) ![iOS](https://img.shields.io/badge/iOS-16.0+-000000) ![Swift Package Manager](https://img.shields.io/badge/SPM-C8A866)

## 🛠 라이브러리
![SnapKit](https://img.shields.io/badge/SnapKit-5.7.1-2371C3) ![Then](https://img.shields.io/badge/Then-3.0.0-151C22)

## 📐 앱 아키텍처

MVVM 구조를 따라가도록 했습니다. 
구조는 Model, View, ViewController, ViewModel로 나누었습니다.
View는 뷰로서 그리고 ViewController는 컨트롤러의 역할로 최대한 분리할 수 있도록 유도하였습니다.

## 🔦 사용법

```
# 저장소 클론
git clone https://github.com/nbcamp-prplz/HarryPotterBooks.git

# 프로젝트 폴더로 이동
cd HarryPotterBooks/kyuseob

# Xcode 프로젝트 열기
open HarryPotterBooks.xcodeproj

# 실행: ⌘ + R
# 테스트: ⌘ + U
```

## 🧩 프로젝트 구조

```
HarryPotterBooks/
├── HarryPotterBooks/
│   ├── Global/
│   │   └── Extension/
│   ├── Resources/
│   │   ├── Assets/
│   │   └── data/
│   ├── Networking/
│   ├── Model/
│   ├── ViewControllers/
│   ├── ViewModels/
│   └── Views/
```

## 📦 레이아웃

<img width="300" alt="image" src="https://github.com/user-attachments/assets/7e0f7ae5-dfd7-4a31-9247-104b871a485b" /><img width="300" alt="image" src="https://github.com/user-attachments/assets/058aa409-5e78-4647-84c5-3ab3424d3509" /><img width="300" alt="image" src="https://github.com/user-attachments/assets/073169c2-8734-443b-8f89-896b131cb767" />


## ✅ 트러블 슈팅

- [스택뷰가 보이지 않던 현상 해결](https://subkyu-ios.tistory.com/36)

## 요구 사항

#### Level 1~2
- [x] JSON 데이터 파싱 및 에러 처리
- [x] 책 제목, 시리즈 번호 표시
- [x] '책 정보 영역' 구현

#### Level 3~4
- [x] Dedication, Summary, Chapters 구현
- [x] 스크롤 뷰 구현
      
#### Level 5~7
- [x] Summary 더보기/접기 기능 구현
- [x] 시리즈 별 더보기/접기 상태 저장, 불러오기 구현
- [x] 전체 시리즈(7권) 열람 기능 구현
- [x] 다양한 디바이스 지원 및 Landscape 대응

