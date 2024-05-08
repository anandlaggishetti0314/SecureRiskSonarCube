import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size w = MediaQuery.of(context).size;
    double screenWidth = w.width;
    double screenHeight = w.height;
    double h = MediaQuery.of(context).size.height;

    final List<ChartData> chartData = [
      ChartData(2010, 0),
      ChartData(2011, 1),
      ChartData(2012, 3),
      ChartData(2013, 5),
      ChartData(2014, 7)
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Color.fromARGB(255, 233, 249, 251),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: SizedBox(
                              width: screenWidth * 0.315,
                              height: screenHeight * 0.18,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(top: 10.0),
                                                child: Text(
                                                  "1000",
                                                  style:
                                                  TextStyle(fontSize: 24),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 15.0),
                                                child: Text(
                                                  "Clients",
                                                  style:
                                                  TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "+2%  than last month",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: 50.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 15.0,
                                      percent: 0.4,
                                      center: const Text(
                                        "35%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.butt,
                                      backgroundColor:
                                      Color.fromARGB(255, 103, 102, 92),
                                      progressColor: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 20.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: SizedBox(
                              width: screenWidth * 0.315,
                              height: screenHeight * 0.18,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(top: 10.0),
                                                child: Text(
                                                  "1000",
                                                  style:
                                                  TextStyle(fontSize: 24),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 15.0),
                                                child: Text(
                                                  "Products",
                                                  style:
                                                  TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "+2%  than last month",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: 50.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 15.0,
                                      percent: 0.4,
                                      center: const Text(
                                        "35%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.butt,
                                      backgroundColor:
                                      Color.fromARGB(255, 103, 102, 92),
                                      progressColor: Colors.cyan,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.18,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                "1000",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(bottom: 15.0),
                                              child: Text(
                                                "RFQ",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "+2%  than last month",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 50.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: 0.4,
                                    center: const Text(
                                      "35%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor:
                                    Color.fromARGB(255, 103, 102, 92),
                                    progressColor: Colors.cyan,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: SizedBox(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.18,
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Text(
                                                    "1000",
                                                    style:
                                                    TextStyle(fontSize: 24),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15.0),
                                                  child: Text(
                                                    "Clients",
                                                    style:
                                                    TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "+2%  than last month",
                                                  style:
                                                  TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: 0.4,
                                        center: const Text(
                                          "35%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        circularStrokeCap:
                                        CircularStrokeCap.butt,
                                        backgroundColor:
                                        Color.fromARGB(255, 103, 102, 92),
                                        progressColor: Colors.cyan,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.39,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "RFQ",
                                    style: TextStyle(
                                        color: Colors.cyan, fontSize: 24),
                                  ),
                                ),
                                Expanded(
                                  child: Icon(
                                    Icons.arrow_right_outlined,
                                    color: Color.fromARGB(255, 31, 33, 31),
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Processing",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 120, 118, 109),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "1234",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Pending",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 120, 118, 109)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "1500",
                                            style: TextStyle(fontSize: 24),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Submitted",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 120, 118, 109)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "536",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Closed",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 120, 118, 109)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "327",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: SizedBox(
                        width: screenWidth * 0.64,
                        height: screenHeight * 0.45,
                        child: Container(
                          child: SfCartesianChart(
                            series: <ChartSeries>[
                              // Renders line chart
                              LineSeries<ChartData, int>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: SizedBox(
                                width: screenWidth * 0.31,
                                height: screenHeight * 0.18,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Clients",
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          Expanded(
                                            child: Icon(
                                              Icons.arrow_right_outlined,
                                              color: Color.fromARGB(
                                                  255, 31, 33, 31),
                                              size: 30.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Active",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 120, 118, 109),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "1234",
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Renewals",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 120, 118, 109),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "1500",
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: SizedBox(
                                  width: screenWidth * 0.31,
                                  height: screenHeight * 0.25,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Intermidiate",
                                                style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 24),
                                              ),
                                            ),
                                            Expanded(
                                              child: Icon(
                                                Icons.arrow_right_outlined,
                                                color: Color.fromARGB(
                                                    255, 31, 33, 31),
                                                size: 30.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Products",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              120,
                                                              118,
                                                              109),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "1234",
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "TPA List",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              120,
                                                              118,
                                                              109),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "1500",
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Insurer List",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              120,
                                                              118,
                                                              109),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "536",
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
