import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/helper/dummy_data.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:interview_app/src/models/user.dart';
import 'package:interview_app/src/widgets/select_participant.dart';

void showCreateInterviewDialog(context) {
  double vpH = getViewportHeight(context);
  // double vpW = getViewportWidth(context);
  TextStyle _textStyle = TextStyle(fontWeight: FontWeight.bold);
  List<User> interviewersList =
      interviewers.map((e) => User.fromJSON(e)).toList();
  List<User> intervieweesList =
      interviewees.map((e) => User.fromJSON(e)).toList();
  Interview currInterview;
  showDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Row(
            children: [
              Icon(
                Icons.laptop,
                color: Colors.black,
                size: vpH * 0.05,
              ),
              Text("  Schedule Interview"),
            ],
          ),
          content: Container(
            height: vpH * 0.55,
            child: Column(
              children: [
                Text(
                  "Choose Interviewer\n",
                  style: _textStyle,
                ),
                Container(
                  height: vpH * 0.16,
                  width: double.infinity,
                  // color: Colors.yellow,
                  child: ListView.builder(
                    itemCount: interviewersList.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SelectParticipant(
                          participant: interviewersList[index]);
                    },
                  ),
                ),
                Text(
                  "Choose Interviewee\n",
                  style: _textStyle,
                ),
                Container(
                  height: vpH * 0.16,
                  width: double.infinity,
                  // color: Colors.yellow,
                  child: ListView.builder(
                    itemCount: intervieweesList.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SelectParticipant(
                          participant: intervieweesList[index]);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text("Pick Date & Time"),
                  onTap: () {
                    DateTime now = DateTime.now();
                    showDatePicker(
                      context: context,
                      helpText: "Choose a preferred Date.",
                      initialDate: now,
                      firstDate: now,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            dialogBackgroundColor: Colors.white,
                            colorScheme: ColorScheme.light(
                                primary: Theme.of(context).primaryColor),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                            highlightColor: Colors.grey[400],
                            textSelectionTheme: TextSelectionThemeData(
                              selectionColor: Colors.grey,
                              cursorColor: Colors.grey,
                            ),
                          ),
                          child: child!,
                        );
                      },
                      lastDate: now.add(Duration(days: 30)),
                    );
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Confirm',
                  style: TextStyle(
                    fontFamily: "Averia Serif Libre",
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
