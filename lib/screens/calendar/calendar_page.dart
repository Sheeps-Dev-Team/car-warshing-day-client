import 'package:car_washing_day/util/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const SizedBox.shrink(),
        title: '세차언제',
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
