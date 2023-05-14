import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/screens/profile.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_tile.dart';

class LevelsScreen extends StatefulWidget {
  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  List<bool> lst = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: "Step-2 : Choose your level",
              size: 22,
              weight: FontWeight.bold,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTile(
                  text: "Beginner - level 0",
                  color: lightBlue,
                  id: 1,
                  selected: lst[0],
                  function: () => changeSelection(0),
                ),
                CustomTile(
                  text: "Novice - level 1",
                  color: lightBlue2,
                  id: 2,
                  function: () => changeSelection(1),
                  selected: lst[1],
                ),
                CustomTile(
                  text: "Intermediate - level 2",
                  color: lightBlue3,
                  function: () => changeSelection(2),
                  selected: lst[2],
                  id: 3,
                ),
                CustomTile(
                  text: "Advanced - level 3",
                  color: lightBlue4,
                  selected: lst[3],
                  function: () => changeSelection(3),
                  id: 4,
                ),
                CustomTile(
                  text: "Certify Me - level 4",
                  color: lightBlue5,
                  selected: lst[4],
                  function: () => changeSelection(4),
                  id: 5,
                ),
              ],
            ),
            CustomButton(
              text: "choose level",
              onPressed: () => changeScreen(context, ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }

  void changeSelection(int id) {
    setState(() {
    lst.fillRange(0, 5, false);
    lst[id] = true;
    });
  }
}
