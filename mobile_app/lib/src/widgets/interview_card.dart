import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';

class InterviewCard extends StatelessWidget {
  final Interview interview;
  const InterviewCard({Key? key, required this.interview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double vpH = getViewportHeight(context);
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
              interview.interviewer +
              "\nInterviewee: " +
              interview.interviewee,
          style: TextStyle(fontSize: vpW * 0.035),
        ),
        subtitle:
            Text(interview.startTime + " pm - " + interview.endTime + " pm"),
        trailing: Text("Duration\n   " + interview.duration + " hr"),
      ),
    );
  }
}
