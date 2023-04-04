import 'package:flutter/material.dart';
import 'package:flutter_http_riverpod/controller/post_controller.dart';
import 'package:flutter_http_riverpod/view/home/home_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/post_response_dto.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  // 어제까지는 퓨처로 데이터를 가져와서 리턴했지만 + read

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostController pCon = ref.read(postController);
    HomePageModel? hpm = ref.watch(homePageViewModel); // 프로바이더를 지켜본다.

    return Scaffold(
      body: Column(
        children: [
          // watch를 사용할경우 if로 분기해야한다
          hpm != null
              ? _buildExpanded(hpm.posts)
              : Spacer(),Center(
            child: CircularProgressIndicator(),
                ),

          ElevatedButton(
            onPressed: () {
              pCon.findPosts();
            },
            child: Text("페이지로드"),
          )
        ],
      ),
    );
  }

  Expanded _buildExpanded(List<PostDto>? posts) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.green[100]),
                height: 150,
                child: ListTile(
                  leading: Text("${posts[index].id}"),
                  title: Text("타이틀"),
                  subtitle: Text("서브타이틀"),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
