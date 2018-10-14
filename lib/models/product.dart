import 'package:flutter/material.dart';

class Child {
  final String id;
  final String name;
  final String gender;
  final double age;
  final String user;
  final String password;
  final String parentEmail;
  final String parentId;



  Child(
      { @required this.id,
      @required this.name,
      @required this.gender,
      @required this.age,
        @required this.user,
        @required this.password,
        @required this.parentEmail,
       @required this.parentId,
        });
}
