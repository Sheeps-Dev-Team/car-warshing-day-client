import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child, this.canPop, this.onPopInvoked});

  final Widget child;
  final bool? canPop;
  final Function(bool didPop)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PopScope(
        canPop: canPop ?? true,
        onPopInvoked: onPopInvoked,
        child: Container(
          color: Colors.white,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0), //사용자 스케일팩터 무시
            child: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
