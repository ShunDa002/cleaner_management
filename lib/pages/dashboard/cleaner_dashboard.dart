import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

import '../../providers/dashboard_provider.dart';

final DashboardProvider dashboardProvider = Get.find<DashboardProvider>();

class CleanerDashboardPage extends StatelessWidget {
  CleanerDashboardPage({super.key});

  /*  Future<double> loadAverageActivities() async {
    // Ensure booking data is loaded
    double averageActivities =
        await dashboardProvider.calculateAverageActivitiesPerDay();
    return averageActivities;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cleaner Dashboard",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: AspectRatio(
                  aspectRatio: 1.75,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Last 7 Days Earnings',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 250,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 35),
                              child: _LineChart(),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FutureBuilder(
                            future: dashboardProvider
                                .calculateAverageActivitiesPerDay(),
                            builder: (context, snapshot) {
                              return Column(children: [
                                Text("Average Cleaning",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Divider(),
                                Text('${snapshot.data.toString()} orders'),
                              ]);
                            })),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FutureBuilder(
                            future:
                                dashboardProvider.calculateAverageTimeTaken(),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  Text("Average Working Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Divider(),
                                  Text(snapshot.data ?? 'Not found'),
                                ],
                              );
                            })),
                  ],
                )),
            Expanded(
              flex: 1,
              child: SizedBox(),
            )
          ],
        ));
  }
}

class _LineChart extends StatelessWidget {
  _LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data when the widget is built
    dashboardProvider.getLastSevenDaysPayment();

    return Obx(() {
      return LineChart(
        LineChartData(
            lineBarsData: [
              LineChartBarData(
                  show: true,
                  spots: dashboardProvider.lastSevenDaysPayments,
                  // color: Colors.red,
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.purpleAccent,
                    Colors.lightBlueAccent,
                  ]),
                  isCurved: true,
                  preventCurveOverShooting: true,
                  belowBarData: BarAreaData(
                      show: true, color: Colors.blue.withValues(alpha: 200))),
            ],
            titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                    axisNameWidget: const Text("RM"),
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                bottomTitles: AxisTitles(
                    axisNameWidget: Text(DateFormat.MMMM()
                        .format(dashboardProvider.currentDate.value)),
                    sideTitles: SideTitles(
                        showTitles: true,
                        // getTitlesWidget: bottomTitleWidgets,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(meta.formattedValue));
                        },
                        reservedSize: 40)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false))),
            borderData: FlBorderData(
                show: true,
                border: Border(
                    left: BorderSide(color: Colors.black, width: 2),
                    bottom: BorderSide(color: Colors.black, width: 2))),
            minY: null),
      );
    });
  }
}

/* class CleanerDashboardPage extends StatefulWidget {
  const CleanerDashboardPage({super.key});

  @override
  State<CleanerDashboardPage> createState() => _CleanerDashboardPageState();
}

class _CleanerDashboardPageState extends State<CleanerDashboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cleaner Dashboard"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: AspectRatio(
                  aspectRatio: 1.75,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Weekly Earnings',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: _LineChart(),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          children: [
                            Text("Average Order",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Divider(),
                            Text("xxx orders"),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          children: [
                            Text("Average Cleaning Time",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Divider(),
                            Text("xxx hours"),
                          ],
                        )),
                  ],
                )),
            SizedBox(height: 20),
          ],
        ));
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          lineBarsData: [
            LineChartBarData(
                show: true,
                spots: const [
                  FlSpot(10, 3),
                  FlSpot(11, 4),
                  FlSpot(12, 3),
                  FlSpot(3, 5),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 7),
                ],
                // color: Colors.red,
                gradient: LinearGradient(colors: [
                  Colors.red,
                  Colors.purpleAccent,
                  Colors.lightBlueAccent,
                ]),
                isCurved: true,
                preventCurveOverShooting: true,
                belowBarData: BarAreaData(
                    show: true, color: Colors.blue.withValues(alpha: 200))),
          ],
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                  axisNameWidget: const Text("Orders"),
                  sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
              bottomTitles: AxisTitles(
                  axisNameWidget: const Text("Month"),
                  sideTitles: SideTitles(
                      showTitles: true,
                      // getTitlesWidget: bottomTitleWidgets,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        /* const style = TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        );
                        Widget text;
                        switch (value) {
                          case 0:
                            text = const Text('J', style: style);
                            break;
                          case 1:
                            text = const Text('F', style: style);
                            break;
                          case 2:
                            text = const Text('M', style: style);
                            break;
                          case 3:
                            text = const Text('A', style: style);
                            break;
                          case 4:
                            text = const Text('M', style: style);
                            break;
                          case 5:
                            text = const Text('J', style: style);
                            break;
                          case 6:
                            text = const Text('J', style: style);
                            break;
                          default:
                            text = const Text('');
                            break;
                        } */
                        return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(meta.formattedValue));
                      },
                      reservedSize: 40)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
          borderData: FlBorderData(
              show: true,
              border: Border(
                  left: BorderSide(color: Colors.black, width: 2),
                  bottom: BorderSide(color: Colors.black, width: 2))),
          minY: null),
    );
  }
} */
