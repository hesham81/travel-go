import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/manager/pages/utils/users_reports.dart';
import '/modules/layout/pages/manager/pages/data/users_model.dart';

class ManagerProvider extends ChangeNotifier {
  int _totalUsers = 0;
  int _totalEndUsers = 0;
  int _totalAdminUsers = 0;
  bool isLoading = true;

  int _totalManagerUsers = 0;

  List _users = [];
  List _adminUsers = [];
  List _endUsers = [];
  List _managerUsers = [];

  int get totalManagerUsers => _totalManagerUsers;

  int get totalAdminUsers => _totalAdminUsers;

  int get totalEndUsers => _totalEndUsers;

  int get totalUsers => _totalUsers;

  List get adminUsers => _adminUsers;

  List get endUsers => _endUsers;

  List get managerUsers => _managerUsers;

  List get users => _users;

  ManagerProvider() {
    _getTotalUsers();
  }

  final _firestore = FirebaseFirestore.instance.collection("users");

  _getTotalUsers() async {
    isLoading = true;
    await UsersReports.getAllAppUsers().then(
      (value) => _totalUsers = value,
    );
    _users = await UsersReports.getTotalUsersData().then((value) => value
        .map(
          (e) => e.data(),
        )
        .toList());
    _adminUsers = _users.where((element) => element["role"] == "admin").toList();
    _endUsers = _users.where((element) => element["role"] == "user").toList();
    _managerUsers =
        _users.where((element) => element["role"] == "manager").toList();
    _totalAdminUsers = _adminUsers.length;
    _totalEndUsers = _endUsers.length;
    _totalManagerUsers = _managerUsers.length;
    isLoading = false;

    notifyListeners();
  }

  checkUsersReload() {
    _getTotalUsers();
  }
}
