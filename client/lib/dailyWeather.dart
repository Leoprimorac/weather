import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'package:weather_app/generalBusiness.dart';
import 'package:weather_app/weatherData.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({
    Key? key,
    required this.weatherdata,
  }) : super(key: key);
  final List<WeatherData> weatherdata;
  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  late List<WeatherData> weatherData;
  List<WeatherData> weatherList = [];
  ScrollController _controller = ScrollController();
  late DateTime date;
  var error = false;

  @override
  void initState() {
    date = DateTime.now();
    weatherData = widget.weatherdata;
    weatherList = GeneralBusiness().dataList(weatherData, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            weatherList = [];
            weatherList = [];
          });
          List<WeatherData> response = await GeneralBusiness().getData();
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          date = date.subtract(
                            Duration(days: 1),
                          );
                          setState(() {
                            weatherList =
                                GeneralBusiness().dataList(weatherData, date);
                          });
                        },
                        icon: Icon(Icons.chevron_left_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          date = date.add(
                            Duration(days: 1),
                          );
                          setState(() {
                            weatherList =
                                GeneralBusiness().dataList(weatherData, date);
                          });
                        },
                        icon: Icon(Icons.chevron_right_outlined),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    Jiffy(date).format('dd.MM.yyyy'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {
                          GeneralBusiness()
                              .selectDate(context, date)
                              .then((value) => setState(() {
                                    date = value;
                                    weatherList = GeneralBusiness()
                                        .dataList(weatherData, date);
                                  }));
                        },
                        child: Text(
                          'Izaberi dan',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: error || weatherList.isEmpty
                  ? error
                      ? Center(
                          child: Container(
                          child: Text('Pojavio se problem. Pokušajte ponovno!'),
                        ))
                      : Center(child: CircularProgressIndicator())
                  : WeatherList(
                      controller: _controller,
                      weatherList: weatherList,
                      weatherData: weatherData),
            ),
          ]),
        ),
      ),
    );
  }
}

class WeatherList extends StatelessWidget {
  const WeatherList({
    Key? key,
    required ScrollController controller,
    required this.weatherList,
    required this.weatherData,
  })  : _controller = controller,
        super(key: key);

  final ScrollController _controller;
  final List<WeatherData> weatherList;
  final List<WeatherData> weatherData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: weatherList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text((weatherList[index].date!.hour < 10 ? '0' : '') +
                      weatherList[index].date!.hour.toString() +
                      ':00'),
                ),
                weatherList[index].weatherDescription! == 'vedro'
                    ? Image.asset('assets/icons/F1.png')
                    : Image.asset('assets/icons/F3.png'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(weatherList[index].temperatureValue!),
                          Text(weatherList[index].humidityValue!),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(weatherList[index].weatherDescription!)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(weatherList[index].windDirectionValue!),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Text(weatherList[index].windSpeedValueInKMH!),
                          SizedBox(
                            height: 5,
                          ),
                          Text(weatherList[index].windSpeedValueInMS!),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(weatherData[index].pressureValue!),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }
}
