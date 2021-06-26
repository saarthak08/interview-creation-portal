import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:intl/intl.dart';

class InterviewCard extends StatelessWidget {
  final Interview interview;
  const InterviewCard({Key? key, required this.interview}) : super(key: key);

  String parseTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM d, hh:mm a').format(date).toString();
  }

  @override
  Widget build(BuildContext context) {
    // double vpH = getViewportHeight(context);
    interview.duration = "1";
    double vpW = getViewportWidth(context);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: ListTile(
        horizontalTitleGap: 8,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        onLongPress: () {
          print("Edit Interview");
        },
        leading: Icon(Icons.timelapse_rounded),
        title: Text(
          "Interviewer: " +
              interview.interviewer.name +
              "\nInterviewee: " +
              interview.interviewee.name,
          style: TextStyle(fontSize: vpW * 0.035),
        ),
        subtitle: Text(parseTimestamp(interview.startTime) +
            " - " +
            parseTimestamp(interview.endTime)),
        trailing: Text("Duration\n   " + interview.duration + " hr"),
      ),
    );
  }
}
