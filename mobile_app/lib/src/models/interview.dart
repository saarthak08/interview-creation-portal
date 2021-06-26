import 'package:interview_app/src/models/interviewee.dart';
import 'package:interview_app/src/models/interviewer.dart';

class Interview {
  String _id = "";
  String _date = "";
  Interviewee _interviewee = Interviewee.empty();
  Interviewer _interviewer = Interviewer.empty();
  int _startTime = 0;
  int _endTime = 0;
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
      this._id = map["id"];
      this._interviewer = Interviewer.fromJSON(map["interviewer"]);
      this._interviewee = Interviewee.fromJSON(map["interviewee"]);
      this._startTime = map["startTime"];
      this._endTime = map["endTime"];
      this._date = map["date"];
    } catch (err) {
      print("Error in parsing JSON to Interview Object: " + err.toString());
    }
  }
}
