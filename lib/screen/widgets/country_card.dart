import 'package:covid19_tracking/constants/constants.dart';
import 'package:covid19_tracking/data/providers/reports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class CountryCard extends StatefulWidget {
  final int index;
  CountryCard({this.index});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: _controller,
    );
    if (_animation.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Reports>(
      builder: (context, model, _) {
        return ScaleTransition(
          scale: _controller,
          child: Card(
            shape: kCardShape,
            child: ListTile(
              onTap: () => buildBottomSheet(context),
              shape: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/country_flags/${model.reports[widget.index].country}.png'),
                radius: 25,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  model.reports[widget.index].country,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${model.reports[widget.index].totalCases}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Active: ${model.reports[widget.index].activeCases}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return Consumer<Reports>(
            builder: (context, model, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      model.reports[widget.index].country,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Details(
                    label: 'Total',
                    status: model.reports[widget.index].totalCases,
                    color: Colors.red,
                  ),
                  Details(
                    label: 'New',
                    status: model.reports[widget.index].newCases,
                    color: Colors.yellow,
                  ),
                  Details(
                    label: 'Active',
                    status: model.reports[widget.index].activeCases,
                    color: Colors.green,
                  ),
                  Details(
                    label: 'Critical',
                    status: model.reports[widget.index].criticalCases,
                    color: Colors.pink,
                  ),
                  Details(
                    label: 'Recoverd',
                    status: model.reports[widget.index].recoveredCases,
                    color: Colors.white,
                  ),
                  Details(
                    label: 'Deaths',
                    status: model.reports[widget.index].totalDeaths,
                    color: Colors.tealAccent,
                  ),
                ],
              );
            },
          );
        });
  }
}
