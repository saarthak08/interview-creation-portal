import 'package:flutter/material.dart';
import 'package:interview_app/src/models/user.dart';

class SelectParticipant extends StatelessWidget {
  final User participant;
  const SelectParticipant({Key? key, required this.participant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: NetworkImage(participant.picUrl.isEmpty
                ? "https://img.icons8.com/bubbles/2x/user-male.png"
                : participant.picUrl),
            radius: 30,
          ),
          Text(participant.name)
        ],
      ),
    );
  }
}
