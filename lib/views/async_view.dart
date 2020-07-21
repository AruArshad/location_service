import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:location_service/datamodels/user_location.dart';
import 'package:provider/provider.dart';

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
              body: Center(
                  child: Text(
            'Lat: ${snapshot.data[0]} Long: ${snapshot.data[1]}',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          )));
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
