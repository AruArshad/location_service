import 'package:flutter/material.dart';
import 'package:location_service/datamodels/user_location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Future<String> getLatitude() async {
    String lat = await Provider.of<UserLocation>(context).latitude.toString();
    return lat;
  }

  Future<String> getLongitude() async {
    String long = await Provider.of<UserLocation>(context).longitude.toString();
    return long;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([getLatitude(), getLongitude()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        Widget widget;
        if (snapshot.hasData) {
          widget = Scaffold(
              body: FlutterMap(
            options: new MapOptions(
              center: new LatLng(7.2906, 80.6337),
              zoom: 7.5,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 40.0,
                    height: 40.0,
                    point: new LatLng(double.parse(snapshot.data[0]),
                        double.parse(snapshot.data[1])),
                    builder: (ctx) => new Container(
                      child: Image.asset("assets/images/marker.png"),
                    ),
                  ),
                ],
              ),
            ],
          ));
        } else {
          widget = Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget;
      },
    );
  }
}
