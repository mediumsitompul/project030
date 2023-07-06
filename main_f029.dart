import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child:
                  Text("Insert Data Current LatLng\n     into Database MySql")),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData? _locationData2;

  //....................................................
  Future<void> _getUserLocation() async {
    Location location = Location();
    final _locationData = await location.getLocation();
    print(_locationData);

    setState(() {
      _locationData2 = _locationData;
    });
  }

  //...................................................
  Future _insertData() async {
    final url = Uri.parse(
      //"http://192.168.100.100:8087/googlemaps/insert_data.php",
      //"https://mediumsitompul.com/googlemaps/insert_data.php",
      "https://mediumsitompul.com/googlemaps/insert_data_static.php",
    );
    var response = await http.post(url, body: {
      "lat": "${_locationData2?.latitude}",
      "lng": "${_locationData2?.longitude}",
    });
    var result1 = jsonDecode(response.body);
    print(result1);
  }

  //...................................................
  int _n = 1;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      _getUserLocation();
      _insertData();
      _n++;
      print(_n);
    });
    // TODO: implement initState
    super.initState();
  }
  //...................................................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: _getUserLocation,
              child: const Text("Send Data LatLng\nto Database MySql")),
          _locationData2 != null
              ? Wrap(
                  children: [
                    Text(
                      "Number: ${_n}",
                      style: const TextStyle(
                          fontSize: 50,
                          fontStyle: FontStyle.italic,
                          color: Colors.red),
                    ),
                    Text(
                      "Your Latitude: ${_locationData2?.latitude}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Your Longitude: ${_locationData2?.longitude}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
  //////
}
