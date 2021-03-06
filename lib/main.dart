import 'package:flutter/material.dart';
import 'package:talk/widgets/widget_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.red[900],
        primaryColor: Colors.grey[850],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.red[900],
          ),
          headline6: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.normal,
            color: Colors.red[900],
          ),
          bodyText2: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Colors.grey,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const Dashboard(),
      routes: {
        Dashboard.id: (context) => const Dashboard(),
      },
    );
  }
}
