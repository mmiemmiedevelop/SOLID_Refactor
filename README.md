# 📷 Picture Gallery App

Swift 기반의 **MVVM 아키텍처**를 적용한 사진 갤러리 앱입니다.  
사용자는 메인에서 **컬렉션 뷰(CollectionView)**를 통해 API에서 가져온 사진 리스트를 확인하고, **검색 기능**을 이용해 원하는 데이터를 찾을 수 있습니다.
메인에 있는 **컬렉션 뷰(CollectionView)**를 클릭하면 상세화면으로 이동하고, **흑백 변환**, **줌 기능**, **회전 기능**을 사용할 수 있습니다.

---

## 🚀 주요 기능
- **MVVM 아키텍처 적용**
- **Alamofire를 활용한 API 통신**
- **컬렉션 뷰로 데이터 표시**
- **실시간 검색 기능 (AND 조건)**
- **검색된 키워드 하이라이트 기능 (녹색 틴트)**
- **Activity Indicator (로딩 UI) 적용**
- **오류 발생 시 Alert 표시**

---

## 🛠 기술 스택
- **언어**: Swift 5
- **UI**: UIKit (Storyboard)
- **아키텍처**: MVVM (Model-View-ViewModel)
- **네트워크**: Alamofire
- **필터 효과**: Core Image (흑백 필터 적용)

---

## 📂 프로젝트 구조
📂 Heuron 
│── 📂 Controllers # 화면 UI 및 이벤트 처리 
│── 📂 Model # 데이터 모델 (Decodable 구조체) 
│── 📂 Network # API 처리
│── 📂 Utils # 공통 유틸리티 (로딩 인디케이터, 에러 알림)
│── 📂 ViewModelㄴ # 비즈니스 로직 처리 
│── 📂 Views # View 화면
