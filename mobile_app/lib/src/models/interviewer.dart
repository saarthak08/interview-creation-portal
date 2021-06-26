class Interviewer {
  int _id = 0;
  String _name = "";
  String _email = "";
  String _employeeCode = "";
  get id => this._id;

  set id(value) => this._id = value;

  get name => this._name;

  set name(value) => this._name = value;

  get email => this._email;

  set email(value) => this._email = value;

  get employeeCode => this._employeeCode;

  set employeeCode(value) => this._employeeCode = value;

  Interviewer.empty();

  Interviewer.fromJSON(Map<String, dynamic> map) {
    try {
      this._id = map["id"];
      this._name = map["name"];
      this._email = map["email"];
      this._employeeCode = map["employeeCode"];
    } catch (err) {
      print("Error in parsing JSON to Interviewer object: " + err.toString());
    }
  }
}
