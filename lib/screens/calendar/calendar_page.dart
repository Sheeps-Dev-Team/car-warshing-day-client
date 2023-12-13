import 'package:car_washing_day/config/global_assets.dart';
import 'package:car_washing_day/util/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/constants.dart';
import '../../data/models/weather.dart';
import 'controllers/calendar_page_controller.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  final CalendarPageController controller = Get.put(CalendarPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
        child: GetBuilder<CalendarPageController>(builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Gap($style.insets.$16),

                /// header
                header(),
                Gap($style.insets.$24),

                /// calendar
                yearAndMonth(), // 년도, 달
                Gap($style.insets.$16),
                dayOfWeek(context), // 요일
                SizedBox(
                  height: 336 * sizeUnit,
                  child: calendar(), // 캘린더
                ),
                Divider(color: $style.colors.lightGrey, height: 1 * sizeUnit),

                /// estimatedDate
                SizedBox(
                  height: 160 * sizeUnit,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // 년도, 달
  Row yearAndMonth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => controller.calendarController.backward!(),
          child: SvgPicture.asset(
            GlobalAssets.svgArrowLeft,
            width: 16 * sizeUnit,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $style.insets.$8),
          child: Text(
            DateFormat('yyyy. MM.').format(controller.selectedDate),
            style: $style.text.headline16,
          ),
        ),
        RotatedBox(
          quarterTurns: 2,
          child: InkWell(
            onTap: () => controller.calendarController.forward!(),
            child: SvgPicture.asset(
              GlobalAssets.svgArrowLeft,
              width: 16 * sizeUnit,
            ),
          ),
        ),
      ],
    );
  }

  // 캘린더
  SfCalendar calendar() {
    // 셀 아이템
    Widget cellItem(MonthCellDetails details) {
      final int mid = details.visibleDates.length ~/ 2;
      final DateTime midDate = details.visibleDates[0].add(Duration(days: mid));
      final bool isCurrentMonth = details.date.month == midDate.month;
      final bool isSelected = controller.selectedDate == details.date;

      return Align(
        alignment: Alignment.topCenter,
        child: Opacity(
          opacity: isCurrentMonth ? 1 : .6,
          child: Container(
            width: 20 * sizeUnit,
            height: 20 * sizeUnit,
            // margin: EdgeInsets.only(bottom: 6 * sizeUnit),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? $style.colors.primary : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              details.date.day.toString(),
              style: $style.text.subTitle14.copyWith(
                color: isSelected
                    ? Colors.white
                    : isCurrentMonth
                        ? details.date.weekday == 7
                            ? $style.colors.red
                            : details.date.weekday == 6
                                ? $style.colors.primary
                                : null
                        : $style.colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    Widget appointmentsItem(CalendarAppointmentDetails calendarAppointmentDetails) {
      final Weather weather = calendarAppointmentDetails.appointments.first;

      return OverflowBox(
        maxHeight: 33 * sizeUnit,
        child: Column(
          children: [
            Gap(6 * sizeUnit),
            SvgPicture.asset(weather.getWeatherIcon, height: 27 * sizeUnit),
          ],
        ),
      );
    }

    return SfCalendar(
      controller: controller.calendarController,
      view: CalendarView.month,
      monthViewSettings: MonthViewSettings(
        agendaItemHeight: 48 * sizeUnit,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      viewHeaderHeight: 0,
      headerHeight: 0,
      dataSource: DiaryDataSource(controller.weatherList),
      onSelectionChanged: controller.onSelectionChanged,
      maxDate: controller.now.add(Duration(days: controller.weatherList.length - 1)),
      minDate: controller.now,
      initialDisplayDate: controller.now,
      initialSelectedDate: controller.now,
      selectionDecoration: const BoxDecoration(),
      monthCellBuilder: (context, detail) => cellItem(detail),
      appointmentBuilder: (context, calendarAppointmentDetails) => appointmentsItem(calendarAppointmentDetails),
    );
  }

  // 요일
  Widget dayOfWeek(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            controller.dayOfWeekList.length,
            (index) => Expanded(
              child: Center(
                child: Text(
                  controller.dayOfWeekList[index],
                  style: $style.text.headline12.copyWith(
                    color: index == 0
                        ? $style.colors.red
                        : index == controller.dayOfWeekList.length - 1
                            ? $style.colors.primary
                            : null,
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap($style.insets.$16),
        Divider(color: $style.colors.lightGrey, height: 1 * sizeUnit),
        Gap($style.insets.$24),
      ],
    );
  }

  Row header() {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: $style.text.title20.copyWith(color: $style.colors.primary),
              children: [
                const TextSpan(text: '로그인'),
                TextSpan(text: ' 하고\n', style: $style.text.title16),
                const TextSpan(text: '세차일을 등록'),
                TextSpan(text: ' 해 보세요!', style: $style.text.title16),
              ],
            ),
          ),
        ),
        CustomButton.small(
          text: '로그인 하기',
          onTap: () {},
        ),
      ],
    );
  }
}

class DiaryDataSource extends CalendarDataSource {
  DiaryDataSource(List<Weather> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getWeather(index).dateTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getWeather(index).dateTime;
  }

  @override
  String getSubject(int index) {
    return _getWeather(index).skyType.toString();
  }

  @override
  Color getColor(int index) {
    return $style.colors.primary;
  }

  @override
  Object? getId(int index) {
    return index;
  }

  Weather _getWeather(int index) {
    return appointments![index];
  }
}
