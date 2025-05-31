import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Color mainColor = const Color.fromARGB(255, 12, 198, 255);

class Speedometer extends StatelessWidget{
  const Speedometer(
    {super.key, 
    required this.speed});

  final double speed;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 200,
          labelOffset: 45,
          showAxisLine: false,
          showTicks: false,
          axisLabelStyle: GaugeTextStyle(color: mainColor),
          ranges: [
            GaugeRange(
              startValue: 0, 
              endValue: 100,
              startWidth: 15,
              endWidth: 10,
              rangeOffset: -20,
              color: Colors.black
            ),
            GaugeRange(
              startValue: 100, 
              endValue: 200,
              startWidth: 10,
              endWidth: 15,
              rangeOffset: -20,
              color: Colors.black
            )
          ],
        ),
        RadialAxis(
          minimum: 0,
          maximum: 125,
          labelOffset: 10,
          axisLabelStyle: GaugeTextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          showAxisLine: false,
          interval: 10,
          minorTicksPerInterval: 5,
          majorTickStyle: MajorTickStyle(length: 10, thickness: 3, color: mainColor),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 2, color: mainColor),
          pointers: [
            NeedlePointer(value: speed, knobStyle: KnobStyle(color: Colors.black), needleColor: Colors.red, enableAnimation: true)
            ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                  '$speed',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),
                ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        )
      ],
    );
  }
}

class FuelLevel extends StatelessWidget{
  const FuelLevel(
    {super.key, 
    required this.level});

  final double level;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      axisTrackStyle: LinearAxisTrackStyle(thickness: 20, color: mainColor),
      showLabels: false,
      orientation: LinearGaugeOrientation.vertical,
        markerPointers: [
          LinearWidgetPointer(value: 0, position: LinearElementPosition.outside, enableAnimation: false, child: Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          LinearWidgetPointer(value: 100, position: LinearElementPosition.outside, enableAnimation: false, child: Text('F', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          LinearShapePointer(value: level),
        ],
        barPointers: [LinearBarPointer(value: level, thickness: 20)],
      );
  }
  
}