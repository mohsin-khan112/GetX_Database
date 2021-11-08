import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_database/Database/UserDAO.dart';
import 'package:getx_database/Model/User.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  var listUsers = <User>[].obs;

  String? name;
  String? contact;
  UserDAO userDAO = UserDAO();
  int? id;
  int position = 0;
  TextEditingController nameControl = TextEditingController();
  TextEditingController contactControl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void addUser() async {
    User user = User(nameControl.text, contactControl.text);
    var value = await userDAO.insertUser(user);
    if (value > 0) {
      user.id = value;
      listUsers.add(user);
    }
    nameControl.clear();
    contactControl.clear();
  }

  void getData() async {
    listUsers.addAll(await userDAO.fetchContacts());
    update();
  }

  void delete(int id) async {
    await userDAO.deleteTask(id);
    listUsers.removeWhere((element) => element.id == id);
  }

  void updateUser(int id) async {
    User user = new User(nameControl.text, contactControl.text);
    user.id = id;
    await userDAO.updateTask(user);
    listUsers[position] = user;
    nameControl.clear();
    contactControl.clear();
    update();
  }
}
