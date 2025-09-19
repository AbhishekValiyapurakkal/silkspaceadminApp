import 'package:flutter/cupertino.dart';
import 'package:silkspaceadmin/Models/user_model.dart';

class GlobalVariables extends ChangeNotifier {
  static List<String> username = ['abhishek', 'anas'];
  static int userIndex = 0;

  int get userind => userIndex;

  List<String> get user => username;
  

  void addUser(UserModel user) {
    users.add(user);
    notifyListeners();
  }

  void delet(int index) {
    users.removeAt(index);
    notifyListeners();
  }

  static List<UserModel> users = [
    UserModel(
        name: 'Abhishek',
        email: 'abhishek@gmail.com',
        password: 'Iamans7',
        image: 'image'),
    UserModel(
        name: 'anas',
        email: 'alanashu07@gmail.com',
        password: 'Iamans7',
        image: 'image'),
  ];

  List<UserModel> get allUsers => users;


  void changeName(String name, int index) {
    username[index] = name;
    notifyListeners();
  }

  void changeInt(int index) {
    userIndex = index;
    notifyListeners();
  }
}
