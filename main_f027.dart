import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data_model.dart';

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
              child: Text(
                  "Flutter_Gmaps_Query_From_dB\n         (SMART TRACKING)")),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var latlng_center;
  var lat_center;
  var lng_center;

  int n = 1;

  Future? _future;
  List<Marker> markerAll = [];

  Future _loadString() async {
    // var url = Uri.parse(
    //     "http://192.168.100.100:8087/table/query_data.php?auth=kjgdkhdfldfguttedfgr");

    var url = Uri.parse(
        "https://mediumsitompul.com/googlemaps/query_data.php?auth=kjgdkhdfldfguttedfgr");

    var response = await http.get(Uri.parse(url.toString()));
    final dynamic responsebody = jsonDecode(response.body);
    print(responsebody);
    return responsebody;
  }

  @override
  void initState() {
    _future = _loadString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                //.......................................
                ListDataModel loc = ListDataModel.fromJson(snapshot.data);

                loc.data!.forEach((i) {
                  print("i.locId");
                  print(i.locId);

                  //=============================================
                  n++;
                  print(n);
                  if (n == 25) {
                    lat_center = double.parse(i.locX.toString());
                    lng_center = double.parse(i.locY.toString());
                  }
                  //=============================================

                  markerAll.add(Marker(
                    markerId: MarkerId(i.locId.toString()),
                    position: LatLng(double.parse(i.locX.toString()),
                        double.parse(i.locY.toString())),
                    infoWindow: InfoWindow(
                      title: i.locX.toString(),
                      snippet: i.locY.toString(),
                    ),
                    onTap: () {},
                  ));
                });

                //.......................................
              }
              //...................................................................
              Set<Circle> circles1 = Set.from([
                Circle(
                  circleId: CircleId("1"),
                  center: LatLng(lat_center, lng_center),
                  radius: 50,
                  strokeColor: Colors.blue,
                  fillColor: Colors.black12,
                ),
              ]);
              //.....................................................................
              return GoogleMap(
                //initialCameraPosition: _kLake,
                initialCameraPosition: CameraPosition(
                    target: LatLng(lat_center, lng_center), zoom: 15),
                markers: Set.from(markerAll),
                mapType: MapType.normal,
                circles: circles1,
              );
            },
          ),
          // FloatingActionButton(onPressed: () {
          //   MyApp();
          // })
        ],
      ),
    );
  }
}
