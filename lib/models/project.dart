import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management_app/models/task.dart';
import 'package:project_management_app/models/user.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  List<User> members;
  List<Task> tasks;
  final String ownerId;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.members,
    required this.tasks,
    required this.ownerId,
  });

  factory Project.fromMap(Map<String, dynamic> data, String uid) {
    return Project(
      id: uid,
      name: data['name'],
      description: data['description'],
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      members: (data['members'] as List)
          .map((member) => User.fromMap(member, member.id))
          .toList(),
      tasks: (data['tasks'] as List)
          .map((task) => Task.fromMap(task, task.id))
          .toList(),
      ownerId: data['ownerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'members': members.map((member) => member.toMap()).toList(),
      'tasks': tasks.map((task) => task.toMap()).toList(),
      'ownerId': ownerId,
    };
  }
}
