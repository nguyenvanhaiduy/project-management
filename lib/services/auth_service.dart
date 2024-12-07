import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<User?> getCurrentUser() {
    return _auth.userChanges();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    Get.closeAllSnackbars();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar(
        'Success',
        'Bạn đã đăng nhập thành công',
        backgroundColor: const Color.fromARGB(255, 165, 231, 167),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      return userCredential.user;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    Get.closeAllSnackbars();

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'Bạn đã đăng kí tài khoản thành công.',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      );
      userCredential.user!.updateDisplayName(name);
      await _firebaseFirestore.collection('users').add({
        'name': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'password': password,
      });

      return userCredential.user;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
