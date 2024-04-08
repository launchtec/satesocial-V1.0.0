import 'package:flutter/material.dart';

class AlertDialogs {
  static showLoaderDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          child: Container(
              alignment: FractionalOffset.center,
              height: 50.0,
              child: const CircularProgressIndicator()
          ),
        ));
  }
}