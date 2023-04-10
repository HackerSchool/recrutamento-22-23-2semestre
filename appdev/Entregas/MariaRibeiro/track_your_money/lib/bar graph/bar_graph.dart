import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IndividualBar{
  final int x; // position on x axis
  final double y; // amount 

  IndividualBar({required this.x, required this.y});
}


class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 1, y: tueAmount),
      IndividualBar(x: 2, y: wedAmount),
      IndividualBar(x: 3, y: thurAmount),
      IndividualBar(x: 4, y: friAmount),
      IndividualBar(x: 5, y: satAmount),
      IndividualBar(x: 6, y: sunAmount),

    ];
  }
}

class Graph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const Graph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount
  });

  @override
  Widget build(BuildContext context){

    BarData graph = BarData(
      monAmount: monAmount, 
      tueAmount: tueAmount,
      wedAmount: wedAmount, 
      thurAmount: thurAmount, 
      friAmount: friAmount, 
      satAmount: satAmount, 
      sunAmount: sunAmount,
    );

    graph.initializeBarData();

    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
          )
        )
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: graph.barData.map(
        (data) => BarChartGroupData(
          x: data.x,
          barRods: [
            BarChartRodData(
              toY: data.y,
              color: Colors.black,
              width: 25,
              borderRadius: BorderRadius.circular(4),           
              backDrawRodData: BackgroundBarChartRodData(
                show: true, 
                toY: maxY,
                color: Colors.grey[200],
              )
            ),
          ],
        ),
      ).toList(),
    )
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color:Colors.black, 
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('M', style:style);
      break;
    case 1:
      text = const Text('T', style:style);
      break;
    case 2:
      text = const Text('W', style:style);
      break;
    case 3:
      text = const Text('T', style:style);
      break;
    case 4:
      text = const Text('F', style:style);
      break;
    case 5:
      text = const Text('S', style:style);
      break;
    case 6:
      text = const Text('S', style:style);
      break;
    default:
      text = const Text('', style:style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text);

}