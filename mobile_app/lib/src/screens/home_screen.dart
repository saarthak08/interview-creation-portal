import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_app/src/dialogs/create_interview.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/helper/dummy_data.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:interview_app/src/widgets/interview_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var vpH, vpW;

  @override
  Widget build(BuildContext context) {
    vpH = getViewportHeight(context);
    vpW = getViewportWidth(context);
    List<Interview> interviews =
        list.map((e) => Interview.fromJSON(e)).toList();

    interviews.sort((a, b) => a.startTime.compareTo(b.startTime));
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: interviews.length == 0 ? vpH * 0.4 : vpH * 0.18,
                ),
                interviews.length == 0
                    ? Center(
                        child: Container(
                          height: vpW * 0.7,
                          width: vpW * 0.6,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/img/no_interview.svg',
                                height: vpW * 0.6,
                                width: vpW * 0.6,
                              ),
                              Text(
                                "No Interviews",
                                style: TextStyle(
                                  fontSize: vpW * 0.07,
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: interviews.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Interview interview = interviews[index];
                          return InterviewCard(interview: interview);
                        },
                      ),
              ],
            ),
            Container(
              height: getViewportHeight(context) * 0.168,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 10.0,
                    )
                  ],
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getViewportWidth(context) * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Interview Schedules",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getViewportHeight(context) * 0.04,
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: getViewportHeight(context) * 0.13,
                  ),
                  Center(
                    child: FloatingActionButton(
                      splashColor: Colors.red,
                      backgroundColor: Colors.white,
                      elevation: 5,
                      child: Icon(Icons.add,
                          size: getViewportHeight(context) * 0.05,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        showCreateInterviewDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
