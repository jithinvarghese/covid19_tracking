import 'package:covid19_tracking/main.dart';
import 'package:covid19_tracking/screen/all_countries/all_countries_screen.dart';
import 'package:covid19_tracking/screen/global/global_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('covid tracking'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: FaIcon(FontAwesomeIcons.globe),
                text: 'GLOBAL',
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.list),
                text: 'ALL COUNTRIES',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GlobalScreen(),
            AllCountriesScreen(),
          ],
        ),
      ),
    );
  }
}
