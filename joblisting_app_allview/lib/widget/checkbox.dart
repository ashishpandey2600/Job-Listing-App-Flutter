import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCheckBoxUI extends StatefulWidget {
  @override
  _MyCheckBoxUIState createState() => _MyCheckBoxUIState();
}

class _MyCheckBoxUIState extends State<MyCheckBoxUI> {
  bool checkBox1Value = false;
  bool checkBox2Value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CheckboxListTile(
          title: Text('Job Seeker'),
          value: checkBox1Value,
          onChanged: (value) {
            setState(() {
              checkBox1Value = value!;
              checkBox2Value = !value;
            });
          },
        ),
        CheckboxListTile(
          title: Text('Job Provider'),
          value: checkBox2Value,
          onChanged: (value) {
            setState(() {
              checkBox2Value = value!;
              checkBox1Value = !value;
            });
          },
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
