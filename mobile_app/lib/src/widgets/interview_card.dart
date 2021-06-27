import 'package:flutter/material.dart';
import 'package:interview_app/src/dialogs/create_interview.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class InterviewCard extends StatelessWidget {
  final Interview interview;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  const InterviewCard(
      {Key? key, required this.interview, required this.refreshIndicatorKey})
      : super(key: key);

  String parseTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('hh:mm a').format(date).toString();
  }

  String parseDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM dd, yyyy').format(date).toString();
  }

  @override
  Widget build(BuildContext context) {
    // double vpH = getViewportHeight(context);
    interview.duration = "1";
    double vpW = getViewportWidth(context);
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          tilePadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          leading: Icon(
            Icons.timelapse_rounded,
            size: vpW * 0.08,
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
                text: TextSpan(
                    text: "Interviewer: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: interview.interviewer.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.normal),
                  )
                ])),
            SizedBox(
              height: vpW * 0.01,
            ),
            RichText(
                text: TextSpan(
                    text: "Interviewee: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: interview.interviewee.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.normal),
                  )
                ])),
            SizedBox(
              height: vpW * 0.01,
            ),
          ]),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(parseDate(interview.startTime)),
            SizedBox(
              height: vpW * 0.01,
            ),
            Text(parseTimestamp(interview.startTime) +
                " - " +
                parseTimestamp(interview.endTime)),
          ]),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "Interviewer Email: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: interview.interviewer.email,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.normal),
                  )
                ])),
            SizedBox(
              height: vpW * 0.01,
            ),
            RichText(
                text: TextSpan(
                    text: "Interviewee Email: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: interview.interviewee.email,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getViewportHeight(context) * 0.02,
                        fontWeight: FontWeight.normal),
                  )
                ])),
            SizedBox(
              height: vpW * 0.02,
            ),
            Container(
                margin: EdgeInsets.only(right: vpW * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    interview.interviewee.resumeURL.toString().isNotEmpty
                        ? OutlinedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.blue))),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.blue)),
                            ),
                            onPressed: () async {
                              String _url =
                                  interview.interviewee.resumeURL.toString();
                              await canLaunch(_url)
                                  ? await launch(_url)
                                  : throw 'Could not launch $_url';
                            },
                            child: Text('Download Resume'))
                        : Container(),
                    SizedBox(width: vpW * 0.04),
                    ElevatedButton(
                      onPressed: () async {
                        await showCreateInterviewDialog(
                            context: context, interview: interview);
                        refreshIndicatorKey.currentState?.show();
                      },
                      child: Text('Edit'),
                    ),
                  ],
                )),
          ],
        ));
  }
}
