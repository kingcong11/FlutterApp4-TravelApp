/* Packages */
import 'package:flutter/material.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:animations/animations.dart';

/* Screens */
import './homepage_screen.dart';
import './my_destinations_screen.dart';
import './add_destination_screen.dart';

class NavigationSceen extends StatefulWidget {
  @override
  _NavigationSceenState createState() => _NavigationSceenState();
}

class _NavigationSceenState extends State<NavigationSceen> {
  /* Properties */
  var _isAdding = false;

  /* Builder */
  Widget _fabBuilder() {
    return OpenContainer(
      closedColor: Theme.of(context).primaryColor,
      openColor: Colors.white,
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      closedElevation: 4,
      transitionDuration: Duration(milliseconds: 500),
      closedBuilder: (ctx, action) {
        return Builder(
          builder: (ctx) => FloatingActionButton(
            elevation: 0,
            backgroundColor: (_isAdding)
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Theme.of(context).primaryColor,
            foregroundColor:
                (_isAdding) ? Theme.of(context).primaryColor : Colors.white,
            child: const Icon(
              MdiIcons.mapMarkerCheck,
              size: 30.0,
            ),
            onPressed: () {
              // setState(() {
              //   _isAdding = true;
              // });
              // action();
            },
          ),
        );
      },
      onClosed: (_) {
        setState(() {
          _isAdding = false;
        });
      },
      openBuilder: (ctx, action) => AddDestinationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      body: ScrollNavigation(
        activeColor: Theme.of(context).primaryColor,
        verticalPadding: 15,
        navItemIconSize: 30,
        pages: [
          HomePageScreen(),
          Screen(
            height: 56.0,
            elevation: 0.0,
            centerTitle: false,
            title: Text(
              'My Trips',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color(0xFFF3F5F7),
            controllerToHideAppBar: controller,
            body: MyDestinationsScreen(controller: controller),
          ),
        ],
        navItems: [
          ScrollNavigationItem(icon: Icon(MdiIcons.homeVariantOutline)),
          ScrollNavigationItem(icon: Icon(MdiIcons.mapMarkerRadiusOutline)),
        ],
        pagesActionButtons: [
          _fabBuilder(),
          _fabBuilder(),
        ],
      ),
    );
  }
}
