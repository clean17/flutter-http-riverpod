
import '../dto/post_response_dto.dart';


// 레파지토리의 역할은 통신 + 파싱
// 여기서 ref의 일을 하지 않는다. 분리시켜
class PostRepository {

  static PostRepository _instance = PostRepository._single();

  PostRepository._single();
  factory PostRepository(){
    return _instance;
  }

  Future<List<PostDto>> findAll(){
    final homePagePostDto = [
      PostDto(id: 1, title: "제목1"),
      PostDto(id: 2, title: "제목2"),
      PostDto(id: 3, title: "제목3"),
      PostDto(id: 4, title: "제목4"),
    ];
    return Future.delayed(Duration(seconds: 1), () => homePagePostDto,);
  }

  Future<void>? save(){
    return null;
  }
}