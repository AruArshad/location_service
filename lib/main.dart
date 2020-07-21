import 'package:flutter/material.dart';
import 'package:location_service/datamodels/user_location.dart';
import 'package:location_service/services/location_service.dart';
import 'package:location_service/views/async_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Service',
        home: ResultsPage(),
      ),
    );
  }
}
