import 'package:flutter_http_riverpod/model/post/post.dart';
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

//


// 스토어 관리자 ( Provider )
// StateNotifierProvider 첫번째 인자는 관리하려는 스토어를 넣는다.
// StateNotifierProvider 두번째 인자는 스토어에서 관리할 상태를 넣는다.
final postHomePageProvider = StateNotifierProvider<PostHomePageViewModel, PostHomePageModel?>((ref) {
  return PostHomePageViewModel(null);
  // 마지막에는 컨트롤러의 null 체크 때문에 물음표 추가했음
  // return PostHomePageProvider(HomePageModel()); // required 를 사용하면 매번 코드를 수정해야한다.
});


// HomePageModel 를 관리하는 PostHomePageViewModel 스토어(창고)
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);
// 스토어를 관리하기 위해서 관리하는 메소드가 필요하다.
// StateNotifier 가 가지고 있는 여러 메소드를 이용해볼까

  void init(List<Post> postDtoList){ // 초기화 ( 화면 새로 고침 한다면 )
    state = PostHomePageModel(posts: postDtoList);
  }

  // save 기능 추가 ( 프로바이더에 저장 )
  void add(Post post) {
    List<Post> posts = state!.posts;

    // 변경 감지는 !!!! 레퍼런스 주소가 달라져야 작동한다 !!! 기존의 배열에 추가하면 변경 감지하지 않음
    // 즉 여기서는 state가 배열이지만 기존의 state에 데이터를 추가하더라도 레퍼런스 동일.. 변경 x
    // 이유는 배열이 10만개의 리스트를 가지고 있는데 중간의 데이터가 하나만 바꼈을때 이걸 다 돌면서 확인할래 ? 아니면 박스만 확인할래 ?
    List<Post> newPosts = [...posts, post]; // 깊은 복사라고 하는데 ... 레퍼런스가 새롭게 담긴다.
    // List<Post> newPosts = [...posts];  // 개발자가 실수해서 똑같은 내용인 레퍼런스를 바꾸면 레퍼런스가 바껴서
    // 다시 그릴때 플러터가 다시 확인해서 값이 같으면 그리지 않는다.
    // 즉 riverpod을 사용하면 알아서 다 해준다. !!!!!!!!!!!!!

    state = PostHomePageModel(posts: newPosts);
  }

  void remove(int id){
    List<Post> posts = state!.posts;

    // 조건에 따라 검색 ,, 내가 넣은 id 검색 or 삭제
    // 조건이 맞으면 리스트 반환
    List<Post> newPosts = posts.where((e) => e.id != id).toList(); // where 이 참이야 거짓이야 ?
    state = PostHomePageModel(posts: newPosts);
  }

  void update(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }
}

// 스토어 데이터
class PostHomePageModel {
  // 여러 데이터를 가지므로 리스트를 가진다.
  List<Post> posts; // required 를 사용하면 매번 코드를 수정해야 하므로 ? 사용
  PostHomePageModel({required this.posts});
}



// 데이터가 변하기 때문에 불변성을 가진 모델은 부적합
// 재사용하지 않고 여기서만 사용한다.


