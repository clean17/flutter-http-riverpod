import 'package:flutter_http_riverpod/model/post/post.dart';
import 'package:flutter_http_riverpod/model/post/post_repository.dart';
import 'package:flutter_http_riverpod/view/pages/post/home/post_home_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final postController = Provider<PostController>((ref) {
  return PostController(ref);
});

class PostController {

  Ref ref;
  PostController(this.ref);

  // 레파지토리를 호출해서 다운을 받고
  // 스토어에 데이터를 저장한다.
  // 이제 뷰에서 프로바이더를 watch하고 있다가 build를 호출하면 된다.
  Future<void> findPosts() async {
    List<Post> homePagePostDto = await PostRepository().findAll();
    ref.read(postHomePageProvider.notifier).state = PostHomePageModel(posts: homePagePostDto);
  }

  // 추가하는 기능은 Future<void> 로 만들어야함 ! 비동기 !!
  Future<void> addPost(String title) async {
    Post post = await PostRepository().save(title);
    // 이후 Provider에 데이터를 넣어야 함.
    ref.read(postHomePageProvider.notifier).add(post);
  }

  Future<void> removePost(int id) async {
    PostRepository().deleteById(id); // 서버에 요청을 하면서
    ref.read(postHomePageProvider.notifier).remove(id); // Provider에서 제거
  }

  Future<void> updatePost(Post post) async {
    Post postPS = await PostRepository().update(post);
    ref.read(postHomePageProvider.notifier).update(postPS);
  }
}

/* StateNotifier 의 메소드  ->  state 내부적으로 구현

  @protected
  T get state {
    assert(_debugIsMounted(), '');
    return _state;
  }

  @protected
  set state(T value) {
    assert(_debugIsMounted(), '');
    final previousState = _state;
    _state = value;

    /// only notify listeners when should
    if (!updateShouldNotify(previousState, value)) {
      return;
    }

    _controller?.add(value);

    final errors = <Object>[];
    final stackTraces = <StackTrace?>[];
    for (final listenerEntry in _listeners) {
      try {
        listenerEntry.listener(value);
      } catch (error, stackTrace) {
        errors.add(error);
        stackTraces.add(stackTrace);

        if (onError != null) {
          onError!(error, stackTrace);
        } else {
          Zone.current.handleUncaughtError(error, stackTrace);
        }
      }
    }
    if (errors.isNotEmpty) {
      throw StateNotifierListenerError._(errors, stackTraces, this);
    }
  }
 */