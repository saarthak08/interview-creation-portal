import 'package:interview_app/src/models/interviewee.dart';
import 'package:interview_app/src/models/interviewer.dart';

class Interview {
  int _id = 0;
  String _date = "";
  Interviewee _interviewee = Interviewee.empty();
  Interviewer _interviewer = Interviewer.empty();
  int _startTime = 1624690372;
  int _endTime = 1624690392;
  String _duration = "";

  get id => this._id;

  set id(value) => this._id = value;

  get date => this._date;

  set date(value) => this._date = value;

  get interviewee => this._interviewee;

  set interviewee(value) => this._interviewee = value;

  get interviewer => this._interviewer;

  set interviewer(value) => this._interviewer = value;

  get startTime => this._startTime;

  set startTime(value) => this._startTime = value;

  get endTime => this._endTime;

  set endTime(value) => this._endTime = value;

  get duration => this._duration;

  set duration(value) => this._duration = value;

  Interview.fromJSON(Map<String, dynamic> map) {
    try {
      this._id = map["id"] ?? 0;
      if (map["interviewer"] is Map<String, dynamic>) {
        this._interviewer = Interviewer.fromJSON(map["interviewer"]);
      } else {
        this._interviewer = map["interviewer"];
      }
      if (map["interviewee"] is Map<String, dynamic>) {
        this._interviewee = Interviewee.fromJSON(map["interviewee"]);
      } else {
        this._interviewee = map["interviewee"];
      }
      this._startTime = map["startTiming"];
      this._endTime = map["endTiming"];
      this._date = map["date"];
    } catch (err) {
      print("Error in parsing JSON to Interview Object: " + err.toString());
    }
  }
}
