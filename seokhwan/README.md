# 📚 HarryPotterBooks

## 👀 Intro

<image src="Resources/Intro.png" width="50%"></image>

HarryPotter 책 시리즈 정보를 제공하는 iOS 앱입니다.

## 🛠️ Stack / Dependency

Xcode, Swift, iOS / SPM, SnapKit

## 🔦 Usage

```bash
git clone https://github.com/prplz/HarryPotterBooks.git
cd HarryPotterBooks/seokhwan/HarryPotterBooks
open HarryPotterBooks.xcodeproj
# 실행: ⌘ + R / 테스트: ⌘ + U
```

## 📂 Directory Structure

```
seokhwan
├── HarryPotterBooks
│   ├── HarryPotterBooks
│   │   ├── Application
│   │   ├── Presentation
│   │   │   └── Subview
│   │   ├── Domain
│   │   │   ├── Entity
│   │   │   └── UseCase
│   │   ├── Data
│   │   │   ├── DTO
│   │   │   └── Storage
│   │   ├── Utility
│   │   └── Resource
│   └── HarryPotterBooksTests
│       ├── ViewModel
│       │   └── Mock
│       ├── UseCase
│       │   └── Mock
│       ├── Storage
│       └── Utility
└── README.md
```

## 🏗️ Architecture

MVVM 기반 Clean Architecture 적용

<image src="Resources/Architecture.png" width="75%"></image>

* Application: AppDelegate, SceneDelegate
* Presentation: View(Programmatic UIKit with SnapKit), ViewModel(with Combine)
* Domain: Entity, UseCase
* Repository는 필요 없다고 판단하여 생략하였습니다.
* Data: DTO, DataService(JSON Parser), AppStatesStorage(UserDefaultsStorage)

## 🔍 Layout

<image src="Resources/Layout01.png" width="250px"></image>
<image src="Resources/Layout02.png" width="250px"></image>

## 🚀 Feature

### Level 1~2

- [x] JSON 데이터 파싱 및 에러 처리
- [x] 책 제목, 시리즈 번호 표시
- [x] '책 정보 영역' 구현

### Level 3~4

- [x] Dedication, Summary, Chapters 구현
- [x] 스크롤 뷰 구현

### Level 5~7

- [x] Summary 더보기/접기 기능 구현
- [x] 시리즈 별 더보기/접기 상태 저장, 불러오기 구현
- [x] 전체 시리즈(7권) 열람 기능 구현
- [x] 다양한 디바이스 지원 및 Landscape 대응 

## 🎯 Result

<video src="Resources/result.mp4" mute controls></video>

## 🔥 Trouble Shooting

- [UIStackView에 Padding 추가하기](https://youseokhwan.me/blog/add-padding-to-uistackview/)
- [클린 아키텍처에 어울리는 UserDefaults 구조 설계](https://youseokhwan.me/blog/design-userdefaults-to-fit-clean-architecture/)
