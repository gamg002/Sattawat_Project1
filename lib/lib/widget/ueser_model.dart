class Usermodel {
  String id;
  String user;
  String password;
  String fname;
  String lname;
  String tel;
  String state;

  Usermodel(
      {this.id,
      this.user,
      this.password,
      this.fname,
      this.lname,
      this.tel,
      this.state});

  Usermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    password = json['password'];
    fname = json['fname'];
    lname = json['lname'];
    tel = json['tel'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['password'] = this.password;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['tel'] = this.tel;
    data['state'] = this.state;
    return data;
  }
}
