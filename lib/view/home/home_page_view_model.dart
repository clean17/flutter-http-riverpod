import 'package:flutter_riverpod/flutter_riverpod.dart';

// 이 파일의 목적은 홈페이지에서 사용될 모델을 다운, 저장, 관리





// final homePageViewModel = Provider<HomePageViewModel>((ref) {
//   return HomePageViewModel(id: 1, title: "이거"); //
// });
//
// class HomePageViewModel {
//   late int id ;
//   late String title ;
//
//   HomePageViewModel({required this.id , required this.title});
// }

// 프로바이더는 값 변경 불가 다른 방법은 ? 퓨쳐프로바이더를 사용해야 하는데 복잡하다.
// 하지만 우리가 설계하려는 아키텍쳐에 맞지 않는다.


// ----------------------------------------------------------------------




// 스토어 관리자 ( Provider )
// StateNotifierProvider 첫번째 인자는 관리하려는 스토어를 넣는다.
// StateNotifierProvider 두번째 인자는 스토어에서 관리할 상태를 넣는다.
final homePageViewModel = StateNotifierProvider<HomePageViewModel, HomePageModel>((ref) {
  return HomePageViewModel(HomePageModel());
});

// 스토어 데이터
class HomePageModel {
  // 여러 데이터를 가지므로 리스트를 가진다.
  List<Post> posts = [];
}

// 데이터가 변하기 때문에 불변성을 가진 모델로는 부적함
// 재사용하지 않고 여기서만 사용한다.
class User {
}

class Post {
}


// dart에서는 inner 클래스가 안된다.
// dto를 파싱한 dart 오브젝트는 재사용 해서는 안될까?


// 이름이 비슷해서 헷갈리겠지만
// HomePageModel 를 관리하는 HomePageViewModel 스토어(창고)
class HomePageViewModel extends StateNotifier<HomePageModel> {
  HomePageViewModel(super.state);
  // 스토어를 관리하기 위해서 관리하는 메소드가 필요하다.
}
