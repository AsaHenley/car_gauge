import 'dart:async';
import 'dart:convert';
import 'package:car_gauges_flutter/obd_gauges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:window_manager/window_manager.dart'; // Window Manager Code

bool hasData = false;
void main() async{
/* // Window Manager Code
  WidgetsFlutterBinding.ensureInitialized(); // Window Manager Code
  await windowManager.ensureInitialized(); // Window Manager Code

  WindowOptions windowOptions = WindowOptions( // Window Manager Code
    fullScreen: true, // Window Manager Code
    backgroundColor: Colors.transparent, // Window Manager Code
    skipTaskbar: false, // Window Manager Code
  ); // Window Manager Code

  windowManager.waitUntilReadyToShow(windowOptions, () async { // Window Manager Code
    await windowManager.show(); // Window Manager Code
    await windowManager.focus(); // Window Manager Code
  }); // Window Manager Code
*/ // Window Manager Code
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: Scaffold(
        body: Display()
      )
    );
  }
}

class Display extends StatefulWidget{
  const Display({super.key});

  final List<GaugeTheme> themes = const [
    GaugeTheme(Color.fromARGB(255, 1, 243, 130), Color.fromARGB(255, 2, 116, 40), Color.fromARGB(255, 0, 0, 0)),
    GaugeTheme(Color.fromARGB(255, 255, 1, 242), Color.fromARGB(255, 1, 76, 105), Color.fromARGB(255, 0, 0, 0)),
    GaugeTheme(Color.fromARGB(255, 1, 255, 200), Color.fromARGB(255, 67, 1, 105), Color.fromARGB(255, 0, 0, 0)),
    GaugeTheme(Color.fromARGB(255, 248, 60, 3), Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0), badStatus: Color.fromARGB(255, 255, 1, 242)),
    GaugeTheme(Color.fromARGB(255, 241, 238, 4), Color.fromARGB(255, 209, 112, 1), Color.fromARGB(255, 0, 0, 0)),
  ];

  @override
  State<Display> createState() => DisplayState();

}

class DisplayState extends State<Display>{

  double speed = 0;
  double rmp = 0;
  double fuelLevel = 0;
  double throttle = 0;
  double coolTemp = 0;
  double oilTemp = 0;
  Duration tripTime = Duration(seconds: 0);
  late GaugeTheme curTheme;
  int themeIndex = 0;
  late Timer timer;
  bool badStat = false;

  @override
  void initState(){
    super.initState();
    curTheme = widget.themes[themeIndex];
    // ---- TIMER SETTING ----
    timer = Timer.periodic(Duration(milliseconds: 5000), setNewData);
  }

  void setNewData(Timer t){
    getObdData().then((data){
      setState(() {
        if(!hasData){return;}
        try {
          speed = data['speed'].toDouble();
          rmp = data['rpm'].toDouble();
          fuelLevel = data['fuel'].toDouble();
          throttle = data['throttle'].toDouble();
          coolTemp = data['coolant_temp'].toDouble();
          oilTemp = data['oil_temp'].toDouble();
          tripTime = Duration(seconds: data['run_time']);
          badStat = !badStat;
        }
        catch(_){} // if data came back bad just don't update
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double centerPoint = screenSize.height * 0.5;
    double baseWidth = screenSize.width * 0.3; // Size of gauges
    Offset speedLoc = Offset(screenSize.width * 0.7, centerPoint) - Offset(baseWidth/2, baseWidth/2); // Location of gauges
    Offset rpmLoc = Offset(screenSize.width * 0.3, centerPoint) - Offset(baseWidth/2, baseWidth/2);
    Offset oilLoc = Offset(screenSize.width * 0.45, centerPoint * 0.9) - Offset(baseWidth*.3/2, baseWidth/2);
    Offset coolLoc = Offset(screenSize.width * 0.55, centerPoint * 0.9) - Offset(baseWidth*.3/2, baseWidth/2);
    Offset timeLoc = Offset(screenSize.width/2 - 50, screenSize.height/2 - 40);
    return GestureDetector(
      onTap: () {
        setState(() {
          if(themeIndex < widget.themes.length-1){
            themeIndex++;
          }else{
            themeIndex = 0;
          }
          try{curTheme = widget.themes[themeIndex];}
          catch(_){themeIndex = 0; curTheme = widget.themes[themeIndex];}
        });
      },
      child: Container(
        color: curTheme.background,
        child: Stack(
          children: [
            // ---- SPEEDOMETER ----
            Positioned(top: speedLoc.dy, left: speedLoc.dx,
              child: Container(
                width: baseWidth,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [curTheme.background, curTheme.secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: FittedBox(fit: BoxFit.contain, child: Speedometer(speedKph: speed, title: 'MPH', mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
            // ---- THROTTLE ----
            Positioned(top: speedLoc.dy, left: speedLoc.dx,
              child: SizedBox(
                width: baseWidth,
                child: FittedBox(fit: BoxFit.contain, child: RadialLevel(level: fuelLevel, startAng: 300, endAng: 60, mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
            // ---- RMP ----
            Positioned(top: rpmLoc.dy, left: rpmLoc.dx,
              child: Container(
                width: baseWidth,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [curTheme.background, curTheme.secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: FittedBox(fit: BoxFit.contain, child: RmpGauge(value: rmp/1000, title: 'RPM', annotation: '${rmp.round()}', mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
             // ---- FFFFFFF ----
            Positioned(top: rpmLoc.dy, left: rpmLoc.dx,
              child: SizedBox(
                width: baseWidth,
                child: FittedBox(fit: BoxFit.contain, child: RadialLevel(level: throttle, startAng: 120, endAng: 250, mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
            // ---- OIL TEMP ----
            Positioned(top: oilLoc.dy, left: oilLoc.dx,
              child: Container(
                width: baseWidth * 0.3,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [curTheme.background, curTheme.secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: FittedBox(fit: BoxFit.contain, child: RmpGauge(value: oilTemp, minVal: 70, maxVal: 111, title: 'Oil', annotation: '${oilTemp.round()} C', mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
            // ---- COOLANT TEMP ----
            Positioned(top: coolLoc.dy, left: coolLoc.dx,
              child:  Container(
                width: baseWidth * 0.3,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [curTheme.background, curTheme.secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: FittedBox(fit: BoxFit.contain, child: RmpGauge(value: coolTemp, minVal: 70, maxVal: 111, title: 'Coolant', annotation: '${coolTemp.round()} C',  mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor))
              )
            ),
            // ---- FUEL LEVEL ----
            Positioned(top: (screenSize.height - baseWidth) * 0.5, left: screenSize.width * 0.82,
              child: SizedBox(
                width: screenSize.width * 0.25,
                height: baseWidth,
                child: FittedBox(fit: BoxFit.contain, child: LevelGauge(level: fuelLevel, mainColor: curTheme.mainColor, secondaryColor: curTheme.secondaryColor)),
              )             
            ),
             // ---- CLOCK ----
            Positioned(top: timeLoc.dy, left: timeLoc.dx,
              child: Text(tripTime.toString().substring(0, tripTime.toString().indexOf('.')), style: TextStyle(color: curTheme.mainColor, fontSize: 32))
            ),
            Positioned(top: timeLoc.dy - 40, left: timeLoc.dx - 10,
              child: Icon(Icons.water_drop, color: oilTemp > 100 ? curTheme.badStatus : curTheme.mainColor)
            ),
            Positioned(top: timeLoc.dy - 40, left: timeLoc.dx + 85,
              child: Icon(Icons.abc, color: badStat ? curTheme.badStatus : curTheme.mainColor)
            )
          ],
        ),
      )
    );
  }
  
}

Future<dynamic> getObdData() async{
  try{
    // Attmept to get data from the fast api on the local host port 8000 
    final response = await http.get(Uri.parse('http://localhost:8000/')); // http://127.0.0.1:8000
    hasData = true;
    return json.decode(response.body);
  }catch(_){
    debugPrint('Unable to Fetch Data');
    hasData = false;
    return [];
  }

}

class GaugeTheme{
  const GaugeTheme(this.mainColor, this.secondaryColor, this.background, {this.badStatus = Colors.red});

  final Color mainColor;
  final Color secondaryColor;
  final Color background;
  final Color badStatus;
}
