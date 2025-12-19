## 📱 프로젝트 소개

`Tasks`는 할 일을 추가·관리할 수 있는 간단한 To Do 앱입니다.  
할 일 추가, 완료 처리, 즐겨찾기, 삭제, 상세 보기 기능을 제공하며  
사용성을 고려한 UI/UX를 적용했습니다.

---

## 🎯 개발 목표

- Flutter 기본 위젯과 레이아웃 구조 이해
- UI 명세서를 기반으로 한 화면 구현
- Stateful / StatelessWidget 이해
- 상태 변경 및 화면 갱신 흐름 이해
- 사용자 경험(UX)을 고려한 기능 구현

---

## 🛠 사용 기술

- **Framework**: Flutter
- **Language**: Dart
- **UI**: Material Design
- **State 관리**: StatefulWidget + setState
- **Navigation**: Navigator, MaterialPageRoute
- **Asset 관리**: Image.asset (webp 이미지)

---

## ✅ 주요 기능

- **홈 화면**
  - 앱 타이틀: 성중’s Tasks
  - To Do가 없을 경우 안내 화면 표시
  - FloatingActionButton으로 To Do 추가

- **To Do 추가**
  - BottomSheet 방식 입력
  - 자동 키보드 표시 및 제목 Focus
  - 제목 필수 입력 검증
  - 즐겨찾기 및 세부 설명 추가 가능

- **To Do 리스트**
  - ListView 기반 목록 표시
  - 완료 / 즐겨찾기 토글
  - 삭제 기능 (확인 다이얼로그 포함)

- **To Do 상세 화면**
  - 뒤로가기 버튼
  - 즐겨찾기 변경
  - 변경 내용 이전 화면 반영
