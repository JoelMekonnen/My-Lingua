import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:my_lingua/helpers/error_msg.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/custom_input.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/language.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/screens/signup.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';
import 'package:my_lingua/screens/preference.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  var resp = [];
  CustomTextInp userName = CustomTextInp(hintText: "User Name");
  CustomTextInp password = CustomTextInp(
    hintText: "Password",
    secured: true,
  );

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final course = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: auth.status == Status.Authentcating
          ? LoadingScreen()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CustomText(
                      text: "Login into our system",
                      size: 30,
                      align: TextAlign.center),
                ),
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/undraw_secure_login_pdn4.png",
                  ),
                ),
                CustomText(
                  text: loremIpsum(words: 30),
                  pad: 20,
                ),
                ErrorMessage(
                  check: resp.length == 0 ? Status.Uninitialized : auth.status,
                  response: resp.length > 1
                      ? (resp[1]["non_field_errors"] == null
                          ? resp[1]['password']
                          : resp[1]["non_field_errors"])
                      : [""],
                ),
                Form(
                  key: formKey,
                  child: Column(children: [
                    CustomTextInput(
                      textInp: userName,
                    ),
                    CustomTextInput(
                      textInp: password,
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: "login",
                        onPressed: () async {
                          final form = formKey.currentState;
                          print(form.validate());
                          if (form.validate()) {
                            form.save();
                            resp = await auth.signIn(
                                userName.value, password.value, course);
                            if (resp[0]) {
                              return changeScreenReplacement(context, LanguageScreen());
                            }
                          }
                        },
                      ),
                      CustomButton(
                        text: "signup",
                        onPressed: () => changeScreen(context, SignUpScreen()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
