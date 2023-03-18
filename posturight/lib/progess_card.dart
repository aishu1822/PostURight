import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();
}
class _MyCardState extends State<MyCard> {
  String _text = "";
  double _progress = 0.0;
  void _updateText(String value) {
    setState(() {
      _text = value;
    });
  }
  void _updateProgress(double value) {
    setState(() {
      _progress = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Achievements',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 16.0),
            LinearProgressBar(
              maxSteps: 6,
              progressType: LinearProgressBar.progressTypeLinear,
              currentStep: 5,
              progressColor: Color.fromARGB(255, 41, 135, 68),
              backgroundColor: Color.fromARGB(255, 184, 226, 161),
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 80, 121, 58)),
              semanticsLabel: "Label",
              semanticsValue: "Value",
              minHeight: 10,
            ),
            SizedBox(height: 16.0),
            // LinearProgressIndicator(value: _progress, ),
            LinearProgressBar(
              maxSteps: 6,
              progressType: LinearProgressBar.progressTypeLinear,
              currentStep: 0,
              progressColor: Color.fromARGB(255, 41, 135, 68),
              backgroundColor: Color.fromARGB(255, 184, 226, 161),
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 80, 121, 58)),
              semanticsLabel: "Label",
              semanticsValue: "Value",
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }
}