import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/controller/video_controller.dart';
import 'package:ree_rave/views/screens/add_comment_screen.dart';
import 'package:ree_rave/views/widgets/circle_animation.dart';
import 'package:ree_rave/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});
  final VideoController videoController = Get.put(VideoController());

  buildProfilePic(String profilePic) {
    return SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 5,
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  buildMusicAlbum(String profilePic) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.grey, Colors.white],
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image(
          image: NetworkImage(profilePic),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Obx(() {
      return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(viewportFraction: 1, initialPage: 0),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(
                  videoURL: data.videoUrl,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(data.username,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: size.height / 5, right: 5),
                            child: Column(
                              children: [
                                buildProfilePic(data.profilePic),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          videoController.likeVideo(data.id),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 40,
                                        color: data.likes.contains(
                                                authController.user!.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.likes.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                    id: data.id,
                                                  ))),
                                      child: const Icon(
                                        Icons.comment,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.commentCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.reply,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.shareCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CircleAnimation(
                                      child: buildMusicAlbum(data.thumbnail),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          });
    }));
  }
}
