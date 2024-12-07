import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String projectId) {
    return _firestore
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> createTask(String projectId, Task task) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .add(task.toMap());
      _showSnackbar('Success', 'Task created successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to create task: $e', Colors.red);
    }
  }

  Future<void> updateTask(String projectId, Task task) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
      _showSnackbar('Success', 'Task updated successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to update task: $e', Colors.red);
    }
  }

  Future<void> deleteTask(String projectId, String taskId) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .delete();
      _showSnackbar('Success', 'Task deleted successfully', Colors.green);
    } catch (e) {
      _showSnackbar('Error', 'Failed to delete task: $e', Colors.red);
    }
  }

  void _showSnackbar(String title, String message, Color backgroundColor) {
    Get.closeAllSnackbars(); // Đóng tất cả các thông báo trước đó
    Get.snackbar(title, message,
        backgroundColor: backgroundColor, colorText: Colors.white);
  }
}
