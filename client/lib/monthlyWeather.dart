import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:weather_app/generalBusiness.dart';
import 'package:weather_app/weatherData.dart';

class MonthlyWeather extends StatefulWidget {
  const MonthlyWeather({Key? key, required this.weatherData}) : super(key: key);
  final List<WeatherData> weatherData;
  @override
  State<MonthlyWeather> createState() => _MonthlyWeatherState();
}

class _MonthlyWeatherState extends State<MonthlyWeather> {
  late List<WeatherData> weatherData;
  List<WeatherData> weatherList = [];
  ScrollController _controller = new ScrollController();
  late DateTime date;
  @override
  void initState() {
    date = DateTime.now();
    weatherData = widget.weatherData;
    weatherList = GeneralBusiness().monthlyDataList(weatherData, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
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
                        date = Jiffy(date).subtract(months: 1).dateTime;

                        setState(() {
                          weatherList = GeneralBusiness()
                              .dailyDataList(weatherData, date);
                        });
                      },
                      icon: Icon(Icons.chevron_left_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        date = Jiffy(date).add(months: 1).dateTime;
                        setState(() {
                          weatherList = GeneralBusiness()
                              .dailyDataList(weatherData, date);
                        });
                      },
                      icon: Icon(Icons.chevron_right_outlined),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  monthLocaleReplacement(DateFormat(
                    'MMMM yyyy',
                  ).format(date)),
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
                        showMonthPicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                          locale: Locale("hr"),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              date = value;
                            });
                          }
                        });
                      },
                      child: Text(
                        'Izaberi mjesec',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ],
          ),
          weatherList.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text('Nema podataka za prikaz'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: _controller,
                  itemCount: weatherList.isNotEmpty
                      ? Jiffy(weatherList.first.date).daysInMonth
                      : 0,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text((index + 1).toString()),
                        (() {
                          if (weatherList[index].date!.day == index + 1) {
                            return Text('object');
                          }
                          return Text('data');
                        }())
                      ],
                    );
                  },
                )
        ],
      ),
    );
  }

  String monthLocaleReplacement(String from) {
    var months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    var monthsCro = [
      "Siječanj",
      "Veljača",
      "Ožujak",
      "Travanj",
      "Svibanj",
      "Lipanj",
      "Srpanj",
      "Kolovoz",
      "Rujan",
      "Listopad",
      "Studeni",
      "Prosinac"
    ];
    var fromMonth = months.firstWhere((element) {
      return from.contains(element);
    });
    var fromIndex = months.indexOf(fromMonth);
    return from.replaceAll(fromMonth, monthsCro[fromIndex]);
  }
}
