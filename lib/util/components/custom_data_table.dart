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
  int hoverIndex = nullInt; // 현재 마우스 커서가 위치한 행의 인덱스 저장

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      extendWidthList.clear();

      w = (constraints.maxWidth - 2) /
          widget.columns
              .length; // (maxWidth - tablePadding - borderWidth) / columns.length;

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
          SizedBox(height: 16 * sizeUnit),
          Expanded(
            child: ListView.separated(
              itemCount: widget.rows.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 8 * sizeUnit),
              itemBuilder: (context, index) {
                return dataRow(
                  dataRow: widget.rows[index],
                  index: index,
                );
              },
            ),
          ),
          Divider(
            height: 1 * sizeUnit,
            thickness: 2 * sizeUnit,
            color: $style.colors.lightGrey,
          ),
        ],
      );
    });
  }

  Widget dataRow({required List<String> dataRow, required int index}) {
    return InkWell(
      onTap: () => widget.onRowTap(index),
      onHover: (value) => setState(() {
        if (value) {
          hoverIndex = index;
        } else {
          hoverIndex = nullInt;
        }
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular($style.corners.$4),
          border: Border.all(
              color: hoverIndex == index
                  ? $style.colors.primary
                  : $style.colors.grey),
        ),
        child: Row(
          children: List.generate(dataRow.length, (i) {
            return Container(
              alignment: Alignment.center,
              width: extendWidthList.isNotEmpty ? extendWidthList[i] : w,
              height: 36 * sizeUnit,
              child: Text(
                dataRow[i],
                style: $style.text.body14,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
        children: List.generate(widget.columns.length, (index) {
      return SizedBox(
        width: extendWidthList.isNotEmpty ? extendWidthList[index] : w,
        child: Column(
          children: [
            Text(
              widget.columns[index],
              style: $style.text.headline14,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Gap($style.insets.$8),
            Divider(
              height: 1 * sizeUnit,
              thickness: 2 * sizeUnit,
              color: $style.colors.lightGrey,
            ),
          ],
        ),
      );
    }));
  }
}
