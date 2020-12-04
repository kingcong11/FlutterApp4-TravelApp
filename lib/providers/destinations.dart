import 'package:flutter/material.dart';
import '../models/destination.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destination = [];

  List<Destination> get getDestinations {
    return [..._destination];
  }
}
