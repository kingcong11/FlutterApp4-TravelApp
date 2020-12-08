import 'package:flutter/services.dart';

/* Packages */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Providers */
import './providers/destinations.dart';

/* Screens */
import './screens/navigation_screen.dart';
import './screens/my_destinations_screen.dart';
import './screens/homepage_screen.dart';
import './screens/add_destination_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Destinations()),
      ],
      child: MaterialApp(
        title: 'Travel App',
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: NavigationSceen(),
        routes: {
          HomePageScreen.routeName: (ctx) => HomePageScreen(),
          MyDestinationsScreen.routeName: (ctx) => MyDestinationsScreen(),
          AddDestinationScreen.routeName: (ctx) => AddDestinationScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
