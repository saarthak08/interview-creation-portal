import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_app/src/dialogs/create_interview.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/models/interview.dart';
import 'package:interview_app/src/repository/interview_repository.dart';
import 'package:interview_app/src/widgets/interview_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  var vpH, vpW;
  ValueNotifier<List<Interview>> interviews =
      ValueNotifier<List<Interview>>([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      refreshIndicatorKey.currentState?.show();
    });
  }

  Future<void> fetchInterviews() async {
    await interviewRepository.getInterviews().then((res) {
      List<dynamic> interviewList = [];
      jsonDecode(res.body).forEach((ele) {
        interviewList.add(Interview.fromJSON(ele));
      });
      interviews.value = List.from(interviewList);
    });
  }

  @override
  Widget build(BuildContext context) {
    vpH = getViewportHeight(context);
    vpW = getViewportWidth(context);

    interviews.value.sort((a, b) => a.startTime.compareTo(b.startTime));
    return Scaffold(
        body: RefreshIndicator(
      key: refreshIndicatorKey,
      color: Colors.blue,
      onRefresh: () {
        return fetchInterviews();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: interviews,
              builder: (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height:
                        interviews.value.length == 0 ? vpH * 0.4 : vpH * 0.18,
                  ),
                  interviews.value.length == 0
                      ? Center(
                          child: Container(
                            height: vpH * 0.7,
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
                          padding: EdgeInsets.symmetric(vertical: vpH * 0.05),
                          itemCount: interviews.value.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Interview interview = interviews.value[index];
                            return InterviewCard(
                                interview: interview,
                                refreshIndicatorKey: refreshIndicatorKey);
                          },
                        ),
                ],
              ),
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
                      "Interviews",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getViewportHeight(context) * 0.05,
                          fontFamily: "Pacifico"),
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
                      splashColor: Colors.blue,
                      backgroundColor: Colors.white,
                      elevation: 5,
                      child: Icon(Icons.add,
                          size: getViewportHeight(context) * 0.05,
                          color: Theme.of(context).primaryColor),
                      onPressed: () async {
                        await showCreateInterviewDialog(context: context);
                        refreshIndicatorKey.currentState?.show();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
