import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RouteManager{
  static void navigateTo(BuildContext context , Widget screen){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}