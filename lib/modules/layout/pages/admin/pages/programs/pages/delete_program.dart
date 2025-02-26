import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class DeleteProgram extends StatelessWidget {
  static const routeName = '/delete_program';
  const DeleteProgram({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as Program;
    var theme = Theme.of(context).textTheme;

    return const Placeholder();
  }
}
