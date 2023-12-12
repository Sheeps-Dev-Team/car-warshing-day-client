import 'package:car_washing_day/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomDataTable extends StatefulWidget {
  const CustomDataTable(
      {super.key,
      required this.columns,
      required this.rows,
      required this.onRowTap,
      this.widthFlexList = const <int>[]});

  final List<String> columns;
  final List<List<String>> rows;
  final Function(int index) onRowTap;
  final List<int> widthFlexList;

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  late double w; //열의 너비
  List<double> extendWidthList = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      extendWidthList.clear();

      int maxFlex = 0;
      for (int element in widget.widthFlexList) {
        maxFlex += element;
      }

      if (widget.widthFlexList.isNotEmpty) {
        extendWidthList = List.generate(
            widget.widthFlexList.length,
            (index) =>
                (constraints.maxWidth - 2) *
                (widget.widthFlexList[index] / maxFlex));
      }

      return Column(
        children: [
          header(),
          Divider(
            height: 1 * sizeUnit,
            thickness: 1 * sizeUnit,
            color: $style.colors.grey,
          ),
          Gap($style.insets.$16),
          Expanded(
            child: ListView.separated(
              itemCount: widget.rows.length,
              separatorBuilder: (context, index) => Gap($style.insets.$16),
              itemBuilder: (context, index) {
                return dataRow(
                  dataRow: widget.rows[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget dataRow({required List<String> dataRow, required int index}) {
    return InkWell(
      onTap: () => widget.onRowTap(index),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(dataRow.length, (i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 7 * sizeUnit),
            alignment: Alignment.center,
            height: 16 * sizeUnit,
            child: Text(
              dataRow[i],
              style: $style.text.subTitle14.copyWith(
                  color: i == 1 ? $style.colors.grey : null,
                  fontWeight: i == 1
                      ? FontWeight.w400
                      : i == 2
                          ? FontWeight.w600
                          : FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }),
      ),
    );
  }

  Widget header() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.columns.length, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 7 * sizeUnit),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  widget.columns[index],
                  style: $style.text.headline14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Gap($style.insets.$8),
              ],
            ),
          );
        }));
  }
}
