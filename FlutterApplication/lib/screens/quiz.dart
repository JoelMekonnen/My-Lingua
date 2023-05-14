import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CustomText(
                      text: loremIpsum(words: 40),
                    ),
                  ),
                ),
              ),
              RadioListTile(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
                title: CustomText(
                  text: loremIpsum(words: 10),
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
                title: CustomText(
                  text: loremIpsum(words: 10),
                ),
              ),
              RadioListTile(
                value: 2,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
                title: CustomText(
                  text: loremIpsum(words: 10),
                ),
              ),
              RadioListTile(
                value: 3,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
                title: CustomText(
                  text: loremIpsum(words: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(text: "Next"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
