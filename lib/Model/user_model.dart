class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel({this.id, this.name, this.email, this.profileImage, this.phoneNumber, this.about, this.createAt, this.lastOnlineStatus, this.status, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    profileImage = json["profileImage"];
    phoneNumber = json["phoneNumber"];
    about = json["about"];
    createAt = json["createAt"];
    lastOnlineStatus = json["lastOnlineStatus"];
    status = json["status"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["profileImage"] = profileImage;
    _data["phoneNumber"] = phoneNumber;
    _data["about"] = about;
    _data["createAt"] = createAt;
    _data["lastOnlineStatus"] = lastOnlineStatus;
    _data["status"] = status;
    _data["role"] = role;
    return _data;
  }
}