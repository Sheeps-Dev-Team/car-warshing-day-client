import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key, required this.child, this.onWillPop, this.selectedCategory}) : super(key: key);

  final Widget child;
  final Future<bool> Function()? onWillPop;
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          color: Colors.white,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), //사용자 스케일팩터 무시
            child: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
