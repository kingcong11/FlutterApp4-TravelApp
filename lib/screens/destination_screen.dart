import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/widgets/activities_item_card.dart';

class DestinationScreen extends StatefulWidget {
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  /* Getters */
  double _computeMainContentSize(MediaQueryData mediaQuery) {
    // return (mediaQuery.size.height - mediaQuery.padding.top);
    return (mediaQuery.size.height);
  }

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments;
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final mainContentSize = _computeMainContentSize(mediaQuery);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Destails', style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Colors.white),
      // ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Hero(
                  tag: index,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/destination$index.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey[900].withOpacity(0.9),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 32.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      size: 32.0,
                    ),
                    Icon(
                      Icons.sort,
                      size: 32.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 15.0,
                bottom: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Post Title',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 14.0,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Location',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15.0,
                bottom: 15.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              itemBuilder: (_, i) {
                return ActivitiesItemCard(index: i);
              },
            ),
          )
        ],
      ),
    );
  }
}
