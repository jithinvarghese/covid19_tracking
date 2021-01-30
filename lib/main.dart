import 'package:covid19_tracking/constants/constants.dart';
import 'package:covid19_tracking/data/models/report.dart';
import 'package:covid19_tracking/screen/home_screen.dart';
import 'package:covid19_tracking/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/providers/reports.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Reports();
    return ChangeNotifierProvider(
      create: (context) => model,
      builder: (context, child) {
        return MaterialApp(
          theme: kTheme,
          home: FutureBuilder(
            future: model.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return HomeScreen();
                }
              }
              return HomeScreen();
            },
          ),
        );
      },
    );
  }
}
