import 'package:get/get.dart';
import 'package:water_reminder/models/user_model.dart';

class UserController extends GetxController {
  var userData = //Rx<UserModel>userData =
      UserModel(
        id: 0,
        username: '',
        email: '',
        firstName: '',
        lastName: "",
      ).obs;

  void setUser(UserModel data) {
    userData.value = data; //apiden gelen bilgileri userDataya aktar
  }

  void logout() {
    userData.value = UserModel(
      id: 0,
      username: '',
      email: '',
      firstName: '',
      lastName: "",
    );
  }
}
