class Interview {
  String id = "";
  String interviewer = "";
  String intervieweremail = "";
  String interviewee = "";
  String intervieweeemail = "";
  String startTime = "";
  String endTime = "";
  String duration = "";

  get getid => this.id;
  set setid(value) => this.id = value;

  get getinterviewer => this.interviewer;
  set setinterviewer(value) => this.interviewer = value;

  get getintervieweremail => this.intervieweremail;
  set setintervieweremail(value) => this.intervieweremail = value;

  get getinterviewee => this.interviewee;
  set setinterviewee(value) => this.interviewee = value;

  get getintervieweeemail => this.intervieweeemail;
  set setintervieweeemail(value) => this.intervieweeemail = value;

  get getstartTime => this.startTime;
  set setstartTime(value) => this.startTime = value;

  get getendTime => this.endTime;
  set setendTime(value) => this.endTime = value;

  get getduration => this.duration;
  set setduration(value) => this.duration = value;

  Interview.fromJSON(Map<String, dynamic> map) {
    try {
      this.id = map["id"];
      this.interviewer = map["interviewer"];
      this.interviewee = map["interviewee"];
      this.startTime = map["startTime"];
      this.endTime = map["endTime"];
      this.duration = map["duration"];
    } catch (err) {
      print("Error in parsing JSON to Interview Object: " + err.toString());
    }
  }
}
