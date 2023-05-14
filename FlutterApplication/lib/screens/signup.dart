import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/error_msg.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/custom_input.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/screens/login.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var resp = [];
  CustomTextInp firstName = CustomTextInp(hintText: "First Name");
  CustomTextInp lastName = CustomTextInp(hintText: "Last Name");
  CustomTextInp userName = CustomTextInp(hintText: "User Name");
  CustomTextInp email = CustomTextInp(hintText: "Email");
  CustomTextInp password = CustomTextInp(hintText: "Password", secured: true);
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: auth.status == Status.Authentcating
          ? LoadingScreen()
          : ListView(
              children: [
                CustomText(
                  text: "Create your user account",
                  size: 30,
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  pad: 40,
                ),
                ErrorMessage(
                  top: true,
                  check: resp.length == 0 ? Status.Uninitialized : auth.status,
                  response: resp.length > 1 ? resp[1]["email"] : [""],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextInput(
                        textInp: firstName,
                      ),
                      CustomTextInput(
                        textInp: lastName,
                      ),
                      CustomTextInput(
                        textInp: email,
                      ),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["email"] : [""],
                      ),
                      CustomTextInput(
                        textInp: userName,
                      ),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["username"] : [""],
                      ),
                      CustomTextInput(
                        textInp: password,
                      ),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["password1"] : [""],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: "Signup",
                        onPressed: () async {
                          final form = formKey.currentState;
                          form.save();
                          resp = await auth.signUp(userName.value, email.value,
                              password.value, userName.value, lastName.value);
                          if (resp[0]) {
                            return changeScreenReplacement(context, LoginScreen());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
