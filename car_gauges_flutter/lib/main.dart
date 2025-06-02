import 'dart:convert';
import 'package:car_gauges_flutter/obd_gauges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:window_manager/window_manager.dart'; // Window Manager Code

bool hasData = false;
Color mainColor = const Color.fromARGB(255, 5, 223, 175);
Color secondaryColor = const Color.fromARGB(255, 2, 49, 94); //const Color.fromARGB(255, 2, 60, 75);
Color background = const Color.fromARGB(255, 0, 0, 0);
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return const MaterialApp(
      home: Scaffold(
        body: Display()
      )
    );
  }
}

class Display extends StatefulWidget{
  const Display({super.key});

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double centerPoint = screenSize.height * 0.5;
    double baseWidth = screenSize.width * 0.3; // Size of gauges
    Offset speedLoc = Offset(centerPoint, screenSize.width * 0.7) - Offset(baseWidth/2, baseWidth/2); // Location of gauges
    Offset rpmLoc = Offset(centerPoint, screenSize.width * 0.3) - Offset(baseWidth/2, baseWidth/2);
    return Container(
      color: background,
      child: 
          Stack(
            children: [
              Positioned(
                left: 0,
                child: ElevatedButton(
                  onPressed: () {
                    getObdData().then((data){
                      setState(() {
                        if(!hasData){return;}
                        speed = data['speed'].toDouble();
                        rmp = data['rpm'].toDouble();
                        fuelLevel = data['fuel'].toDouble();
                        throttle = data['throttle'].toDouble();
                        coolTemp = data['coolant_temp'].toDouble();
                        oilTemp = data['oil_temp'].toDouble();
                        tripTime = Duration(seconds: data['run_time']);
                      });
                    });
                  },
                  child: Text('Pull New')
                )
              ),
              Positioned( // Speedometer
                top: speedLoc.dx,
                left: speedLoc.dy,
                child: Container(
                  width: baseWidth,
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [background, secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  child: FittedBox(fit: BoxFit.contain, child: Speedometer(speedKph: speed, title: 'MPH'))
                )
              ),
              Positioned( // Throttle Level
                top: speedLoc.dx,
                left: speedLoc.dy,
                child: SizedBox(
                  width: baseWidth,
                  child: FittedBox(fit: BoxFit.contain, child: RadialLevel(level: fuelLevel, startAng: 300, endAng: 60))
                )
              ),
              Positioned( // RMP
                top: rpmLoc.dx,
                left: rpmLoc.dy,
                child: Container(
                  width: baseWidth,
                  decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [background, secondaryColor], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  child: FittedBox(fit: BoxFit.contain, child: RmpGauge(rmp: rmp, title: 'RPM',))
                )
              ),
              Positioned( // Other
                top: rpmLoc.dx,
                left: rpmLoc.dy,
                child: SizedBox(
                  width: baseWidth,
                  child: FittedBox(fit: BoxFit.contain, child: RadialLevel(level: throttle, startAng: 120, endAng: 250))
                )
              ),
              Positioned(
                left: screenSize.width*0.82,
                top: (screenSize.height - baseWidth) * 0.5,
                child: SizedBox(
                  width: screenSize.width * 0.25,
                  height: baseWidth,
                  child: FittedBox(fit: BoxFit.contain, child: LevelGauge(level: fuelLevel)),
                )             
              ),
              Positioned(
                left: screenSize.width/2 - 50,
                top: screenSize.height/2 -40,
                child: Text(tripTime.toString().substring(0, tripTime.toString().indexOf('.')), style: TextStyle(color: mainColor, fontSize: 32))
              )
            ],
          ),
    );
  }
  
}


Future<dynamic> getObdData() async{
  try{
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));
    hasData = true;
    return json.decode(response.body);
  }catch(_){
    print('Unable to Fetch Data');
    hasData = false;
    return [];
  }

}
