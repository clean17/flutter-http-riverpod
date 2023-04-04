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
              child: pm != null ? buildListView(pm.posts) : buildListView([])),
          buildButton(pc),
        ],
      ),
    );
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
