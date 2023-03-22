import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper.dart';
import 'package:untitled1/splash.dart';
import 'package:untitled1/track.dart';
import 'package:untitled1/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Covid app',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final colorList = <Color>[];
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: stateServices.getStates(),
                  builder: (context, AsyncSnapshot<UserModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString())
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            //chartRadius: MediaQuery.of(context).size.width.3.2,

                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            colorList: const [
                              Color(0xff4285F4),
                              Color(0xff1aa260),
                              Color(0xffde5246),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseROw(
                                      value: snapshot.data!.cases.toString(),
                                      title: "Total"),
                                  ReuseROw(
                                      value: snapshot.data!.deaths.toString(),
                                      title: "Deaths"),
                                  ReuseROw(
                                      value:
                                          snapshot.data!.recovered.toString(),
                                      title: "Recovered"),
                                  ReuseROw(
                                      value: snapshot.data!.active.toString(),
                                      title: "Active"),
                                  ReuseROw(
                                      value: snapshot.data!.critical.toString(),
                                      title: "Critical"),
                                  ReuseROw(
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                      title: "Today Deaths"),
                                  ReuseROw(
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                      title: "Today Recovered"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print('ok');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Track()));
                                  },
                                  child: Text("Track")),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseROw extends StatelessWidget {
  String title, value;

  ReuseROw({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
