import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/views/screens/confirm_screen.dart';

class AddMediaScreen extends StatelessWidget {
  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.gallery, context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.image,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Gallery",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.camera, context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Camera",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.clear,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Cancel",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
    }
    print("Video Path: ${video?.path}");
  }

  const AddMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          showOptionsDialog(context);
        },
        child: Container(
          width: 190,
          height: 50,
          decoration: BoxDecoration(
            color: buttonColor,
          ),
          child: const Center(
            child: Text(
              "Add Video",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
