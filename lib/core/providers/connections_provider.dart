import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:travel_go/main.dart';

class ConnectionProvider extends ChangeNotifier {
  final InternetConnectionChecker _checker =
      InternetConnectionChecker.createInstance();
  static bool? _isConnected;

  _checkConnections(BuildContext context) async {
    EasyLoading.show();
    await _checker.hasConnection.then(
      (value) {
        _isConnected = value;
        print("Connection is $_isConnected");
        notifyListeners();
        EasyLoading.dismiss();
        _connectionStream();

      },
    );
  }

  _connectionStream() {
    _checker.onStatusChange.listen(
      (event) {
        if (event == InternetConnectionStatus.connected) {
          _isConnected = true;
          print("Connection is $_isConnected");
        } else {
          _isConnected = false;
          print("Connection is $_isConnected");
        }
        notifyListeners();
      },
    );
  }

  ConnectionProvider() {
    _checkConnections(
      navigationKey.currentContext!,
    );
  }

  bool get getConnectionStatus => _isConnected ?? false;
}
