import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'You are now signed in');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign up with email and password
  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar('Success', 'Your account has been created');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    await auth.signOut();
    Get.snackbar('Success', 'You are now signed out');
  }
}
