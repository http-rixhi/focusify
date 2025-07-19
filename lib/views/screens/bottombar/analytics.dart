// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusify/views/widgets/indicator.dart';

import '../../widgets/Colors.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool showAvg = false;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkLevel1,
        title: const Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Center(child: Text('Studying Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
              ),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 11,
                        left: 12,
                        top: 8,
                        bottom: 12,
                      ),
                      child: LineChart(
                        showAvg ? avgData() : mainData(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 55,
                    height: 34,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 13,
                  bottom: 8
                ),
                child: Text('Overview', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black54),
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.clock),
                                  SizedBox(width: 5,),
                                  Text('Time Spend')
                                ],
                              ),
                            ),
                            Text('12:16:14', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(height: 11,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black54),
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.clock),
                                  SizedBox(width: 5,),
                                  Text('Avg. Activity')
                                ],
                              ),
                            ),
                            Text('24%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            SizedBox(height: 11,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              const Padding(
                padding: EdgeInsets.only(top: 28),
                child: Center(child: Text('Day Wise Activity Chart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
              ),


                AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: Colors.blue,
                    text: 'Monday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.cyan,
                    text: 'Tuesday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  Indicator(
                    color: Colors.yellow,
                    text: 'Wednesday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.purple,
                    text: 'Thursday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.green,
                    text: 'Friday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.red,
                    text: 'Saturday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.teal,
                    text: 'Sunday',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 11,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 4:
      text = const Text('Wed', style: style);
      break;
    case 6:
      text = const Text('Thr', style: style);
      break;
    case 8:
      text = const Text('Fri', style: style);
      break;
    case 10:
      text = const Text('Sat', style: style);
      break;
    case 12:
      text = const Text('Sun', style: style);
      break;

    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(meta: meta,child: text);
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 5:
      text = '5';
      break;
    case 10:
      text = '10';
      break;
    case 15:
      text = '15';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 5,
      verticalInterval: 2,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Colors.red,
          strokeWidth: 0.7,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Colors.red,
          strokeWidth: 0.7,
        );
      },
    ),
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 14,
    minY: 0,
    maxY: 20,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 0),
          FlSpot(2, 8),
          FlSpot(4, 5),
          FlSpot(6, 9),
          // FlSpot(8, 4),
          // FlSpot(9.5, 3),
          // FlSpot(11, 4),
          // FlSpot(13, 3.1),
          // FlSpot(14, 5),
        ],
        isCurved: true,
        // gradient: LinearGradient(
        //   colors: Colors.blueGrey,
        // ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          // gradient: LinearGradient(
          //   colors: Colors.blueGrey
          //       .map((color) => color.withOpacity(0.3))
          //       .toList(),
          // ),
        ),
      ),
    ],
  );
}

LineChartData avgData() {
  return LineChartData(
    lineTouchData: const LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      verticalInterval: 1,
      horizontalInterval: 1,
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: bottomTitleWidgets,
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
          interval: 1,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 51,
    minY: 0,
    maxY: 16,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3.44),
          FlSpot(2.6, 3.44),
          FlSpot(4.9, 3.44),
          FlSpot(6.8, 3.44),
          FlSpot(8, 3.44),
          FlSpot(9.5, 3.44),
          FlSpot(11, 3.44),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: Colors.blueGrey[0], end: Colors.blueGrey[1])
                .lerp(0.2)!,
            ColorTween(begin: Colors.blueGrey[0], end: Colors.blueGrey[1])
                .lerp(0.2)!,
          ],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: Colors.blueGrey, end: Colors.blueGrey)
                  .lerp(0.2)!
                  .withOpacity(0.1),
              ColorTween(begin: Colors.blueGrey, end: Colors.blueGrey)
                  .lerp(0.2)!
                  .withOpacity(0.1),
            ],
          ),
        ),
      ),
    ],
  );
}

// ==================== PIE CHART ====================================
List<PieChartSectionData> showingSections() {
  return List.generate(7, (i) {
    final isTouched = i == -1;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue,
          value: 20,
          title: '20%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.cyan,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.yellow,
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.purple,
          value: 10,
          title: '10%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
        case 4:
        return PieChartSectionData(
          color: Colors.green,
          value: 18,
          title: '18%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
        case 5:
        return PieChartSectionData(
          color: Colors.red,
          value: 12,
          title: '12%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
        case 6:
        return PieChartSectionData(
          color: Colors.teal,
          value: 10,
          title: '10%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}