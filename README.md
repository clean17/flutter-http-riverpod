# flutter_http_riverpod

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

> 
MVC + S 아키텍쳐를 만들어서 모든요청은 컨트롤러에 보낸다

연습방법
- 1. router 설계
게시글 목록, 상세, 쓰기

뷰모델을 만들어서 데이터를 받고 Provider에 저장한다.

뷰모델을 만든 이유는 해당 페이지에서만 사용하기 위한 목적을 가진다.

전역적으로 필요한 데이터는 모델로 분리시키지만 화면에서만 필요한 데이터는 재사용하지 않는다.
화면에서만 필요한 데이터는 변할 수 있으므로 재사용하지 않는다.

폴더 구조를 변경함


