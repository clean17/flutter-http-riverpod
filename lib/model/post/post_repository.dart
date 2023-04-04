
import 'package:flutter_http_riverpod/model/post/post.dart';

import '../../dto/post/post_response_dto.dart';


// 레파지토리의 역할은 통신 + 파싱
// 여기서 ref의 일을 하지 않는다. 분리시켜
class PostRepository {

  static PostRepository _instance = PostRepository._single();

  PostRepository._single();
  factory PostRepository(){
    return _instance;
  }

  Future<List<Post>> findAll(){
    final homePagePostDto = [
      Post(id: 1, title: "제목1"),
      Post(id: 2, title: "제목2"),
      Post(id: 3, title: "제목3"),
      Post(id: 4, title: "제목4"),
    ];
    return Future.delayed(Duration(seconds: 1), () => homePagePostDto,);
  }

  Future<Post>? save(String title){
    // save할때는 데이터를 영속화해야 함 -> 영속화된 데이터를 반환받음
    return Future.delayed(Duration(seconds: 1), () => Post(id: 5, title: title),);
  }
}