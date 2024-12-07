import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/controllers/auth_controller.dart';
import 'package:project_management_app/models/project.dart';
import 'package:project_management_app/models/task.dart';
import 'package:intl/intl.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    // final taskController = Get.put(TaskController());
    // taskController.projectId = project.id; // Gán projectId cho TaskController
    // taskController.getTasks(); // Lấy danh sách nhiệm vụ của dự án

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần thông tin dự án
            Hero(
                tag: 'hdiii ${project.id}',
                child: ProjectListTileDetail(
                  projectssss: project,
                ))
            // Phần hiển thị danh sách nhiệm vụ
            // Expanded(
            //   child: Obx(
            //     () => ListView.builder(
            //       itemCount: taskController.tasks.length,
            //       itemBuilder: (context, index) {
            //         final task = taskController.tasks[index];
            //         return TaskCard(task: task);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Chuyển đến màn hình thêm nhiệm vụ
          Get.toNamed('/task/add', arguments: project);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              task.description,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 5),
                Text(
                  'Deadline: ${DateFormat('MMM dd, yyyy').format(task.deadline)}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 5),
                Text(
                  'Assigned To: ${task.assignedTo.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Status: ${task.status.toString()}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectListTileDetail extends StatelessWidget {
  final Project projectssss;
  // final ProjectController _projectController = Get.find<ProjectController>();
  final AuthController _authController = Get.find();

  ProjectListTileDetail({required this.projectssss});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.folder,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    projectssss.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // _projectController.deleteProject(projectssss.id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              projectssss.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'Start: ${projectssss.startDate.toLocal()}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'End: ${projectssss.endDate.toLocal()}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'Owner Name: ${_authController.user.value!.displayName}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.group, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'Members: ${projectssss.members.length}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.task, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'Tasks: ${projectssss.tasks.length}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
