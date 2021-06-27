import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:interview_app/src/dialogs/delete_interview.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:interview_app/src/models/interviewee.dart';
import 'package:interview_app/src/models/interviewer.dart';
import 'package:interview_app/src/repository/file_repository.dart';
import 'package:interview_app/src/repository/interview_repository.dart';
import 'package:interview_app/src/repository/interviewee_repository.dart';
import 'package:interview_app/src/repository/interviewer_repository.dart';
import 'package:interview_app/src/widgets/select_interviewee.dart';
import 'package:interview_app/src/widgets/select_interviewer.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

Future<void> showCreateInterviewDialog(
    {required context, Interview? interview}) async {
  double vpH = getViewportHeight(context);
  double vpW = getViewportWidth(context);
  TextStyle _textStyle = TextStyle(fontWeight: FontWeight.bold);
  ValueNotifier<List<Interviewer>> interviewersList =
      ValueNotifier<List<Interviewer>>([]);

  ValueNotifier<List<Interviewee>> intervieweesList =
      ValueNotifier<List<Interviewee>>([]);

  Map<String, dynamic> currInterview = {
    "id": interview != null ? interview.id : 0,
    "startTiming": interview != null ? interview.startTime : 0,
    "endTiming": interview != null ? interview.endTime : 0,
    "date": ""
  };

  DateTime now = interview != null
      ? DateTime.parse(parseDate(interview.startTime))
      : DateTime.parse(parseDate(DateTime.now().millisecondsSinceEpoch));
  DateTime startTiming = interview != null
      ? DateTime.fromMillisecondsSinceEpoch(interview.startTime)
      : now;
  DateTime endTiming = interview != null
      ? DateTime.fromMillisecondsSinceEpoch(interview.endTime)
      : now;
  int startHour = interview != null
      ? int.parse(parseTime(interview.startTime).toString().substring(0, 2))
      : 0;
  int endHour = interview != null
      ? int.parse(parseTime(interview.endTime).toString().substring(0, 2))
      : 0;
  int startMin = interview != null
      ? int.parse(parseTime(interview.startTime).toString().substring(3, 5))
      : 0;
  int endMin = interview != null
      ? int.parse(parseTime(interview.endTime).toString().substring(3, 5))
      : 0;
  bool isDateSelected = false;
  bool isStartTimeChanged = false;
  bool isEndTimeChanged = false;
  bool isLoading = false;
  PlatformFile? resumeFile;
  ValueNotifier<bool> isInterviewerLoading = ValueNotifier<bool>(true);
  ValueNotifier<bool> isIntervieweeLoading = ValueNotifier<bool>(true);
  ValueNotifier<int> interviewerIndex = ValueNotifier<int>(-1);
  ValueNotifier<int> intervieweeIndex = ValueNotifier<int>(-1);

  interviewerRepository.getInterviewers().then((res) {
    int index = 0;
    jsonDecode(res.body).forEach((ele) {
      Interviewer interviewer = Interviewer.fromJSON(ele);
      interviewersList.value = List.from(interviewersList.value)
        ..add(interviewer);
      if (interview != null && interview.interviewer.id == interviewer.id) {
        interviewerIndex.value = index;
        currInterview["interviewer"] = interviewer;
      }
      index++;
    });
    isInterviewerLoading.value = false;
  });
  intervieweeRepository.getInterviewees().then((res) {
    int index = 0;
    jsonDecode(res.body).forEach((ele) {
      Interviewee interviewee = Interviewee.fromJSON(ele);
      intervieweesList.value = List.from(intervieweesList.value)
        ..add(interviewee);
      if (interview != null && interview.interviewee.id == interviewee.id) {
        intervieweeIndex.value = index;
        currInterview["interviewee"] = interviewee;
      }
      index++;
    });
    isIntervieweeLoading.value = false;
  });

  return await showDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: vpH * 0.02),
                      child: isLoading
                          ? CupertinoActivityIndicator()
                          : Container(),
                    ),
                    Text(
                      "Choose Interviewer:\n",
                      style: _textStyle,
                    ),
                    Container(
                        child: ValueListenableBuilder(
                            valueListenable: isInterviewerLoading,
                            builder: (context, value, child) =>
                                isInterviewerLoading.value
                                    ? CircularProgressIndicator()
                                    : ValueListenableBuilder(
                                        valueListenable: interviewersList,
                                        builder: (context, value, child) =>
                                            Container(
                                          height: vpH * 0.16,
                                          width: vpW * 0.8,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                interviewersList.value.length,
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ValueListenableBuilder(
                                                valueListenable:
                                                    interviewerIndex,
                                                builder:
                                                    (context, value, child) =>
                                                        GestureDetector(
                                                  onTap: () {
                                                    interviewerIndex.value =
                                                        index;

                                                    currInterview[
                                                            "interviewer"] =
                                                        interviewersList
                                                            .value[index];
                                                  },
                                                  child: SelectInterviewer(
                                                      interviewer:
                                                          interviewersList
                                                              .value[index],
                                                      isActive: interviewerIndex
                                                              .value ==
                                                          index),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ))),
                    SizedBox(
                      height: vpW * 0.01,
                    ),
                    Text(
                      "Choose Interviewee:\n",
                      style: _textStyle,
                    ),
                    Container(
                        child: ValueListenableBuilder(
                      valueListenable: isIntervieweeLoading,
                      builder: (context, value, child) => isIntervieweeLoading
                              .value
                          ? CircularProgressIndicator()
                          : ValueListenableBuilder(
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
                                              setState(() {
                                                currInterview["interviewee"] =
                                                    intervieweesList
                                                        .value[index];
                                              });
                                            },
                                            child: SelectInterviewee(
                                                interviewee: intervieweesList
                                                    .value[index],
                                                isActive:
                                                    intervieweeIndex.value ==
                                                        index),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                    )),
                    ValueListenableBuilder(
                      valueListenable: intervieweeIndex,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return intervieweeIndex.value != -1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextButton(
                                    child: Text(
                                      resumeFile != null
                                          ? resumeFile!.name
                                          : 'Upload Resume',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: vpH * 0.018),
                                    ),
                                    onPressed: () {
                                      FilePicker.platform.pickFiles(
                                          withData: true,
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowCompression: true,
                                          allowedExtensions: [
                                            'pdf'
                                          ]).then((value) async {
                                        if (value != null && value.count != 0) {
                                          PlatformFile platformFile =
                                              value.files.first;
                                          setState(() {
                                            resumeFile = platformFile;
                                          });
                                        }
                                      });
                                    },
                                  )),
                                  SizedBox(
                                    width: vpW * 0.02,
                                  ),
                                  Expanded(
                                      child: IconButton(
                                    icon: Icon(Icons.upload_file),
                                    onPressed: () {
                                      FilePicker.platform.pickFiles(
                                          withData: true,
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowCompression: true,
                                          allowedExtensions: [
                                            'pdf'
                                          ]).then((value) async {
                                        if (value != null && value.count != 0) {
                                          PlatformFile platformFile =
                                              value.files.first;
                                          setState(() {
                                            resumeFile = platformFile;
                                          });
                                        }
                                      });
                                    },
                                  ))
                                ],
                              )
                            : Container();
                      },
                    ),
                    SizedBox(height: vpH * 0.01),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      initialValue:
                          parseDate(startTiming.millisecondsSinceEpoch),
                      dateMask: 'MMM dd, yyyy',
                      initialDate: startTiming,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      onChanged: (val) => setState(() {
                        startTiming = DateTime.parse(val);
                        endTiming = startTiming;
                        isDateSelected = true;
                      }),
                      validator: (val) {
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: DateTimePicker(
                                initialValue: parseTime(
                                    startTiming.millisecondsSinceEpoch),
                                type: DateTimePickerType.time,
                                icon: Icon(Icons.access_time),
                                timeLabelText: "From:",
                                validator: (val) {
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    startHour = int.parse(val[0] + val[1]);
                                    startMin = int.parse(val[3] + val[4]);
                                    isStartTimeChanged = true;
                                  });
                                })),
                        SizedBox(
                          width: vpW * 0.01,
                        ),
                        Expanded(
                            child: DateTimePicker(
                                initialValue:
                                    parseTime(endTiming.millisecondsSinceEpoch),
                                type: DateTimePickerType.time,
                                icon: Icon(Icons.access_time),
                                timeLabelText: "To:",
                                validator: (val) {
                                  if (endTiming.isBefore(
                                      startTiming.add(Duration(hours: 1)))) {
                                    return "Endtime should be atleast 1hr greater that start time";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    isEndTimeChanged = true;
                                    endHour = int.parse(val[0] + val[1]);
                                    endMin = int.parse(val[3] + val[4]);
                                  });
                                })),
                      ],
                    )
                  ]),
                ),
              ),
              actions: [
                interview != null
                    ? TextButton(
                        child: Text('Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Averia Serif Libre",
                              fontSize: vpH * 0.02,
                            )),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await showDeleteInterviewDialog(
                              context, interview.id);
                          setState(() {
                            isLoading = false;
                          });
                        },
                      )
                    : Container(),
                TextButton(
                  child: Text('Save',
                      style: TextStyle(
                        fontFamily: "Averia Serif Libre",
                        fontSize: vpH * 0.02,
                      )),
                  onPressed: () async {
                    if (currInterview["interviewee"] == null) {
                      Fluttertoast.showToast(
                          msg: "Please select an interviewee");
                      return;
                    }
                    if (currInterview["interviewer"] == null) {
                      Fluttertoast.showToast(
                          msg: "Please select an interviewer");
                      return;
                    }
                    if (!isDateSelected) {
                      if (isStartTimeChanged) {
                        startTiming = now;
                      }
                      if (isEndTimeChanged) {
                        endTiming = now;
                      }
                    }

                    currInterview["startTiming"] = startTiming
                        .add(Duration(
                          hours: startHour,
                          minutes: startMin,
                        ))
                        .millisecondsSinceEpoch;
                    currInterview["endTiming"] = endTiming
                        .add(Duration(
                          hours: endHour,
                          minutes: endMin,
                        ))
                        .millisecondsSinceEpoch;
                    if (DateTime.fromMillisecondsSinceEpoch(
                            currInterview["startTiming"])
                        .isBefore(DateTime.now())) {
                      Fluttertoast.showToast(
                          msg: "startTime should be a present time");
                    }
                    if (DateTime.fromMillisecondsSinceEpoch(
                            currInterview["endTiming"])
                        .isBefore(DateTime.now())) {
                      Fluttertoast.showToast(
                          msg: "endTime should be a present time");
                    }
                    if (DateTime.fromMillisecondsSinceEpoch(
                            currInterview["endTiming"])
                        .isBefore(DateTime.fromMillisecondsSinceEpoch(
                            currInterview["startTiming"]))) {
                      Fluttertoast.showToast(
                          msg: "endTime should be more than startTime");
                    }
                    if (resumeFile != null) {
                      setState(() {
                        isLoading = true;
                      });
                      StreamedResponse response =
                          await fileRepository.uploadResume(
                              resumeFile!, currInterview["interviewee"].id);
                      setState(() {
                        isLoading = false;
                      });
                      if (response.statusCode == 200) {
                        setState(() {
                          response.stream.bytesToString().then((value) {
                            var x = jsonDecode(value);

                            setState(() {
                              currInterview["interviewee"].resumeURL =
                                  x["fileDownloadUri"];
                            });
                          });
                        });
                      }
                      Fluttertoast.showToast(msg: "Resume Uploaded");
                    }
                    print(currInterview);
                    if (interview == null) {
                      Interview interview = Interview.fromJSON(currInterview);
                      setState(() {
                        isLoading = true;
                      });
                      Response res =
                          await interviewRepository.scheduleInterview(
                              interview.startTime,
                              interview.endTime,
                              interview.interviewer.id,
                              interview.interviewee.id);
                      setState(() {
                        isLoading = false;
                      });
                      if (res.statusCode == 200) {
                        Navigator.of(context).pop();
                      } else {
                        Map<String, dynamic> errorBody = jsonDecode(res.body);
                        Fluttertoast.showToast(msg: errorBody["details"]);
                      }
                    } else {
                      Interview interview = Interview.fromJSON(currInterview);
                      setState(() {
                        isLoading = true;
                      });
                      Response res = await interviewRepository.modifyInterview(
                        interview.startTime,
                        interview.endTime,
                        interview.interviewer.id,
                        interview.interviewee.id,
                        interview.id,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      if (res.statusCode == 200) {
                        Navigator.of(context).pop();
                      } else {
                        Map<String, dynamic> errorBody = jsonDecode(res.body);
                        Fluttertoast.showToast(msg: errorBody["details"]);
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      });
}

String parseTimestamp(DateTime timestamp) {
  return DateFormat('MMM d, HH:mm a').format(timestamp).toString();
}

String parseTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('HH:mm').format(date).toString();
}

String parseDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('yyyy-MM-dd').format(date).toString();
}
