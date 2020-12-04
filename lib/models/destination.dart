import 'dart:io';
import 'package:flutter/material.dart';

class Coordinates{
  final double latitude;
  final double longitude;

  Coordinates({
    @required this.latitude,
    @required this.longitude
  });
}

class Destination {
  final String id;
  final String title;
  final String city;
  final String address;
  final Coordinates location;
  final File imageUrl;

  Destination({
    @required this.id,
    @required this.title,
    @required this.city,
    @required this.address,
    @required this.location,
    @required this.imageUrl,
  });
}
