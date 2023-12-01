import 'dart:math';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/weather.dart';

class CalendarPageController extends GetxController {
  final CalendarController calendarController = CalendarController();
  final DateTime now = DateTime.now();

  late final List<Weather> weatherList = List.generate(
    30,
    (index) => Weather(
      skyType: SkyType.values[Random().nextInt(SkyType.values.length)],
      rainingType: RainingType.values[Random().nextInt(RainingType.values.length)],
      pop: Random().nextInt(100),
      pcp: '강수 없음',
      dateTime: now.add(Duration(days: index)),
    ),
  );
}
