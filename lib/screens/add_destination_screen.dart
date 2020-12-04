import 'package:flutter/material.dart';

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

  /* Methods */
  void _submitForm() {
    var _isValid = _formKey.currentState.validate();

    if (_isValid) {
      // save form

    } else {
      return;
    }
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
          GestureDetector(
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
            onTap: _submitForm,
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
                ImageInput(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
