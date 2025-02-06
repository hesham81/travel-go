import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/center.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/core/widget/label.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuthServices.getCurrentUserData();

  @override
  Widget build(BuildContext context) {
    var imageUrl = user!.photoURL;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: CircleAvatar(
                radius: 55,
                backgroundImage: imageUrl != null
                    ? NetworkImage(
                        imageUrl,
                      )
                    : NetworkImage(
                        "https://invisiblechildren.com/wp-content/uploads/2012/07/facebook-profile-picture-no-pic-avatar-300x188.jpg",
                      ),
              ).centerWidget(),
            ),
            0.01.height.hSpace,
            Label(
              text: "${user!.email}",
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: user!.displayName ?? "No Name",
            ),
            0.03.height.hSpace,
            CustomTextFormField(
              hintText: user!.phoneNumber ?? "Phone Number",
            ),
            0.01.height.hSpace,
          ],
        ),
      ).hPadding(0.018.width),
    );
  }
}
