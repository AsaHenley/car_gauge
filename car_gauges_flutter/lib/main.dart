import 'dart:convert';
import 'package:car_gauges_flutter/obd_gauges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  double level = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 85, 85, 85),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              getObdData().then((data){
                setState(() {
                  speed = data['speed'].toDouble();
                  level = data['fuel'].toDouble();
                });
              });
            },
            child: Text('Pull New')
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Speedometer(speed: speed),
              FuelLevel(level: level)
            ],
          ),
          Spacer()
        ],
      )
    );
  }
  
}


Future<dynamic> getObdData() async{
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/'));

  if(response.statusCode == 200){
    return json.decode(response.body);
  }
  else{
    return [];
  }
}
