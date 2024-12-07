import 'package:get/get.dart';
import 'package:project_management_app/models/project.dart';
import 'package:project_management_app/services/project_service.dart';

class ProjectController extends GetxController {
  var projects = <Project>[].obs;

  @override
  void onInit() {
    super.onInit();
    projects.bindStream(ProjectService().getProjects());
  }

  /// thằng bindStream này bất cứ khi nào có dữ liệu bị thay đổi nó đều cập nhật lại

  void handleProjectChange(List<Project> projects) {
    print('projects have been udpated: ${projects.length}');
  }

  Future<void> createProject(Project project) async {
    await ProjectService().createProject(project);
  }

  Future<void> updateProject(Project project) async {
    await ProjectService().updateProject(project);
  }

  Future<void> deleteProject(String id) async {
    await ProjectService().deleteProject(id);
  }
}
