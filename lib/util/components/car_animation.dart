import 'package:car_washing_day/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CarAnimation extends StatefulWidget {
  const CarAnimation({super.key});

  @override
  State<CarAnimation> createState() => _CarAnimationState();
}

class _CarAnimationState extends State<CarAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.stop();
      }
    });

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/car_animation.json',
      width: 260 * sizeUnit,
      controller: _controller,
    );
  }
}
