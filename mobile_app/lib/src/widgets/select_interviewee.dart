import 'package:flutter/material.dart';
import 'package:interview_app/src/models/interviewee.dart';

class SelectInterviewee extends StatelessWidget {
  final Interviewee interviewee;
  final bool isActive;
  const SelectInterviewee(
      {Key? key, required this.interviewee, required this.isActive})
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
            interviewee.name,
            style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
          )
        ],
      ),
    );
  }
}
