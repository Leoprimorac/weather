import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:weather_app/weatherData.dart';

class GeneralBusiness {
  List<WeatherData> dataList(List<WeatherData> weatherData, date) {
    
    return weatherData.isEmpty
          ? []
          : weatherData.where((element) {
              return element.date!.year == date.year &&
                  element.date!.month == date.month &&
                  element.date!.day == date.day;
            }).toList();;
  
}
  Future<DateTime> selectDate(BuildContext context, DateTime date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date) return picked;
    return DateTime.now();
  }

  Future<List<WeatherData>> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final keyApplicationId = 'dw0s36y7mlb5mFqQ1Ifou3ykkuFpD9M2F2Cf6M3D';
    final keyClientKey = 'ngGsECaD3hC142Bs6BTw6NlQUuxfeaPDjY0vUgyM';
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
    QueryBuilder<ParseObject> queryPerson =
        QueryBuilder<ParseObject>(ParseObject('weather'));
    List<WeatherData> data = [];
    final ParseResponse apiResponse;
    try {
      apiResponse = await queryPerson.query();
    } on Exception catch (e) {
      throw (e);
    }
    if (apiResponse.success && apiResponse.results != null) {
      apiResponse.results?.forEach((element) {
        data.add(WeatherData.fromParse(element));
      });
      
      return data;
    } else {
      return [];
    }
  }
}
