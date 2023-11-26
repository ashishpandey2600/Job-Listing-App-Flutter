class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? userType;

  UserModel(
      {this.uid, this.fullname, this.email, this.profilepic, this.userType});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    userType = map["userType"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
       "userType": userType
    };
  }
}
