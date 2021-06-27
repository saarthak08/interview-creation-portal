import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/repository/interview_repository.dart';

Future<void> showDeleteInterviewDialog(context, int id) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'Do you really want to delete the interview?',
            style: TextStyle(
              fontSize: getViewportWidth(context) * 0.045,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
                child: Text('OK',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Averia Serif Libre",
                    )),
                onPressed: () async {
                  Response res = await interviewRepository.delete(id);

                  if (res.statusCode == 400) {
                    Map<String, dynamic> errorBody = jsonDecode(res.body);
                    Fluttertoast.showToast(msg: errorBody["details"]);
                  }
                  if (res.statusCode == 208) {
                    Map<String, dynamic> errorBody = jsonDecode(res.body);
                    Fluttertoast.showToast(msg: errorBody["details"]);
                  }
                  if (res.statusCode == 200) {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  }
                }),
            TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                      fontFamily: "Averia Serif Libre",
                    )),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                }),
          ],
        );
      });
}
