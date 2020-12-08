import 'dart:io';

/* Packages */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/* Models */
import '../models/destination.dart';

/* Providers */
import '../providers/destinations.dart';

/* Widgets */
import '../widgets/image_input.dart';

class AddDestinationScreen extends StatefulWidget {
  /* Properties */
  static const routeName = '/add-destination';
  @override
  _AddDestinationScreenState createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  /* Properties */
  var _formKey = GlobalKey<FormState>();
  File _selectedImage;
  var _destinationValues = Destination(
    id: null,
    title: '',
    description: '',
    city: '',
    address: '',
    location: null,
    image: null,
  );

  /* Methods */
  Future<void> _submitForm() async {
    var _isValid = _formKey.currentState.validate();

    if (_isValid && _selectedImage != null) {
      // save form
      _formKey.currentState.save();
      try {
        await Provider.of<Destinations>(context, listen: false)
            .addDestination(_destinationValues, _selectedImage);
      } catch (e) {
        // handle error here
      }
    } else {
      return;
    }
  }

  void _selectImage(File selectedImage) {
    _selectedImage = selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Destination',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Builder(
            builder: (ctx) => GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onTap: () async {
                await _submitForm();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageInput(passFiletoForm: _selectImage),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Say something about this post.',
                            hintStyle: TextStyle(fontSize: 14),
                            contentPadding: const EdgeInsets.all(5.0),
                          ),
                          style: TextStyle(fontSize: 14),
                          keyboardType: TextInputType.text,
                          maxLines: 6,
                          maxLength: 150,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter some text.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _destinationValues = Destination(
                              id: _destinationValues.id,
                              title: _destinationValues.title,
                              description: value,
                              city: _destinationValues.city,
                              address: _destinationValues.address,
                              location: _destinationValues.location,
                              image: _selectedImage,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _destinationValues = Destination(
                      id: _destinationValues.id,
                      title: value,
                      description: _destinationValues.description,
                      city: _destinationValues.city,
                      address: _destinationValues.address,
                      location: _destinationValues.location,
                      image: _selectedImage,
                    );
                  },
                ),
                
                
                
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                      decoration: InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    return await Provider.of<Destinations>(context, listen: false).findPlacesRequest(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(suggestion['name']),
                      subtitle: Text('\$${suggestion['price']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
