import 'dart:io';

/* Packages */
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* Models */
import '../models/destination.dart';
import '../models/http_exception.dart';

/* helpers */
import '../helpers/database_helper.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destination = [];

  List<Destination> get getDestinations {
    return [..._destination];
  }

  Future<void> addDestination(Destination destination, File image) async {
    final newDestination = Destination(
      id: DateTime.now().toString(),
      title: destination.title,
      description: destination.description,
      city: destination.city,
      address: destination.city,
      location: destination.location,
      image: image,
    );

    _destination.insert(0, newDestination);

    notifyListeners();

    DBHelper.post('user_destinations', {
      'id': newDestination.id,
      'title': newDestination.title,
      'description': newDestination.description,
      'image': newDestination.image.path,
    });
  }

  Future<void> fetchAndSetDestinations() async {
    final destinationList = await DBHelper.get('user_destinations');

    _destination = destinationList.map((des) {
      return Destination(
        id: des['id'],
        title: des['title'],
        description: des['description'],
        city: '',
        address: '',
        location: null,
        image: File(des['image']),
      );
    }).toList();

    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> findPlacesRequest(String pattern) async {

    final url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$pattern&inputtype=textquery&key=API_KEY';

    // try {

      final response = await http.get(Uri.encodeFull(url));
      print(response.body);

      return [];

      /* unfortunately, I stopped here because google maps platform requires a billing account which I currently dont have so I cant continue this project,
      but to give this project a fair ending, I'll just end it with just the UI design */
      
    // } catch (e) {
    // }

  }
}
