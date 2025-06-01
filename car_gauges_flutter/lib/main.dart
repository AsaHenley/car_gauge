import 'dart:convert';
import 'package:car_gauges_flutter/obd_gauges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

bool hasData = false;
Color mainColor = const Color.fromARGB(255, 128, 219, 9);
Color secondaryColor = const Color.fromARGB(255, 4, 75, 116); //const Color.fromARGB(255, 2, 60, 75);
void main() {
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

  @override
  State<Display> createState() => DisplayState();

}

class DisplayState extends State<Display>{

  double speed = 0;
  double fuelLevel = 0;
  double throttle = 0;
  Duration tripTime = Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: 
          Stack(
            children: [
              Positioned(
                left: screenSize.width/2,
                child: ElevatedButton(
                  onPressed: () {
                    getObdData().then((data){
                      setState(() {
                        if(!hasData){return;}
                        speed = data['speed'].toDouble();
                        fuelLevel = data['fuel'].toDouble();
                        throttle = data['throttle'].toDouble();
                        tripTime = Duration(seconds: data['run_time']);
                      });
                    });
                  },
                  child: Text('Pull New')
                )
              ),
              Positioned(
                top: screenSize.height * 0.2,
                left: screenSize.width * 0.2,
                child: Container(
                  width: screenSize.width * 0.3,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: secondaryColor),
                  child: FittedBox(fit: BoxFit.contain, child: Speedometer(speed: speed, title: 'MPH'))
                )
              ),
              Positioned(
                top: screenSize.height * 0.2,
                left: screenSize.width * 0.2,
                child: SizedBox(
                  width: screenSize.width * 0.3,
                  child: FittedBox(fit: BoxFit.contain, child: RadialLevel(level: throttle))
                )
              ),
              Positioned(
                left: screenSize.width*0.6,
                top: screenSize.height*0.15,
                child: SizedBox(
                  width: screenSize.width * 0.25,
                  height: screenSize.height * .5,
                  child: FittedBox(fit: BoxFit.contain, child: LevelGauge(level: fuelLevel)),
                )             
              ),
              Positioned(
                left: 20,
                top: 20,
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
