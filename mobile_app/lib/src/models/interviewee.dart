class Interviewee {
  int _id = 0;
  String _name = "";
  String _email = "";
  String _resumeURL = "";

  get id => this._id;

  set id(value) => this._id = value;

  get name => this._name;

  set name(value) => this._name = value;

  get email => this._email;

  set email(value) => this._email = value;

  get resumeURL => this._resumeURL;

  set resumeURL(value) => this._resumeURL = value;

  Interviewee.empty();

  Interviewee.fromJSON(Map<String, dynamic> map) {
    try {
      this._id = map["id"];
      this._name = map["name"];
      this._email = map["email"];
      this._resumeURL = map["resumeURL"] == null ? "" : map["resumeURL"];
    } catch (err) {
      print("Error in parsing JSON to Interviewee object: " + err.toString());
    }
  }
}
