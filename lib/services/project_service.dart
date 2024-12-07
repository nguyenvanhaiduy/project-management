import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/controllers/auth_controller.dart';
import 'package:project_management_app/models/project.dart';
import 'dart:async';

class ProjectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find();

  Stream<List<Project>> getProjects() {
    return _firestore
        .collection('projects')
        .where('ownerId', isEqualTo: _authController.user.value!.uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Project.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> createProject(Project project) async {
    try {
      await _firestore.collection('projects').add(project.toMap());
      _showSnackbar('Success', 'Project created successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to create project: $e', Colors.red);
    }
  }

  Future<void> updateProject(Project project) async {
    try {
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toMap());
      _showSnackbar('Success', 'Project updated successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to update project: $e', Colors.red);
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await _firestore.collection('projects').doc(projectId).delete();
      _showSnackbar('Success', 'Project deleted successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to delete project: $e', Colors.red);
    }
  }

  void _showSnackbar(String title, String message, Color backgroundColor) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: backgroundColor,
        colorText: Colors.white,
        duration: Duration(seconds: 2));
  }
}
