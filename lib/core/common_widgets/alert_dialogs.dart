import 'package:flutter/material.dart';

class AlertDialogs {
  static showLoaderDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => new Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          child: new Container(
              alignment: FractionalOffset.center,
              height: 50.0,
              child:  CircularProgressIndicator()
          ),
        ));
  }
}