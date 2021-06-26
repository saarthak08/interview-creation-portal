import 'package:flutter/material.dart';
import 'package:interview_app/src/models/interviewer.dart';

class SelectInterviewer extends StatelessWidget {
  final Interviewer interviewer;
  final bool isActive;
  const SelectInterviewer(
      {Key? key, required this.interviewer, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: isActive ? Colors.blue : Colors.black,
            backgroundImage:
                NetworkImage("https://img.icons8.com/bubbles/2x/user-male.png"),
            radius: isActive ? 35 : 30,
          ),
          Text(
            interviewer.name,
            style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
          )
        ],
      ),
    );
  }
}
