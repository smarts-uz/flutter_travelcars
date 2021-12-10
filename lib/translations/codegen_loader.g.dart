// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "home_screen_Transport_services": "Transport services among all cities of Uzbekistan: travel and business",
  "city": "City",
  "Rate_change": "Rate change",
  "Currency": "Currency",
  "Most_popular_routes": "Most popular routes",
  "Most_popular_cars_book": "Most popular cars to book",
  "News_and_special_offers": "News and special offers"
};
static const Map<String,dynamic> ru = {
  "home_screen_Transport_services": "Транспортные услуги между всеми городами Узбекистана: путешествия и бизнесs",
  "city": "Город",
  "Rate_change": "Изменение ставки",
  "Currency": "Валюта",
  "Most_popular_routes": "Самые популярные путешествовать",
  "Most_popular_cars_book": "Самые популярные автомобили для бронирования",
  "News_and_special_offers": "Новости и специальные предложения"
};
static const Map<String,dynamic> uz = {
  "home_screen_Transport_services": "Oʻzbekistonning barcha shaharlari oʻrtasida transport xizmatlari: sayohat va biznes",
  "city": "Shahar",
  "Rate_change": "Narx o'zgarishi",
  "Currency": "Valyuta",
  "Most_popular_routes": "Eng mashhur sayohatlar",
  "Most_popular_cars_book": "Eng mashhur avtomobillar bron qilish",
  "News_and_special_offers": "Yangiliklar va maxsus takliflar"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru, "uz": uz};
}
