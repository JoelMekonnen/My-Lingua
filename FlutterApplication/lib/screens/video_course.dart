import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/content.dart';
import 'package:my_lingua/providers/content.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/text_course.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    const VideoCourseScreen(),
  );
}

class VideoCourseScreen extends StatefulWidget {
  final ContentModel content;
  // ignore: use_key_in_widget_constructors
  const VideoCourseScreen({this.title = 'Video Player', this.content});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _VideoCourseScreen();
  }
}

class _VideoCourseScreen extends State<VideoCourseScreen> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.content.contentVideo);
    await Future.wait([_videoPlayerController1.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: lightBlue,
        handleColor: lightBlue1,
        backgroundColor: Colors.grey,
        bufferedColor: lightBlue2,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final con = Provider.of<ContentProvider>(context);
    final course = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Container()),
          CustomText(
            text: "Course Title",
            weight: FontWeight.bold,
            size: 22,
          ),
          Expanded(child: Container()),
          Container(
            child: Container(
              width: double.infinity,
              height: 250,
              child: _chewieController != null &&
                      _chewieController
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : Container(
                      color: grey,
                      width: double.infinity,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      )),
            ),
          ),
          Expanded(child: Container()),
          CustomButton(
            text: "mark completed",
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(text: "previous"),
              CustomButton(
                text: "next",
                onPressed: () async {
                  try {
                    _chewieController.dispose();
                    await _videoPlayerController1.dispose();
                  } catch (e) {}
                  var current = con
                              .getCurrent(widget.content.contentID + 1);
                  await con.isCompleted(course, widget.content, course.currentCourse.courseID);
                  return changeScreen(
                      context, TextCourseScreen(widget.content.contentID, current));
                },
              ),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
