/* Packages */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Providers */
import '../providers/destinations.dart';

class MyDestinationsScreen extends StatefulWidget {
  /* Properties */
  static const routeName = '/my-destination';

  final ScrollController controller;
  MyDestinationsScreen({
    this.controller,
  });

  @override
  _MyDestinationsScreenState createState() => _MyDestinationsScreenState();
}

class _MyDestinationsScreenState extends State<MyDestinationsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Destinations>(context, listen: false).fetchAndSetDestinations(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataSnapshot.hasError) {
          return Center(
            child: Text('Something went wrong.'),
          );
        } else {
          return Consumer<Destinations>(
            builder: (ctx, destinations, ch) {
              var fetchedDestinations = destinations.getDestinations;

              if (fetchedDestinations.length > 0) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  itemCount: fetchedDestinations.length,
                  controller: widget.controller,
                  itemBuilder: (ctx, index) {
                    return Container(
                      height: 200,
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return ch;
              }
            },
            child: Center(
              child: Text('You dont have any trips yet. start adding one.'),
            ),
          );
        }
      },
    );
  }
}
