import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ree_rave/controller/auth_controller.dart';
import 'package:ree_rave/views/screens/add_screen.dart';
import 'package:ree_rave/views/screens/message_screen.dart';
import 'package:ree_rave/views/screens/profile_screen.dart';
import 'package:ree_rave/views/screens/search_screen.dart';
import 'package:ree_rave/views/screens/video_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddMediaScreen(),
  const MessageScreen(),
  ProfileScreen(
    uid: authController.user!.uid,
  ),
];

//colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//controllers
var authController = AuthController.instance;
