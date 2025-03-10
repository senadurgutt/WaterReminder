import 'package:get/get.dart';

class UserController extends GetxController {
  var userData = {}.obs;

  void setUser(Map<String, dynamic> data) {
    userData.value = data; //apiden gelen bilgileri userDataya aktar
  }

  void logout() {
    userData.value = {};
  }
}
