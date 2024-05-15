import 'dart:ffi';
import 'package:clothes_app/users/authentication/auth_controller.dart';
import 'package:clothes_app/users/authentication/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Signup Screen'),
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
                      'images/register.jpg',
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
                                controller: nameController,
                                validator: (value) =>
                                    value == '' ? 'Please write email' : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Name',
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
                              Obx(
                                () => TextFormField(
                                  controller: passwordController,
                                  obscureText: isObsecure.value,
                                  validator: (value) => value == ''
                                      ? 'Please write password'
                                      : null,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isObsecure.value = !isObsecure.value;
                                      },
                                      child: Icon(
                                        isObsecure.value
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
                                      borderSide: const BorderSide(
                                          color: Colors.white24),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white24),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white24),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white24),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black)),
                                    onPressed: () async {
                                      try {
                                        await authController.signUp(
                                            emailController.text.trim(),
                                            passwordController.text.trim());
                                        var query = FirebaseFirestore.instance
                                            .collection('users')
                                            .add({
                                          'email': emailController.text,
                                          'password': passwordController.text
                                        });
                                        print('user created');
                                        Get.snackbar('Congradulations',
                                            'You have successfully created the user');
                                      } catch (e) {
                                        print('exception $e');
                                      }
                                      ;
                                    },
                                    child: Text(
                                      'Signup',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(LoginScreen());
                              },
                              child: Text('Login Here'),
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
