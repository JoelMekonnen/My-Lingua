import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/screens/home.dart';
import 'package:my_lingua/screens/login.dart';
import 'package:my_lingua/widgets/custom_label.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_tile.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Container(
      padding: EdgeInsets.all(15),
      color: lightBlue,
      child: ListView(
        children: [
          CustomTile(
            text: "Home",
            id: 5,
            fontWeight: FontWeight.bold,
            fontsize: 20,
            function: () => changeScreen(context, HomeScreen()),
          ),
          CustomTile(
            text: "About",
            id: 5,
            fontWeight: FontWeight.bold,
            fontsize: 20,
          ),
          CustomTile(
            text: "Contact Us",
            id: 5,
            fontWeight: FontWeight.bold,
            fontsize: 20,
          ),
          CustomTile(
            text: "SignOut",
            id: 5,
            fontWeight: FontWeight.bold,
            fontsize: 20,
            function: () {
              changeScreen(context, LoginScreen());
              return auth.signOut();
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomLabel(
              text: "Courses",
            ),
          ]),
          ListTile(
            leading: Icon(Icons.person),
            title: CustomText(
              text: "User Profile",
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          Divider(
            thickness: 1,
            color: grey[500],
          ),
          ListTile(
            leading: Icon(Icons.menu),
            title: CustomText(
              text: "Test Results",
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          Divider(
            thickness: 1,
            color: grey[500],
          ),
          ListTile(
            leading: Icon(Icons.library_add_check_outlined),
            title: CustomText(
              text: "Progress Level",
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          Divider(
            thickness: 1,
            color: grey[500],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: CustomText(
              text: "Settings",
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
          Divider(
            thickness: 1,
            color: grey[500],
          ),
        ],
      ),
    );
  }
}
