enum SkyType { sunny, cloudy, overcast } // 하늘 상태 - 맑음, 구름 많음, 흐림

enum RainingType { none, rain, rainAndSnow, snow} // 강수 형태 - 없음, 비, 비/눈, 눈

class Weather {
  Weather({
    required this.skyType,
    required this.rainingType,
    required this.pop,
    required this.pcp,
    required this.dateTime,
  });

  final SkyType skyType; // 하늘 상태
  final RainingType rainingType; // 강수 형태
  final int pop; // 강수 확률
  final String pcp; // 1시간 강수량
  final DateTime dateTime;
}