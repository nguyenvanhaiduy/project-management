import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/controllers/auth_controller.dart';
import 'package:project_management_app/controllers/project_controller.dart';
import 'package:project_management_app/models/project.dart';
import 'package:project_management_app/views/project/project_detail_screen.dart';

final ProjectController _projectController = Get.find();
final AuthController _authController = Get.find();

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Management'),
      ),
      drawer: Drawer(
        child: Center(
            child: TextButton(
          onPressed: () {
            _authController.signOut();
          },
          child: const Text('Đăng xuất'),
        )),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _projectController.projects.length,
          itemBuilder: (context, index) {
            final projectssss = _projectController.projects[index];
            return ProjectListTile(projectssss: projectssss);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
            content: ProjectForm(),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ProjectForm extends StatelessWidget {
  ProjectForm({super.key});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên dự án';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mô tả dự án';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _startDateController,
              decoration: const InputDecoration(
                  labelText: 'Start Date', border: OutlineInputBorder()),
              readOnly: true,
              onTap: () async {
                DateTime? pickdedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickdedDate != null) {
                  _startDate = pickdedDate;
                  _startDateController.text =
                      DateFormat.yMd().format(pickdedDate);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập ngày bắt đầu';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _endDateController,
              decoration: const InputDecoration(
                  labelText: 'End Date', border: OutlineInputBorder()),
              readOnly: true,
              onTap: () async {
                DateTime? pickdedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickdedDate != null) {
                  _endDate = pickdedDate;
                  _endDateController.text =
                      DateFormat.yMd().format(pickdedDate);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập ngày kết thúc';
                }
                if (_endDate != null &&
                    _startDate != null &&
                    _endDate!.isBefore(_startDate!)) {
                  return 'Ngày kết thúc phải sau ngày bắt đầu';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _projectController.createProject(
                        Project(
                          id: '',
                          name: _nameController.text,
                          description: _descriptionController.text,
                          startDate: _startDate!,
                          endDate: _endDate!,
                          members: [],
                          tasks: [],
                          ownerId: _authController.user.value!.uid,
                        ),
                      );
                      Get.back();
                    }
                  },
                  child: const Text('Submid'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProjectListTile extends StatelessWidget {
  final Project projectssss;
  final ProjectController _projectController = Get.find<ProjectController>();

  ProjectListTile({required this.projectssss});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'hdiii ${projectssss.id}',
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.hardEdge,
          child: ListTile(
            leading: Icon(
              Icons.folder,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            title: Text(
              projectssss.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(projectssss.description),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                _projectController.deleteProject(projectssss.id);
              },
            ),
            onTap: () {
              // Chuyển đến màn hình chi tiết dự án
              Get.to(ProjectDetailScreen(
                project: projectssss,
              ));
            },
          ),
        ));
  }
}
