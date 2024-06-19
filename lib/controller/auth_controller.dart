import "dart:io";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:get/get.dart";
import "package:ree_rave/constant.dart";
import 'package:image_picker/image_picker.dart';
import "package:ree_rave/models/user_model.dart" as model;
import "package:ree_rave/views/screens/auth/sign_in_screen.dart";
import "package:ree_rave/views/screens/home_screen.dart";

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  User? get user => _user.value;

  File? get profilePic => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          "You have successfully seelcted your profile picture");
    }
    if (pickedImage != null) {
      _pickedImage = Rx<File?>(File(pickedImage.path));
    } else {
      Get.snackbar("Image Not Selected", "Select Profile Image");
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user to auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _uploadToStorage(image);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            email: email,
            name: username,
            profilePic: downloadUrl,
            uid: cred.user!.uid);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error Creating Account", 'Please Enter All Fields');
      }
    } catch (e) {
      Get.snackbar("Error Creating  Account", e.toString());
    }
  }

  void userLogin(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (e) {
      Get.snackbar("Error Loging in", e.toString());
    }
  }

  void signout() {
    firebaseAuth.signOut().then((context) {
      Get.offAll(const LoginScreen());
    });
  }
}
