import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:interview_app/src/models/interviewee.dart';
import 'package:interview_app/src/models/interviewer.dart';
import 'package:interview_app/src/repository/interviewee_repository.dart';
import 'package:interview_app/src/repository/interviewer_repository.dart';
import 'package:interview_app/src/widgets/select_interviewee.dart';
import 'package:interview_app/src/widgets/select_interviewer.dart';

void showCreateInterviewDialog(context) async {
  double vpH = getViewportHeight(context);
  double vpW = getViewportWidth(context);
  TextStyle _textStyle = TextStyle(fontWeight: FontWeight.bold);
  ValueNotifier<List<Interviewer>> interviewersList =
      ValueNotifier<List<Interviewer>>([]);

  ValueNotifier<List<Interviewee>> intervieweesList =
      ValueNotifier<List<Interviewee>>([]);
  interviewerRepository.getInterviewers().then((res) {
    jsonDecode(res.body).forEach((ele) {
      interviewersList.value = List.from(interviewersList.value)
        ..add(Interviewer.fromJSON(ele));
    });
  });
  intervieweeRepository.getInterviewees().then((res) {
    jsonDecode(res.body).forEach((ele) {
      intervieweesList.value = List.from(intervieweesList.value)
        ..add(Interviewee.fromJSON(ele));
    });
  });
  Interview currInterview;
  ValueNotifier<int> interviewerIndex = ValueNotifier<int>(0);
  ValueNotifier<int> intervieweeIndex = ValueNotifier<int>(0);

  showDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return AlertDialog(
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
        content: SingleChildScrollView(
          child: Container(
            // height: vpH * 0.55,
            child: Column(
              children: [
                Text(
                  "Choose Interviewer\n",
                  style: _textStyle,
                ),
                Container(
                  height: vpH * 0.16,
                  child: ValueListenableBuilder(
                      valueListenable: interviewersList,
                      builder: (context, value, child) => Container(
                            height: vpH * 0.16,
                            width: vpW * 0.8,
                            child: ListView.builder(
                              itemCount: interviewersList.value.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ValueListenableBuilder(
                                  valueListenable: interviewerIndex,
                                  builder: (context, value, child) =>
                                      GestureDetector(
                                    onTap: () {
                                      interviewerIndex.value = index;
                                    },
                                    child: SelectInterviewer(
                                        interviewer:
                                            interviewersList.value[index],
                                        isActive:
                                            interviewerIndex.value == index),
                                  ),
                                );
                              },
                            ),
                          )),
                ),
                Text(
                  "Choose Interviewee\n",
                  style: _textStyle,
                ),
                Container(
                    height: vpH * 0.16,
                    child: ValueListenableBuilder(
                      valueListenable: intervieweesList,
                      builder: (context, value, child) => Container(
                        height: vpH * 0.16,
                        width: vpW * 0.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: intervieweesList.value.length,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ValueListenableBuilder(
                              valueListenable: intervieweeIndex,
                              builder: (context, value, child) =>
                                  GestureDetector(
                                onTap: () {
                                  intervieweeIndex.value = index;
                                },
                                child: SelectInterviewee(
                                    interviewee: intervieweesList.value[index],
                                    isActive: intervieweeIndex.value == index),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
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
      );
    },
  );
}
