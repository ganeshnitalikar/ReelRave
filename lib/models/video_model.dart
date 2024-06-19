import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int shareCount;
  int commentCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePic;

  Video({
    required this.username,
    required this.caption,
    required this.commentCount,
    required this.videoUrl,
    required this.id,
    required this.likes,
    required this.profilePic,
    required this.shareCount,
    required this.songName,
    required this.thumbnail,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'caption': caption,
        'commentCount': commentCount,
        'videoUrl': videoUrl,
        'id': id,
        'likes': likes,
        'profilePic': profilePic,
        'shareCount': shareCount,
        'songName': songName,
        'thumbnail': thumbnail,
        'uid': uid,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
        username: snapshot['username'],
        caption: snapshot['caption'],
        commentCount: snapshot['commentCount'],
        videoUrl: snapshot['videoUrl'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        profilePic: snapshot['profilePic'],
        shareCount: snapshot['shareCount'],
        songName: snapshot['songName'],
        thumbnail: snapshot['thumbnail'],
        uid: snapshot['uid']);
  }
}
