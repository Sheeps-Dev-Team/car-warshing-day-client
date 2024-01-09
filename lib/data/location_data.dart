import 'package:car_washing_day/data/region_data.dart';
import 'package:flutter/material.dart';

//단기
Map<String, Map<String, String>> locationMap = {
  "서울특별시": seoulLocationMap,
  "인천광역시": incheonLocationMap,
  "경기도": gyeonggiLocationMap,
  "강원도영동": kangwonYeongdongLocationMap,
  "강원도영서": kangwonYeongseoLocationMap,
  "충청남도": chungnamLocationMap,
  "충청북도": chungbukLocationMap,
  "세종특별자치시": sejongLocationMap,
  "대전광역시": daejeonLocationMap,
  "경상북도": gyeongbukLocationMap,
  "경상남도": gyeongnamLocationMap,
  "대구광역시": daeguLocationMap,
  "부산광역시": busanLocationMap,
  "전라북도": jeonbukLocationMap,
  "전라남도": jeonnamLocationMap,
  "광주광역시": gwangjuLocationMap,
  "울산광역시": ulsanLocationMap,
  "제주특별자치도": jejuLocationMap,
};

final Map<String, String> seoulLocationMap = {
  for (int i = 0; i < areaSeoulCategory.length; i++)
    areaSeoulCategory[i]: areaSeoulLocation[i],
};

final Map<String, String> incheonLocationMap = {
  for (int i = 0; i < areaIncheonCategory.length; i++)
    areaIncheonCategory[i]: areaIncheonLocation[i],
};

final Map<String, String> gyeonggiLocationMap = {
  for (int i = 0; i < areaGyeonggiCategory.length; i++)
    areaGyeonggiCategory[i]: areaGyeonggiLocation[i],
};

final Map<String, String> kangwonYeongdongLocationMap = {
  for (int i = 0; i < areaKangwonYeongdongCategory.length; i++)
    areaKangwonYeongdongCategory[i]: areaKangwonYeongdongLocation[i],
};

final Map<String, String> kangwonYeongseoLocationMap = {
  for (int i = 0; i < areaKangwonYeongseoCategory.length; i++)
    areaKangwonYeongseoCategory[i]: areaKangwonYeongseoLocation[i],
};

final Map<String, String> daeguLocationMap = {
  for (int i = 0; i < areaDaeguCategory.length; i++)
    areaDaeguCategory[i]: areaDaeguLocation[i],
};

final Map<String, String> daejeonLocationMap = {
  for (int i = 0; i < areaDaejeonCategory.length; i++)
    areaDaejeonCategory[i]: areaDaejeonLocation[i],
};

final Map<String, String> chungbukLocationMap = {
  for (int i = 0; i < areaChungbukCategory.length; i++)
    areaChungbukCategory[i]: areaChungbukLocation[i],
};

final Map<String, String> sejongLocationMap = {
  for (int i = 0; i < areaSejongCategory.length; i++)
    areaSejongCategory[i]: areaSejongLocation[i],
};

final Map<String, String> chungnamLocationMap = {
  for (int i = 0; i < areaChungnamCategory.length; i++)
    areaChungnamCategory[i]: areaChungnamLocation[i],
};

final Map<String, String> gwangjuLocationMap = {
  for (int i = 0; i < areaGwangjuCategory.length; i++)
    areaGwangjuCategory[i]: areaGwangjuLocation[i],
};

final Map<String, String> jeonnamLocationMap = {
  for (int i = 0; i < areaJeonnamCategory.length; i++)
    areaJeonnamCategory[i]: areaJeonnamLocation[i],
};

final Map<String, String> jeonbukLocationMap = {
  for (int i = 0; i < areaJeonbukCategory.length; i++)
    areaJeonbukCategory[i]: areaJeonbukLocation[i],
};

final Map<String, String> busanLocationMap = {
  for (int i = 0; i < areaJeonbukCategory.length; i++)
    areaBusanCategory[i]: areaBusanLocation[i],
};

final Map<String, String> gyeongbukLocationMap = {
  for (int i = 0; i < areaGyeongbukCategory.length; i++)
    areaGyeongbukCategory[i]: areaGyeongbukLocation[i],
};

final Map<String, String> gyeongnamLocationMap = {
  for (int i = 0; i < areaGyeongnamCategory.length; i++)
    areaGyeongnamCategory[i]: areaGyeongnamLocation[i],
};

final Map<String, String> jejuLocationMap = {
  for (int i = 0; i < areaJejuCategory.length; i++)
    areaJejuCategory[i]: areaJejuLocation[i],
};

final Map<String, String> ulsanLocationMap = {
  for (int i = 0; i < areaUlsanCategory.length; i++)
    areaUlsanCategory[i]: areaUlsanLocation[i],
};

const List<String> areaSeoulLocation = [
  '61|126',
  '62|126',
  '61|128',
  '58|126',
  '59|125',
  '62|126',
  '58|125',
  '59|124',
  '61|129',
  '61|129',
  '61|127',
  '59|125',
  '59|127',
  '59|127',
  '61|125',
  '61|127',
  '61|127',
  '62|126',
  '58|126',
  '58|126',
  '60|126',
  '59|127',
  '60|127',
  '60|127',
  '62|128',
];

const List<String> areaIncheonLocation = [
  "51|130",
  "56|126",
  "56|124",
  "54|125",
  "54|124",
  "55|125",
  "55|126",
  "55|123",
  "54|124",
  "54|125",
];

const List<String> areaGyeonggiLocation = [
  "69|133",
  "57|128",
  "56|129",
  "56|129",
  "60|124",
  "58|125",
  "65|123",
  "62|127",
  "59|122",
  "55|128",
  "64|128",
  "61|134",
  "56|125",
  "62|123",
  "63|124",
  "63|124",
  "60|120",
  "61|120",
  "60|121",
  "61|121",
  "57|123",
  "57|121",
  "58|121",
  "65|115",
  "59|123",
  "59|123",
  "61|131",
  "69|125",
  "71|121",
  "61|138",
  "62|118",
  "62|120",
  "62|121",
  "64|119",
  "60|122",
  "61|130",
  "68|121",
  "56|131",
  "62|114",
  "64|134",
  "64|126",
  "57|119",
];

//강원영동지방
const List<String> areaKangwonYeongdongLocation = [
  "92|131",
  "85|145",
  "97|127",
  "98|125",
  "87|141",
  "88|138",
  "95|119",
];

//강원영서지방
const List<String> areaKangwonYeongseoLocation = [
  "77|139",
  "86|119",
  "76|122",
  "80|138",
  "89|123",
  "65|139",
  "73|134",
  "84|123",
  "75|130",
  "72|139",
  "77|125",
];

const List<String> areaDaeguLocation = [
  "89|90",
  "88|90",
  "86|88",
  "90|91",
  "89|91",
  "88|90",
  "89|90",
  "89|90",
];

const List<String> areaDaejeonLocation = [
  "68|100",
  "68|100",
  "67|100",
  "67|101",
  "68|100",
];

const List<String> areaChungbukLocation = [
  "74|111",
  "84|115",
  "73|103",
  "74|97",
  "71|99",
  "72|113",
  "81|118",
  "71|110",
  "68|111",
  "69|106",
  "69|107",
  "69|107",
  "67|106",
  "76|114",
];

const List<String> areaSejongLocation = ["66|103"];

const List<String> areaChungnamLocation = [
  "65|99",
  "63|102",
  "69|95",
  "62|97",
  "54|112",
  "54|100",
  "59|99",
  "51|110",
  "55|94",
  "60|110",
  "58|107",
  "63|110",
  "63|112",
  "57|103",
  "48|109",
  "55|106",
];

const List<String> areaGwangjuLocation = [
  "57|74",
  "59|73",
  "60|74",
  "59|75",
  "59|74",
];

const List<String> areaJeonnamLocation = [
  "57|63",
  "66|62",
  "66|77",
  "73|70",
  "69|75",
  "56|71",
  "61|78",
  "50|67",
  "52|71",
  "62|66",
  "70|70",
  "50|66",
  "73|66",
  "52|77",
  "56|66",
  "57|56",
  "57|77",
  "59|64",
  "48|59",
  "52|72",
  "54|61",
  "61|72",
];

const List<String> areaJeonbukLocation = [
  "56|80",
  "56|92",
  "59|88",
  "68|80",
  "72|93",
  "56|87",
  "63|79",
  "63|89",
  "60|91",
  "66|84",
  "70|85",
  "63|89",
  "63|89",
  "58|83",
  "68|88",
];

const List<String> areaBusanLocation = [
  "96|76",
  "98|77",
  "100|77",
  "98|75",
  "98|75",
  "98|76",
  "97|75",
  "96|76",
  "96|75",
  "96|74",
  "97|74",
  "99|75",
  "98|76",
  "98|74",
  "97|74",
  "99|75",
];

const List<String> areaGyeongbukLocation = [
  "91|90",
  "100|91",
  "83|87",
  "84|96",
  "88|99",
  "80|96",
  "81|106",
  "90|113",
  "81|102",
  "83|91",
  "91|106",
  "102|103",
  "97|108",
  "89|111",
  "95|93",
  "86|108",
  "127|127",
  "102|115",
  "90|101",
  "91|86",
  "96|103",
  "85|93",
  "102|94",
  "102|95",
];

const List<String> areaGyeongnamLocation = [
  "90|69",
  "77|86",
  "85|71",
  "95|77",
  "77|68",
  "92|83",
  "80|71",
  "76|80",
  "97|79",
  "83|78",
  "81|75",
  "87|83",
  "89|76",
  "89|76",
  "91|76",
  "90|77",
  "91|75",
  "87|68",
  "74|73",
  "86|77",
  "74|82",
  "81|84",
];

const List<String> areaJejuLocation = ["52|33", "53|38"];

const List<String> areaUlsanLocation = [
  "102|84",
  "104|83",
  "103|85",
  "101|84",
  "102|84",
];

// 중기 예보구역코드
Map<String, String> midTermLocationMap = {
  "서울특별시": '11B00000',
  "인천광역시": '11B00000',
  "경기도": '11B00000',
  "강원도영동": '11D20000',
  "강원도영서": '11D10000',
  "충청남도": '11C20000',
  "대전광역시": '11C20000',
  "세종특별자치시": '11C20000',
  "충청북도": '11C10000',
  "경상북도": '11H10000',
  "대구광역시": '11H10000',
  "경상남도": '11H20000',
  "부산광역시": '11H20000',
  "울산광역시": '11H20000',
  "전라북도": '11F10000',
  "전라남도": '11F20000',
  "광주광역시": '11F20000',
  "제주특별자치도": '11G00000',
};
