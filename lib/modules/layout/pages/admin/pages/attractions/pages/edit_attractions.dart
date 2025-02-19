import 'package:flutter/material.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/attraction_widget.dart';

class EditAttractions extends StatelessWidget {
  const EditAttractions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AttractionWidget(),
          ],
        ),
      ),
    );
  }
}
