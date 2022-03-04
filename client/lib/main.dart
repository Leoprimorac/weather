import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'package:weather_app/weatherData.dart';

const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = false;
void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final keyApplicationId = 'dw0s36y7mlb5mFqQ1Ifou3ykkuFpD9M2F2Cf6M3D';
    final keyClientKey = 'ngGsECaD3hC142Bs6BTw6NlQUuxfeaPDjY0vUgyM';
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }

  @override
  Widget build(BuildContext context) {
    main();
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Weather App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DailyWeather(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            label: 'Dnevni',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Mjesečni',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Godišnji',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class DailyWeather extends StatefulWidget {
  const DailyWeather({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  List<WeatherData> weatherData = [];
  List<WeatherData> weatherList = [];
  ScrollController _controller = ScrollController();
  late DateTime date;
  var error = false;
  Future<void>? _initializeFlutterFireFuture;

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  @override
  void initState() {
    date = DateTime.now();
    _initializeFlutterFireFuture = _initializeFlutterFire();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date)
      setState(() {
        weatherList = [];
        date = picked;
        getData();
      });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData.isEmpty) {
      getData().then((value) {
        setState(() {
          weatherData = value.where((element) {
            return element.date!.year == date.year &&
                element.date!.month == date.month &&
                element.date!.day == date.day;
          }).toList();
        });
      });
    }

    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            weatherList = [];
            weatherList = [];
          });
          List<WeatherData> response = await getData();
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
                          getData();
                        },
                        icon: Icon(Icons.chevron_left_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          date = date.add(
                            Duration(days: 1),
                          );
                          getData();
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
                          _selectDate(context);
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
      weatherData = data;
      dataList();
      return weatherData;
    } else {
      return [];
    }
  }

  List<WeatherData> dataList() {
    try {
      weatherList = weatherData.isEmpty
          ? []
          : weatherData.where((element) {
              return element.date!.year == date.year &&
                  element.date!.month == date.month &&
                  element.date!.day == date.day;
            }).toList();
    } on Exception catch (e) {
      throw (e);
    }
    setState(() {});
    return weatherList;
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
