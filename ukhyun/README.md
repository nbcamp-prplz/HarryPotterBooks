# 📚 HarryPotterBooks

## 👀 Intro

HarryPotter 책 시리즈 정보를 제공하는 iOS 앱입니다.

## 🛠️ Stack / Dependency

- 개발환경 : Xcode, Swift, iOS
- 의존성 관리 : SPM
- 레이아웃 : SnapKit

## 📂 Directory Structure

```
ukhyun
    ├── HarryPotterNovelInfo
    │   ├── HarryPotterNovelInfo
    │   │   ├── Base
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── Assets.xcassets
    │   │   │   ├── Base.lproj
    │   │   │   │   └── LaunchScreen.storyboard
    │   │   │   └── SceneDelegate.swift
    │   │   ├── DataService.swift
    │   │   ├── Extension
    │   │   │   ├── Alert+Extension.swift
    │   │   │   └── Date+Extension.swift
    │   │   ├── Info.plist
    │   │   ├── Model
    │   │   │   ├── BookData.swift
    │   │   │   └── data.json
    │   │   └── ViewController.swift
    └── README.md

```

## Layout
 
 - Portrait 모드와 Landscape 모드 대응

## Feature

 - [X] Lv1: UILabel을 사용하여 책 제목과 시리즈 순서를 표시하고, data.json에서 가져온 데이터를 UI에 표시합니다.

 - [X] Lv2: UIStackView를 활용하여 책 표지 이미지, 책 제목, 저자, 출간일, 페이지 수 등의 책 정보 영역을 구성합니다.

 - [X] Lv3: UIStackView와 UILabel을 사용하여 Dedication(헌정사)과 Summary(요약) 영역을 구성합니다.

 - [X] Lv4: UIScrollView를 추가하여 책 정보부터 목차까지 스크롤 가능하도록 구현하고, 책 제목과 시리즈 순서는 화면 상단에 고정합니다.

 - [X] Lv5: Summary 영역에 접기/더보기 기능을 구현하고, 450자 이상일 경우 말줄임표와 더보기 버튼을 표시하며 상태를 저장합니다.

 - [X] Lv6: 시리즈 전체(7권) 중 원하는 권수의 책 정보를 볼 수 있도록 시리즈 순서 버튼을 구현하고, 각 권별로 더보기/접기 상태를 유지합니다.

 - [X] Lv7: iOS 16.0 이상 호환 가능한 다양한 iPhone 모델 지원 및 Portrait/Landscape 모드에 대응하여 노치나 다이나믹 아일랜드 영역에 콘텐츠가 가려지지 않도록 구현합니다.



## Trouble Shooting

 https://velog.io/@o2k_tech/HPB-Trouble-Shooting
 
## Next Step
- 아키텍처 패턴 리팩토링 예정 (MVC -> MVVM)
