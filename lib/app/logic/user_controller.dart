import 'package:get/get.dart';

class UserController extends GetxController{

  var userName = ''.obs;
  var userEmail = ''.obs;
  var fullName = ''.obs;

  void updateFullName(String newName) {
    fullName(newName);
  }
}
class FullnameController extends GetxController {
    late RxString _fullName = ''.obs;

  String get fullName => _fullName.value;

  set fullName(String value) {
    _fullName.value = value;
  }
}