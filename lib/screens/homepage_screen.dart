import 'package:flutter/material.dart';

/* Packages */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/* Widgets */
import '../widgets/selection_carousel.dart';

class HomePageScreen extends StatefulWidget {
  /* Properties */
  static const routeName = '/homepage';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  /* Properties */
  var _selectedIconIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.map,
    FontAwesomeIcons.walking,
  ];

  /* Builders */
  Widget _iconBuilder(int index) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: (_selectedIconIndex == index)
              ? Theme.of(context).accentColor
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          _icons[index],
          size: 25,
          color: (_selectedIconIndex == index)
              ? Theme.of(context).primaryColor
              : Color(0xFFB4C1C4),
        ),
      ),
      onTap: () {
        setState(() {
          _selectedIconIndex = index;
        });
      },
    );
  }

  /* Getters */
  double _computeMainContentSize(MediaQueryData mediaQuery) {
    return (mediaQuery.size.height - mediaQuery.padding.top);
  }

  @override
  Widget build(BuildContext context) {
    /* Properties */
    final _mediaQuery = MediaQuery.of(context);
    final _deviceSize = _mediaQuery.size;
    final mainContentSize = _computeMainContentSize(_mediaQuery);

    return SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'What would you like to find?',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _icons
                    .asMap()
                    .entries
                    .map((e) => _iconBuilder(e.key))
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: mainContentSize * .45,
              child: SelectionCarousel(),
            )
          ],
        ),
      );
  }
}
