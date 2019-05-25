import 'dart:convert';

Password passwordFromJson(String str) {
    final jsonData = json.decode(str);
    return Password.fromJson(jsonData);
}

String clientToJson(Password data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Password {
  int id;
  String appName;
  String password;

  Password({this.id, this.appName, this.password});

  Password.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['password'] = this.password;
    return data;
  }
}