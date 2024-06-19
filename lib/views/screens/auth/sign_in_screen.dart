import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/views/screens/auth/sign_up_screen.dart';
import 'package:ree_rave/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late Size mq = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ReelRave",
            style: TextStyle(
                fontSize: 35, color: buttonColor, fontWeight: FontWeight.w900),
          ),
          const Text(
            "Login",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
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
            height: 25,
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
            height: 35,
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
                authController.userLogin(emailController.text.trim(),
                    passwordController.text.trim());
              },
              child: const Center(
                child: Text(
                  "Login",
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
                "Don't Have an Account? ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const SignUpScreen());
                },
                child: Text(
                  "Create Account",
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
