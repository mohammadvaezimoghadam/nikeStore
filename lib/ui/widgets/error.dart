import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikestore/common/exception.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onPressed;
  const AppErrorWidget({
    Key? key,
    required this.exception,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(onPressed: onPressed, child: Text('دباره امتحان کنید'))
        ],
      ),
    );
  }
}