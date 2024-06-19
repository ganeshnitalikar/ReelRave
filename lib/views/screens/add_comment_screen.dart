import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  final TextEditingController _commentController = TextEditingController();
  final MyCommmentController commentController =
      Get.put(MyCommmentController());
  CommentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentController.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(comment.profilePic),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: Colors.white,
                          ),
                          Text('${comment.username} ',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              )),
                          Row(
                            children: [
                              Expanded(
                                child: Text(comment.comment,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            tago.format(comment.datePublished.toDate()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${comment.likes.length} likes',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                          onTap: () {
                            commentController.likeComment(comment.id);
                          },
                          child: Icon(Icons.favorite,
                              color: comment.likes
                                      .contains(authController.user!.uid)
                                  ? Colors.red
                                  : Colors.white)),
                    );
                  });
            })),
            const Divider(),
            ListTile(
              title: TextFormField(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                controller: _commentController,
                decoration: const InputDecoration(
                    hintText: 'Comment',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    )),
              ),
              trailing: TextButton(
                onPressed: () {
                  commentController.postComment(_commentController.text.trim());
                },
                child: const Text('Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
