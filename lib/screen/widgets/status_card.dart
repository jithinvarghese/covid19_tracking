import 'package:covid19_tracking/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusCard extends StatefulWidget {
  final String imageurl;
  final String label;
  final String status;
  final Color colors;

  StatusCard({this.imageurl, this.label, this.status, this.colors});

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> with TickerProviderStateMixin {
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
    return ScaleTransition(
      scale: _animation,
      child: Card(
        shape: kCardShape,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              widget.imageurl,
              height: 60,
            ),
            Text(
              widget.status,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.colors,
              ),
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
