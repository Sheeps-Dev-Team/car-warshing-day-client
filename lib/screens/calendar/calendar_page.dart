import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/constants.dart';
import '../../data/models/weather.dart';
import 'controllers/calendar_page_controller.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leading: SizedBox.shrink(),
        title: '세차언제',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: $style.insets.$16),
        child: GetBuilder<CalendarPageController>(
            init: Get.put(CalendarPageController()),
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    height: 484 * sizeUnit,
                    child: SfCalendar(
                      controller: controller.calendarController,
                      view: CalendarView.month,
                      monthViewSettings: const MonthViewSettings(
                        // dayFormat: 'EEE',
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                      ),

                      // headerStyle: CalendarHeaderStyle(
                      //   textStyle: $style.text.headline14,
                      // ),
                      // viewHeaderStyle: ViewHeaderStyle(
                      //   dayTextStyle: $style.text.headline12,
                      // ),
                      dataSource: DiaryDataSource(controller.weatherList),
                      headerHeight: 0,
                      // viewHeaderHeight: 0 * sizeUnit,
                      // headerDateFormat: 'yyyy년 MM월',
                      maxDate: controller.now.add(Duration(days: controller.weatherList.length - 1)),
                      minDate: controller.now,
                      initialDisplayDate: controller.now,
                      initialSelectedDate: controller.now,
                      monthCellBuilder: (context, detail) => cellItem(detail),
                      appointmentBuilder: (context, calendarAppointmentDetails) => appointmentsItem(calendarAppointmentDetails),
                      // specialRegions: [TimeRegion(startTime: controller.now, endTime: controller.now.add(const Duration(days: 3)))],
                      // timeRegionBuilder: (context, timeRegionDetails) => Container(width: 20, height: 20,color: Colors.redAccent,),
                      // allowAppointmentResize: true,
                      // appoint
                      // onSelectionChanged: (details) => controller.onSelectionChanged(details.date!),
                      // onViewChanged: (details) => controller.onViewChanged(details),
                      // selectionDecoration: BoxDecoration(
                      // image: DecorationImage(image: Image.asset(pngCheck).image),
                      // ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  // 셀 아이템
  Widget cellItem(MonthCellDetails details) {
    final int mid = details.visibleDates.length ~/ 2;
    final DateTime midDate = details.visibleDates[0].add(Duration(days: mid));

    return Opacity(
      opacity: details.date.month == midDate.month ? 1 : .6,
      child: Padding(
        padding: EdgeInsets.all(2 * sizeUnit),
        // decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular($style.corners.$8),
        // color: Colors.white,
        // border: Border.all(color: $style.colors.grey, width: 1 * sizeUnit),
        // ),
        child: Text(
          details.date.day.toString(),
          style: $style.text.subTitle12.copyWith(
            color: details.date.weekday == 7
                ? $style.colors.red
                : details.date.weekday == 6
                    ? $style.colors.primary
                    : null,
          ),
        ),
      ),
    );
  }

  Widget appointmentsItem(CalendarAppointmentDetails calendarAppointmentDetails) {
    final Weather weather = calendarAppointmentDetails.appointments.first;

    return OverflowBox(
      maxHeight: 27 * sizeUnit,
      child: SvgPicture.asset(weather.getWeatherIcon, height: 27 * sizeUnit),
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
  String getSubject(int index) {
    return _getWeather(index).skyType.toString();
  }

  @override
  Color getColor(int index) {
    return $style.colors.primary;
  }

  Weather _getWeather(int index) {
    return appointments![index];
  }
}
