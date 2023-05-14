import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/course_detail.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: CustomText(
          text: selectedResult ?? "No course found",
        ),
      ),
    );
  }

  final List<String> list;
  Search(this.list);
  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    var course = Provider.of<CourseProvider>(context);
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(
            list.where(
              (element) {
                return element.toLowerCase().contains(query.toLowerCase());
              },
            ),
          );
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: CustomText(text: suggestionList[index]),
            onTap: () {
              if (!recentList.contains(list[index])) {
                recentList.add(list[index]);
              }
              changeScreen(context, CourseDetail(course.courseList[0]));
            },
          );
        });
  }
}
