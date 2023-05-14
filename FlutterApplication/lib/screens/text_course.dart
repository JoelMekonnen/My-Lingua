import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/content.dart';
import 'package:my_lingua/providers/content.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/screens/video_course.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_tile.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TextCourseScreen extends StatefulWidget {
  final int courseID;
  final int selectedTile;
  final ContentModel currentModel;
  TextCourseScreen(this.courseID, this.currentModel, {this.selectedTile});
  @override
  _TextCourseScreenState createState() => _TextCourseScreenState();
}

class _TextCourseScreenState extends State<TextCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final content = Provider.of<ContentProvider>(context);
    // for (int i = 0; i < content.list.length; i++) {
    //   if(content.list[i]['currContentId'] == content){

    //   }
    // }
    int x = 0;
    for (int i = 0; i < content.list.length; i++) {
      print("what");
      // if (content.list[i]['currContentId'] ==
      //     content.contentModel[index].selfId) {
      print("perfect");
      x = content.list[i]['currContentId'];
      print(x);

      // }
    }
    // content.setCurrent(content.list[0]['currContentId']);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: content.contentModel.length,
          itemBuilder: (context, index) {
            print(x);
            print(content.contentModel[index].contentLevel);
            return Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTile(
                  selected: widget.selectedTile == null
                      ? (content.contentModel[index].selfId == x ? true : false)
                      : (widget.selectedTile == index ? true : false),
                  progress: content.contentModel[index].selfId < x
                      ? Icons.verified
                      : (content.contentModel[index].selfId > x
                          ? Icons.lock
                          : null),
                  color: lightBlue,
                  text: content.contentModel[index].contentTitle,
                  id: content.contentModel[index].contentID,
                  function: content.contentModel[index].selfId > x
                      ? () {}
                      : () async {
                          await content.getContentTile(
                              content.contentModel[index].contentID);
                          return changeScreenReplacement(
                              context,
                              TextCourseScreen(
                                widget.courseID,
                                content.contentModel[index],
                                selectedTile: index,
                              ));
                        },
                ));
          },
        ),
      ),
      body: content.contentModel == null
          ? Container(
              child: Center(
                child: CustomText(text: "No Content is found!"),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomText(
                    text: widget.currentModel.contentTitle,
                    weight: FontWeight.bold,
                    size: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          Container(
                            height: 300,
                            child: Stack(children: [
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.center,
                                child: LoadingScreen(),
                              )),
                              FadeInImage.memoryNetwork(
                                width: double.infinity,
                                fit: BoxFit.fill,
                                placeholder: kTransparentImage,
                                image: widget.currentModel.contentImage,
                              ),
                            ]),
                          ),
                          CustomText(
                            text: loremIpsum(words: 1000, paragraphs: 5),
                            color: grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      text: "mark completed",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(text: "previous"),
                      CustomButton(
                        text: "next",
                        onPressed: () => changeScreen(
                            context,
                            VideoCourseScreen(
                              content: widget.currentModel,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
