import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class Speedometer extends StatelessWidget{
  const Speedometer(
    {super.key, 
    required this.speedKph,
    this.title = '',
    this.mainColor = const Color.fromARGB(255, 159, 201, 7),
    this.secondaryColor = const Color.fromARGB(255, 30, 139, 3)
    }
  );

  final double speedKph;
  final String title;
  final Color mainColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    double start = 130;
    double end = 50;
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 200,
          labelOffset: 45,
          startAngle: start,
          endAngle: end,
          showAxisLine: false,
          showTicks: false,
          axisLabelStyle: GaugeTextStyle(color: mainColor),
        ),
        RadialAxis(
          minimum: 0,
          maximum: 125,
          startAngle: start,
          endAngle: end,
          labelOffset: 10,
          tickOffset: -5,
          axisLabelStyle: GaugeTextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          showAxisLine: false,
          interval: 10,
          minorTicksPerInterval: 5,
          majorTickStyle: MajorTickStyle(length: 10, thickness: 3, color: mainColor),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 2, color: mainColor),
          pointers: [
            NeedlePointer(value: speedKph/1.60934, knobStyle: KnobStyle(color: Colors.black, knobRadius: 0.06), needleEndWidth: 7, needleStartWidth: 0.1, needleColor: const Color.fromARGB(255, 255, 17, 0), enableAnimation: true)
            ],
          annotations: [
            GaugeAnnotation(
              widget: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.5,
            ),
            GaugeAnnotation(
              widget: Text('KPH', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 270,
              positionFactor: 0.4,
            ),
            GaugeAnnotation(
              widget: Text('${(speedKph).round()}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 270,
              positionFactor: 0.3,
            ),
            GaugeAnnotation(
              widget: Text('${(speedKph/1.60934).round()}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
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
    this.title = '',
    this.startAng = 130,
    this.endAng = 50,
    this.mainColor = const Color.fromARGB(255, 159, 201, 7),
    this.secondaryColor = const Color.fromARGB(255, 30, 139, 3)
    }
  );

  final double level;
  final String title;
  final double startAng;
  final double endAng;
  final Color mainColor;
  final Color secondaryColor;

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
          startAngle: startAng,
          endAngle: endAng,
          radiusFactor: 1.5,
          ticksPosition: ElementsPosition.outside,
          labelsPosition: ElementsPosition.outside,
          axisLineStyle: AxisLineStyle(thickness: 30, color: secondaryColor),
          tickOffset: 2,
          pointers: [
           RangePointer(value: level, width: 30, dashArray: [6,2], color: mainColor, enableAnimation: true)
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

class RmpGauge extends StatelessWidget{
  const RmpGauge(
    {super.key, 
    required this.value,
    this.title = '',
    this.mainColor = const Color.fromARGB(255, 159, 201, 7),
    this.secondaryColor = const Color.fromARGB(255, 30, 139, 3),
    this.minVal = 0,
    this.maxVal = 6.1,
    this.annotation = ''
    }
  );

  final double value;
  final String title;
  final Color mainColor;
  final Color secondaryColor;
  final double maxVal;
  final double minVal;
  final String annotation;

  @override
  Widget build(BuildContext context) {
    double start = 130;
    double end = 50;
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: minVal,
          maximum: maxVal,
          startAngle: start,
          endAngle: end,
          labelOffset: 10,
          tickOffset: -5,
          axisLabelStyle: GaugeTextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.bold),
          showAxisLine: false,
          interval: maxVal-minVal > 10 ? 10:1,
          minorTicksPerInterval: 5,
          majorTickStyle: MajorTickStyle(length: 10, thickness: 3, color: mainColor),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 2, color: mainColor),
          pointers: [
            NeedlePointer(value: value, knobStyle: KnobStyle(color: Colors.black, knobRadius: 0.06), needleEndWidth: 7, needleStartWidth: 0.1, needleColor: const Color.fromARGB(255, 255, 17, 0), enableAnimation: true)
            ],
          annotations: [
            GaugeAnnotation(
              widget: Text(title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.5,
            ),
            GaugeAnnotation(
              widget: Text(annotation, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: mainColor),),
              angle: 90,
              positionFactor: 0.7,
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
    required this.level,
    this.mainColor = const Color.fromARGB(255, 159, 201, 7),
    this.secondaryColor = const Color.fromARGB(255, 30, 139, 3)
    }
  );

  final double level;
  final Color mainColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      axisTrackStyle: LinearAxisTrackStyle(thickness: 20, color: secondaryColor),
      showLabels: false,
      majorTickStyle: LinearTickStyle(length: 7, thickness: 2, color: mainColor),
      minorTickStyle: LinearTickStyle(length: 3, thickness: 1, color: mainColor),
      orientation: LinearGaugeOrientation.vertical,
        markerPointers: [
          LinearWidgetPointer(value: 3, offset: 10, position: LinearElementPosition.outside, enableAnimation: false, child: Text('E', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mainColor))),
          LinearWidgetPointer(value: 98, offset: 10, position: LinearElementPosition.outside, enableAnimation: false, child: Text('F', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: mainColor))),
          LinearShapePointer(value: level, color: mainColor, shapeType: LinearShapePointerType.triangle, position: LinearElementPosition.inside, offset: 1)
        ],
        barPointers: [LinearBarPointer(value: level, thickness: 20, color: mainColor,)],
      );
  }
  
}