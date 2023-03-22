import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';

class SingleContry extends StatelessWidget {
  String name, image;

  int totalCases,
      totalDathes,
      totalRecovered,
      avtive,
      critical,
      todayRecovered,
      test;

  SingleContry({
    required this.name,
    required this.image,
    required this.todayRecovered,
    required this.critical,
    required this.avtive,
    required this.test,
    required this.totalCases,
    required this.totalDathes,
    required this.totalRecovered,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReuseROw(
                          value: totalCases.toString(),
                          title: "Total"),
                      ReuseROw(
                          value: totalDathes.toString(),
                          title: "Deaths"),
                      ReuseROw(
                          value:
                          todayRecovered.toString(),
                          title: "Recovered"),
                      ReuseROw(
                          value: avtive.toString(),
                          title: "Active"),
                      ReuseROw(
                          value: critical.toString(),
                          title: "Critical"),
                      ReuseROw(
                          value:
                          totalDathes.toString(),
                          title: "Today Deaths"),
                      ReuseROw(
                          value: todayRecovered.toString(),
                          title: "Today Recovered"),
                    ],
                  ),

                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image),
              )
            ],
          )

        ],
      ),
    );
  }
}
