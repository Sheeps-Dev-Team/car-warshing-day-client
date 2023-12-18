import 'dart:math';

import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/util/components/bubble/controllers/bubble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OneBubble extends StatefulWidget {
  OneBubble({
    required this.id,
    required this.screen,
  }) : super(key: ValueKey(id));

  final Size screen;
  final String id;

  @override
  _OneBubbleState createState() => _OneBubbleState();
}

class _OneBubbleState extends State<OneBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;

  late final double _startX, _moveX;
  late final double _startY;
  late final double _scale;

  final int _immutableMilliseconds = 500;
  final int _randomMilliseconds = (1500 * Random().nextDouble()).floor();
  double? fixedValue;

  late final double bubbleSize = widget.screen.height * .1 * sizeUnit;

  @override
  void initState() {
    _startX = (widget.screen.width * .7) * Random().nextDouble() + widget.screen.width *.14 - bubbleSize;
    _moveX = 10 + 10 * Random().nextDouble();
    _startY = (.4 + .3 * Random().nextDouble()) * widget.screen.height;
    _scale = .4 + .6 * Random().nextDouble();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: _immutableMilliseconds + _randomMilliseconds));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        BubbleController bubbleController = Get.find<BubbleController>();
        bubbleController.resetDrop(widget.id);
      } else if (status == AnimationStatus.forward) {
        Future.delayed(
          Duration(milliseconds: _immutableMilliseconds),
          () => fixedValue = _animation.value,
        );
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
    return Positioned(
      bottom: fixedValue != null ? _startY * (1 + (_animation.value - fixedValue)) : _startY,
      right: _startX + _moveX * _animation.value,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(_moveX * .1 / 360),
        child: Transform.scale(
          scale: _scale * _animation.value,
          child: SvgPicture.asset(
            'assets/images/global/bubble.svg',
            width: bubbleSize,
          ),
        ),
      ),
    );
  }
}
