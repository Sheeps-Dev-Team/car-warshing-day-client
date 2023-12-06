import 'package:car_washing_day/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BubbleLump extends StatefulWidget {
  const BubbleLump({super.key});

  @override
  State<BubbleLump> createState() => _BubbleLumpState();
}

class _BubbleLumpState extends State<BubbleLump> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  final double _minScale = .7;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
      ..forward()
      ..addListener(() {
        if (_controller.isCompleted) _controller.repeat(min: _minScale, reverse: true);
        setState(() {});
      });

    _animation = Tween<double>(begin: _minScale, end: 1).animate(_controller);

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
      bottom: 20 * sizeUnit,
      child: Transform.scale(
        scale: _animation.value,
        child: SvgPicture.asset(
          'assets/images/global/bubble_lump.svg',
          width: 240 * sizeUnit,
        ),
      ),
    );
  }
}
