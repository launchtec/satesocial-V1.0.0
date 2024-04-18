import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/community/presentation/blocks/delete_post/delete_post_cubit.dart';
import '../util/dimensions.dart';

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