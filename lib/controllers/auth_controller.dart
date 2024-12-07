import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_management_app/bindinds/project_binding.dart';
import 'package:project_management_app/services/auth_service.dart';
import 'package:project_management_app/views/auth/login_screen.dart';
import 'package:project_management_app/views/project/project_list_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var user = Rxn<User>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(AuthService().getCurrentUser());
    ever(user, _initScreen);
  }

  void _initScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const ProjectListScreen(), binding: ProjectBinding());
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    await AuthService().signInWithEmailAndPassword(email, password);
    isLoading.value = false;
  }

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    await AuthService().createUserWithEmailAndPassword(name, email, password);
    isLoading.value = false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(const LoginScreen());
  }
}
