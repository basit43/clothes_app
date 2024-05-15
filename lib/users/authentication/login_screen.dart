import 'dart:ffi';

import 'package:clothes_app/users/authentication/home_screen.dart';
import 'package:clothes_app/users/authentication/login_controller.dart';
import 'package:clothes_app/users/authentication/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecurePassword = true.obs;
  final AuthController authController = Get.put(AuthController());
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset(
                      'images/clothes_login.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.white,
                              offset: Offset(0, -3))
                        ]),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                validator: (value) =>
                                    value == '' ? 'Please write email' : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: isObsecurePassword.value,
                                validator: (value) => value == ''
                                    ? 'Please write password'
                                    : null,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isObsecurePassword.value =
                                          !isObsecurePassword.value;
                                    },
                                    child: Icon(
                                      isObsecurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.vpn_key_sharp,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.white24),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(() => InkWell(
                                    onTap: () async {
                                      try {
                                        print('trying');
                                        print('${emailController.text}');
                                        print('${passwordController.text}');
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim());
                                        print('user is logged in ');
                                        print('${emailController.text.trim()}');
                                        print('${passwordController.text}');
                                        Get.to(HomeScreen());
                                      } catch (e) {
                                        print('exception $e');
                                      }
                                    },
                                    child: controller.loading.value
                                        ? CircularProgressIndicator()
                                        : Container(
                                            height: 45,
                                            width: 100,
                                            color: Colors.grey,
                                            child:
                                                Center(child: Text('Login'))),
                                  ))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(SignupScreen());
                              },
                              child: Text('Register Here'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
