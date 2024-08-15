// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoggedInUserModel {
  String? email;
  String? phone;
  String? name;
  String? id;
  LoggedInUserModel({
    this.email,
    this.phone,
    this.name,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'phone': phone,
      'name': name,
      'id': id,
    };
  }

  factory LoggedInUserModel.fromJson(Map<String, dynamic> map) {
    return LoggedInUserModel(
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }


}
