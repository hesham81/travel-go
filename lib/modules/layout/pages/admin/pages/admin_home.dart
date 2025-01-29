import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static const routeName = '/admin-home';

  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Home'),
      ),
    );
  }
}
