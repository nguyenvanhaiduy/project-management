import 'package:project_management_app/models/user.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final TaskStatus status;
  final User assignedTo;
  final DateTime deadline;
  final String projectId;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.deadline,
    required this.projectId,
  });

  factory Task.fromMap(Map<String, dynamic> data, String uid) {
    return Task(
      id: uid,
      name: data['name'],
      description: data['description'],
      status: data['status'],
      assignedTo: data['assignedTo'],
      deadline: DateTime.parse(data['deadline']),
      projectId: data['projectId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'status': status,
      'assignedTo': assignedTo.toMap(),
      'deadline': deadline,
      'projectId': projectId,
    };
  }
}

enum TaskStatus {
  notStarted,
  inProgress,
  completed,
}
