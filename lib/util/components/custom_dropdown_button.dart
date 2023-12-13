import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/global_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {super.key,
      required this.value,
      required this.items,
      required this.hintText,
      this.borderRadius,
      required this.onChanged,
      this.border,
      this.prefixIcon});

  final String? value;
  final List<String> items;
  final String hintText;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Widget? prefixIcon;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: $style.corners.$8),
      //width: double.infinity,
      width: 328 * sizeUnit,
      height: 48 * sizeUnit,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular($style.corners.$8),
        border: border,
      ),
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
          ],
          Gap($style.insets.$8),
          Expanded(
            child: DropdownButton<String>(
              onChanged: onChanged,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              hint: Text(
                hintText,
                style: $style.text.subTitle16
                    .copyWith(color: $style.colors.primary, height: 1.0),
              ),
              icon: SvgPicture.asset(GlobalAssets.svgDropdown),
              borderRadius:
                  borderRadius ?? BorderRadius.circular($style.corners.$8),
              value: value,
              dropdownColor: Colors.white,
              itemHeight: 48 * sizeUnit,
              menuMaxHeight: 500 * sizeUnit,
              items: List.generate(items.length, (index) {
                final String value = items[index];

                return DropdownMenuItem(
                  value: value,
                  child: Text(value,
                      style: $style.text.subTitle16.copyWith(height: 1.0)),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}