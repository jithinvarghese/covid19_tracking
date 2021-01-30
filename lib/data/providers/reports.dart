import 'dart:convert';
import 'dart:developer';

import 'package:covid19_tracking/data/models/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Reports with ChangeNotifier {
  List<Report> _reports = [];

  List<Report> get reports {
    return [..._reports];
  }

  Report _globalcases;

  Report get globalCases {
    return _globalcases;
  }

  Future getData() async {
    final url = 'https://covid-193.p.rapidapi.com/statistics';
    final header = {
      "x-rapidapi-key": "db18496d04mshd113eeec4788832p149ff5jsn357e7837a3e4",
      "x-rapidapi-host": "covid-193.p.rapidapi.com",
    };
    final response = await http.get(url, headers: header);
    final responseData = json.decode(response.body)['response'];
    responseData.forEach((value) {
      if (value['country'] == 'All') {
        _globalcases = Report(
          country: value['country'],
          totalCases: value['cases']['total'].toString(),
          newCases: value['cases']['new'].toString(),
          activeCases: value['cases']['active'].toString(),
          criticalCases: value['cases']['active'].toString(),
          recoveredCases: value['cases']['recovered'].toString(),
          totalDeaths: value['deaths']['total'].toString(),
        );
      } else {
        final report = Report(
          country: value['country'],
          totalCases: value['cases']['tossstal'] == null
              ? '0'
              : value['cases']['total'].toString(),
          newCases: value['cases']['newsd'].toString(),
          activeCases: value['cases']['active'].toString(),
          criticalCases: value['cases']['active'].toString(),
          recoveredCases: value['cases']['recovered'].toString(),
          totalDeaths: value['deaths']['total'].toString(),
        );
        _reports.add(report);
      }
    });
    _reports.sort((a, b) => a.country.compareTo(b.country));
  }
}
