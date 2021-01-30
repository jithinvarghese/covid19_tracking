import 'package:covid19_tracking/data/providers/reports.dart';
import 'package:covid19_tracking/screen/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GlobalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Reports>(
      builder: (context, modelReport, _) {
        return GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            StatusCard(
              imageurl: 'assets/images/icons/total.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.totalCases),
              ),
              colors: Colors.orange,
              label: 'Total',
            ),
            StatusCard(
              imageurl: 'assets/images/icons/new.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.newCases),
              ),
              colors: Colors.blue,
              label: 'New',
            ),
            StatusCard(
              imageurl: 'assets/images/icons/active.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.activeCases),
              ),
              colors: Colors.teal,
              label: 'Active',
            ),
            StatusCard(
              imageurl: 'assets/images/icons/critical.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.criticalCases),
              ),
              colors: Colors.pink,
              label: 'Critical',
            ),
            StatusCard(
              imageurl: 'assets/images/icons/recovered.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.recoveredCases),
              ),
              colors: Colors.green,
              label: 'Recovered',
            ),
            StatusCard(
              imageurl: 'assets/images/icons/death.png',
              status: NumberFormat.compact().format(
                double.parse(modelReport.globalCases.totalDeaths),
              ),
              colors: Colors.red,
              label: 'Death',
            ),
          ],
        );
      },
    );
  }
}
