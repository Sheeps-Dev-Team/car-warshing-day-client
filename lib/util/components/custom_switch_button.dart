import 'package:car_washing_day/config/constants.dart';
import 'package:flutter/material.dart';

class CustomSwitchButton extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;

  const CustomSwitchButton({
    super.key,
    required this.values,
    required this.onToggleCallback,
  });
  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 77 * sizeUnit,
      height: 24 * sizeUnit,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 77 * sizeUnit,
              height: 24 * sizeUnit,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29 * sizeUnit),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.values.length,
                  (index) => Text(
                    widget.values[index],
                    style: $style.text.subTitle14
                        .copyWith(color: $style.colors.grey),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
                initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 40 * sizeUnit,
              height: 24 * sizeUnit,
              decoration: ShapeDecoration(
                color: $style.colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29 * sizeUnit),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: $style.text.subTitle14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
