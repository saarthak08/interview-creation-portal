class User {
  String id = "";
  String name = "";
  String email = "";
  String picUrl = "";

  get getid => this.id;
  set setid(value) => this.id = value;

  get getname => this.name;
  set setname(value) => this.name = value;

  get getemail => this.email;
  set setemail(value) => this.email = value;

  get getpicUrl => this.picUrl;
  set setpicUrl(value) => this.picUrl = value;

  User.fromJSON(Map<String, dynamic> map) {
    try {
      this.id = map["id"];
      this.name = map["name"];
      this.email = map["email"];
      this.picUrl = map["picUrl"];
    } catch (err) {
      print("Error in parsing JSON to Interview Object: " + err.toString());
    }
  }
}
