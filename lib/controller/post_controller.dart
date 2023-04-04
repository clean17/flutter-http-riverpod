import 'package:flutter_http_riverpod/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/post_response_dto.dart';
import '../view/home/home_page_view_model.dart';

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
    List<PostDto> homePagePostDto = await PostRepository().findAll();
    ref.read(homePageViewModel.notifier).state = HomePageModel(posts: homePagePostDto);
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