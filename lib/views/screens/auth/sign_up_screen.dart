import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/views/screens/auth/sign_in_screen.dart';
import 'package:ree_rave/views/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();

    late Size mq = MediaQuery.of(context).size;
    late var pickedImage;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create Account",
            style: TextStyle(
                fontSize: 35, color: buttonColor, fontWeight: FontWeight.w900),
          ),
          const Text(
            "Login",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&psig=AOvVaw3jr058xUFn6nBD6PXzYDoP&ust=1718300717466000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPC58pHP1oYDFQAAAAAdAAAAABAE"),
                backgroundColor: Colors.black,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    onPressed: () {
                      authController.pickImage();
                    },
                    icon: const Icon(Icons.add_a_photo)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: mq.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextInputField(
              controller: userNameController,
              icon: Icons.person,
              isHidden: false,
              labelText: "Username",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: mq.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextInputField(
              controller: emailController,
              icon: Icons.email,
              isHidden: false,
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: mq.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextInputField(
              controller: passwordController,
              icon: Icons.lock,
              isHidden: true,
              labelText: "password",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: mq.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                if (userNameController.text.isNotEmpty &&
                    emailController.text.trim().isNotEmpty &&
                    passwordController.text.trim().isNotEmpty &&
                    authController.profilePic != null) {
                  authController.registerUser(
                      userNameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      authController.profilePic);
                } else {
                  Get.snackbar(
                      "Error Creating Account", 'Please Enter All Fields');
                }
              },
              child: const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already Have an Account? ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: buttonColor),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
