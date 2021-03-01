# bookshelf Application



## Getting Started

StateManagement : Provider

### Description of each folder

```
main.dart : 실행 시작
routes : main.dart에 표현되는 Route 상수 정의
/lib
  /common : Key 설정 파일
  /entity : 저장소에 저장되는 데이터 단위 (api에서 받아온 결과를 dart로 변환)
  /model  : 1개의 screen당 1개의 model로 상태관리
  /repository : 저장소 인터페이스 및 구현
  /screen : 화면단위
  /widget : 화면을 구성하는 서브 컴포넌트
```

### TDD 

  -Widget Test 

  -http Test

