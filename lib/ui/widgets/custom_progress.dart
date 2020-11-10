import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatefulWidget {
  @override
  _CustomProgressState createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.6,
      child: Center(
        child: SizedBox(
          height: 40,
          width: 60,
          child: FlareActor('assets/animations/News.flr',
              animation: 'start', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
