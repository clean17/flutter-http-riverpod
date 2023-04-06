import 'package:flutter/material.dart';
import 'package:flutter_http_riverpod/controller/post_controller.dart';
import 'package:flutter_http_riverpod/model/post/post.dart';
import 'package:flutter_http_riverpod/view/pages/post/home/post_home_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostHomePage extends ConsumerWidget {
  const PostHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostController pc = ref.read(postController);
    PostHomePageModel? pm = ref.watch(postHomePageProvider); // 프로바이더를 지켜본다.

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child:
                  // pm != null ? buildListView(pm.posts) : buildListView([])),
                  FutureBuilder(
            future: pc.findPosts(), // 비동기 함수를 호출합니다.
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Future 작업이 완료된 경우
                if (snapshot.hasData) {
                  // 데이터가 있는 경우
                  return _buildMainScreen(snapshot.data); // 화면을 구성하는 함수를 호출합니다.
                } else {
                  // 데이터가 없는 경우
                  return _buildErrorScreen(); // 오류 화면을 구성하는 함수를 호출합니다.
                }
              } else {
                // Future 작업이 완료되지 않은 경우
                return _buildLoadingScreen(); // 로딩 화면을 구성하는 함수를 호출합니다.
              }
            },
          )),
          buildButton(pc),
        ],
      ),
    );
  }



  Widget _buildMainScreen(List<Post> posts) {
    // 데이터를 사용하여 화면을 구성하는 코드를 작성합니다.
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green[100]),
              height: 100,
              child: ListTile(
                leading: Text("${posts[index].id}"),
                title: Text("${posts[index].title}"),
              ),
            ),
            Divider(),
          ],
        );
      },
    );// 예시 코드
  }

  Widget _buildErrorScreen() {
    // 오류 메시지를 보여주는 화면을 구성하는 코드를 작성합니다.
    return Container(
      child: Center(child: Text("실패"),),
    ); // 예시 코드
  }

  Widget _buildLoadingScreen() {
    // 로딩 화면을 구성하는 코드를 작성합니다.
    return Container(
      child: Center(child: Text("로딩중")),
    ); // 예시 코드
  }

  Padding buildButton(PostController pc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  pc.findPosts();
                },
                child: Text("페이지로드"),
              ),
              ElevatedButton(
                onPressed: () {
                  pc.addPost("제목추가");
                },
                child: Text("한건추가"),
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  pc.removePost(1);
                },
                child: Text("한건삭제"),
              ),
              ElevatedButton(
                onPressed: () {
                  pc.updatePost(Post(id: 2, title: "제목수정"));
                },
                child: Text("한건수정"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListView(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green[100]),
              height: 100,
              child: ListTile(
                leading: Text("${posts[index].id}"),
                title: Text("${posts[index].title}"),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
