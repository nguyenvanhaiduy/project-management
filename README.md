# project_management_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Mô tả các thành phần chính
1. Bindings
auth_binding.dart: Khởi tạo AuthController.
project_binding.dart: Khởi tạo ProjectController.
task_binding.dart: Khởi tạo TaskController.

2. Controllers
auth_controller.dart: Quản lý đăng ký, đăng nhập và thông tin người dùng.
project_controller.dart: Quản lý các dự án.
task_controller.dart: Quản lý các nhiệm vụ.

3. Models
project.dart: Định nghĩa model cho dự án.
task.dart: Định nghĩa model cho nhiệm vụ.
user.dart: Định nghĩa model cho người dùng.

4. Screens
auth: Màn hình đăng nhập và đăng ký.
project: Màn hình danh sách và chi tiết dự án.
task: Màn hình danh sách và chi tiết nhiệm vụ.

5. Services
auth_service.dart: Xử lý logic liên quan đến xác thực người dùng.
project_service.dart: Xử lý logic liên quan đến dự án.
task_service.dart: Xử lý logic liên quan đến nhiệm vụ.

6. Utils
constants.dart: Chứa các hằng số sử dụng trong ứng dụng.
helpers.dart: Chứa các hàm tiện ích.
