import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:car_gauges_flutter/main.dart';



class Speedometer extends StatelessWidget{
  const Speedometer(
    {super.key, 
    required this.speed,
    this.title = ''});

  final double speed;
  final String title;

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
        ),
        RadialAxis(
          minimum: 0,
          maximum: 125,
          labelOffset: 10,
          tickOffset: -5,
          axisLabelStyle: GaugeTextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          showAxisLine: false,
          interval: 10,
          minorTicksPerInterval: 5,
          majorTickStyle: MajorTickStyle(length: 10, thickness: 3, color: mainColor),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 2, color: mainColor),
          pointers: [
            NeedlePointer(value: speed, knobStyle: KnobStyle(color: Colors.black, knobRadius: 0.06), needleEndWidth: 7, needleStartWidth: 0.1, needleColor: Colors.red, enableAnimation: true)
            ],
          annotations: [
            GaugeAnnotation(
              widget: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.5,
            ),
            GaugeAnnotation(
              widget: Text('$speed', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.7,
            ),
          ],
        )
      ],
    );
  }
}

class RadialLevel extends StatelessWidget{
  const RadialLevel(
    {super.key, 
    required this.level,
    this.title = ''});

  final double level;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 101,
          axisLabelStyle: GaugeTextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          minorTicksPerInterval: 5,
          majorTickStyle: MajorTickStyle(length: 10, thickness: 3, color: mainColor),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 2, color: mainColor),
          startAngle: 300,
          endAngle: 60,
          radiusFactor: 1.5,
          ticksPosition: ElementsPosition.outside,
          labelsPosition: ElementsPosition.outside,
          axisLineStyle: AxisLineStyle(thickness: 30, color: secondaryColor),
          tickOffset: 2,
          pointers: [
           RangePointer(value: level, width: 30, dashArray: [8,4], color: mainColor, enableAnimation: true)
            ],
          annotations: [
            GaugeAnnotation(
              widget: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        )
      ],
    );
  }
}

class LevelGauge extends StatelessWidget{
  const LevelGauge(
    {super.key, 
    required this.level});

  final double level;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      axisTrackStyle: LinearAxisTrackStyle(thickness: 19, color: secondaryColor),
      showLabels: false,
      majorTickStyle: LinearTickStyle(length: 7, thickness: 2, color: mainColor),
      minorTickStyle: LinearTickStyle(length: 3, thickness: 1, color: mainColor),
      orientation: LinearGaugeOrientation.vertical,
        markerPointers: [
          LinearWidgetPointer(value: 3, offset: 10, position: LinearElementPosition.outside, enableAnimation: false, child: Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mainColor))),
          LinearWidgetPointer(value: 98, offset: 10, position: LinearElementPosition.outside, enableAnimation: false, child: Text('F', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mainColor))),
          LinearShapePointer(value: level, color: mainColor),
        ],
        barPointers: [LinearBarPointer(value: level, thickness: 20, color: mainColor,)],
      );
  }
  
}