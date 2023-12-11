import 'dart:math';

import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/data/models/weather.dart';
import 'package:car_washing_day/util/components/rain/controllers/rain_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OneDrop extends StatefulWidget {
  OneDrop({
    required this.id,
    required this.screen,
    required this.rainingType,
  }) : super(key: ValueKey(id));

  final Size screen;
  final String id;
  final RainingType rainingType;

  @override
  _OneDropState createState() => _OneDropState();
}

class _OneDropState extends State<OneDrop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;

  late final double _startX, _moveX;
  late final double _opacity;
  late final double _scale;
  late final Duration _duration;
  final bool isRain = Random().nextBool();

  @override
  void initState() {
    _startX = widget.screen.width * Random().nextDouble() + widget.screen.width / 20;
    _moveX = 10 + 10 * Random().nextDouble();
    _opacity = .6 + .4 * Random().nextDouble();
    _scale = .6 + .4 * Random().nextDouble();

    final Duration rainDuration = Duration(milliseconds: 200 + (400 * Random().nextDouble()).floor());
    final Duration snowDuration = Duration(milliseconds: 800 + (800 * Random().nextDouble()).floor());
    _duration = widget.rainingType == RainingType.rain
        ? rainDuration
        : widget.rainingType == RainingType.snow
            ? snowDuration
            : isRain
                ? rainDuration
                : snowDuration;

    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        RainController rainController = Get.find<RainController>();
        rainController.resetDrop(widget.id);
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
    final double dropHeight = widget.screen.height * .1 * sizeUnit;
    final double dropWidth = dropHeight * .04 * sizeUnit;

    return Positioned(
      top: (widget.screen.height + dropHeight) * _animation.value - dropHeight,
      right: _startX + _moveX * _animation.value,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(_moveX * .1 / 360),
        child: Transform.scale(
          scale: _scale,
          child: dropWidget(dropHeight, dropWidth),
        ),
      ),
    );
  }

  Widget dropWidget(double dropHeight, double dropWidth) {
    switch (widget.rainingType) {
      case RainingType.rain:
        return rainDropWidget(dropHeight, dropWidth);
      case RainingType.snow:
        return snowDropWidget();
      case RainingType.rainAndSnow:
        return isRain ? rainDropWidget(dropHeight, dropWidth) : snowDropWidget();
      default:
        return const SizedBox.shrink();
    }
  }

  Container rainDropWidget(double dropHeight, double dropWidth) {
    return Container(
      height: dropHeight,
      width: dropWidth,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(_opacity),
        borderRadius: BorderRadius.circular($style.corners.$24),
      ),
    );
  }

  Widget snowDropWidget() {
    return SvgPicture.asset(
      GlobalAssets.svgSnow,
      width: 20 * sizeUnit,
      colorFilter: ColorFilter.mode(
        Colors.blueGrey.withOpacity(_opacity - .4),
        BlendMode.srcIn,
      ),
    );
  }
}
