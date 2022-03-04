import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class WeatherData {

  DateTime? date;
  String? windDirectionLabel;
  String? windDirectionValue;
  String? windSpeedLabel;
  String? windSpeedValueInMS;
  String? windSpeedValueInKMH;
  String? weatherDescription;
  String? humidityLabel;
  String? humidityValue;
  String? temperatureValue;
  String? pressureValue;
  String? pressureLabel;
  String? predictionDateOne;
  String? predictionDateTwo;
  String? predictionDateThree;
  String? predictionDateFour;
  String? predictionDateOneValueMorning;
  String? predictionDateOneValueDay;
  String? predictionDateTwoValueMorning;
  String? predictionDateTwoValueDay;
  String? predictionDateThreeValueMorning;
  String? predictionDateThreeValueDay;
  String? predictionDateFourValueMorning;
  String? predictionDateFourValueDay;
  WeatherData({
    this.date,
    this.windDirectionLabel,
    this.windDirectionValue,
    this.windSpeedLabel,
    this.windSpeedValueInMS,
    this.windSpeedValueInKMH,
    this.weatherDescription,
    this.humidityLabel,
    this.humidityValue,
    this.temperatureValue,
    this.pressureValue,
    this.pressureLabel,
    this.predictionDateOne,
    this.predictionDateTwo,
    this.predictionDateThree,
    this.predictionDateFour,
    this.predictionDateOneValueMorning,
    this.predictionDateOneValueDay,
    this.predictionDateTwoValueMorning,
    this.predictionDateTwoValueDay,
    this.predictionDateThreeValueMorning,
    this.predictionDateThreeValueDay,
    this.predictionDateFourValueMorning,
    this.predictionDateFourValueDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'windDirectionLabel': windDirectionLabel,
      'windDirectionValue': windDirectionValue,
      'windSpeedLabel': windSpeedLabel,
      'windSpeedValueInMS': windSpeedValueInMS,
      'windSpeedValueInKMH': windSpeedValueInKMH,
      'weatherDescription': weatherDescription,
      'humidityLabel': humidityLabel,
      'humidityValue': humidityValue,
      'temperatureValue': temperatureValue,
      'pressureValue': pressureValue,
      'pressureLabel': pressureLabel,
      'predictionDateOne': predictionDateOne,
      'predictionDateTwo': predictionDateTwo,
      'predictionDateThree': predictionDateThree,
      'predictionDateFour': predictionDateFour,
      'predictionDateOneValueMorning': predictionDateOneValueMorning,
      'predictionDateOneValueDay': predictionDateOneValueDay,
      'predictionDateTwoValueMorning': predictionDateTwoValueMorning,
      'predictionDateTwoValueDay': predictionDateTwoValueDay,
      'predictionDateThreeValueMorning': predictionDateThreeValueMorning,
      'predictionDateThreeValueDay': predictionDateThreeValueDay,
      'predictionDateFourValueMorning': predictionDateFourValueMorning,
      'predictionDateFourValueDay': predictionDateFourValueDay,
    };
  }
factory WeatherData.fromParse(ParseObject parseObject) {
  return WeatherData(
      date: parseObject.get<DateTime>('date') != null ? parseObject.get<DateTime>('date') : null,
      windDirectionLabel: parseObject.get('windDirectionLabel'),
      windDirectionValue: parseObject.get('windDirectionValue'),
      windSpeedLabel: parseObject.get('windSpeedLabel'),
      windSpeedValueInMS: parseObject.get('windSpeedValueInMS'),
      windSpeedValueInKMH: parseObject.get('windSpeedValueInKMH'),
      weatherDescription: parseObject.get('weatherDescription'),
      humidityLabel: parseObject.get('humidityLabel'),
      humidityValue: parseObject.get('humidityValue'),
      temperatureValue: parseObject.get('temperatureValue'),
      pressureValue: parseObject.get('pressureValue'),
      pressureLabel: parseObject.get('pressureLabel'),
      predictionDateOne: parseObject.get('predictionDateOne'),
      predictionDateTwo: parseObject.get('predictionDateTwo'),
      predictionDateThree: parseObject.get('predictionDateThree'),
      predictionDateFour: parseObject.get('predictionDateFour'),
      predictionDateOneValueMorning: parseObject.get('predictionDateOneValueMorning'),
      predictionDateOneValueDay: parseObject.get('predictionDateOneValueDay'),
      predictionDateTwoValueMorning: parseObject.get('predictionDateTwoValueMorning'),
      predictionDateTwoValueDay: parseObject.get('predictionDateTwoValueDay'),
      predictionDateThreeValueMorning: parseObject.get('predictionDateThreeValueMorning'),
      predictionDateThreeValueDay: parseObject.get('predictionDateThreeValueDay'),
      predictionDateFourValueMorning: parseObject.get('predictionDateFourValueMorning'),
      predictionDateFourValueDay: parseObject.get('predictionDateFourValueDay'),
  );
}
       
  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      windDirectionLabel: map['windDirectionLabel'],
      windDirectionValue: map['windDirectionValue'],
      windSpeedLabel: map['windSpeedLabel'],
      windSpeedValueInMS: map['windSpeedValueInMS'],
      windSpeedValueInKMH: map['windSpeedValueInKMH'],
      weatherDescription: map['weatherDescription'],
      humidityLabel: map['humidityLabel'],
      humidityValue: map['humidityValue'],
      temperatureValue: map['temperatureValue'],
      pressureValue: map['pressureValue'],
      pressureLabel: map['pressureLabel'],
      predictionDateOne: map['predictionDateOne'],
      predictionDateTwo: map['predictionDateTwo'],
      predictionDateThree: map['predictionDateThree'],
      predictionDateFour: map['predictionDateFour'],
      predictionDateOneValueMorning: map['predictionDateOneValueMorning'],
      predictionDateOneValueDay: map['predictionDateOneValueDay'],
      predictionDateTwoValueMorning: map['predictionDateTwoValueMorning'],
      predictionDateTwoValueDay: map['predictionDateTwoValueDay'],
      predictionDateThreeValueMorning: map['predictionDateThreeValueMorning'],
      predictionDateThreeValueDay: map['predictionDateThreeValueDay'],
      predictionDateFourValueMorning: map['predictionDateFourValueMorning'],
      predictionDateFourValueDay: map['predictionDateFourValueDay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherData.fromJson(String source) => WeatherData.fromMap(json.decode(source));
}
