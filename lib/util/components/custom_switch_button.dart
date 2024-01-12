import 'package:car_washing_day/config/constants.dart';
import 'package:flutter/material.dart';

class CustomSwitchButton extends StatelessWidget {
  final List<String> values;
  final bool value;
  final ValueChanged<bool> onToggleCallback;

  const CustomSwitchButton({
    super.key,
    required this.values,
    required this.value,
    required this.onToggleCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106 * sizeUnit,
      height: 32 * sizeUnit,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onToggleCallback(!value);
            },
            child: Container(
              width: 106 * sizeUnit,
              height: 32 * sizeUnit,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(29 * sizeUnit), border: Border.all(color: $style.colors.lightGrey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  values.length,
                  (index) => Text(
                    values[index],
                    style: $style.text.subTitle14.copyWith(color: $style.colors.grey),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: value ? Alignment.centerLeft : Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                onToggleCallback(!value);
              },
              child: Container(
                width: 56 * sizeUnit,
                height: 32 * sizeUnit,
                decoration: ShapeDecoration(
                  color: $style.colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29 * sizeUnit),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  value ? values[0] : values[1],
                  style: $style.text.subTitle14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
