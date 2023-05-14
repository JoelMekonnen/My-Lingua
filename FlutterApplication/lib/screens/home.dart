import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/screens/login.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: "My-Lingua: The best language Teaching platform",
              size: 15,
              pad: 15,
            ),
            Expanded(
              child: Image.asset(
                "assets/images/undraw_subscriptions_re_k7jj.png",
                width: 164,
                height: 149,
              ),
            ),
            Container(
              width: double.infinity,
              child: CustomText(
                text: "Learn whatever you want wherever",
                weight: FontWeight.bold,
                pad: 15,
              ),
            ),
            CustomText(text: loremIpsum(words: 50)),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomButton(
                text: "get started",
                onPressed: () => changeScreen(context, LoginScreen()),
              ),
            ),
            Expanded(
              child: Row(children: [
                Image.asset(
                  "assets/images/undraw_knowledge_g5gf.png",
                  width: 261,
                  height: 193,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
