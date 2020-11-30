import 'package:bug_report/report.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Report report;

  DetailScreen({Key key, this.report}) : super(key: key);
  @override
  DetailScreenState createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> {
  var style = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    var report = widget.report;
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reporter: ' + report.reporter, style: style),
              SizedBox(height: 20),
              Text('Severity: ' + report.severity, style: style),
              SizedBox(height: 20),
              Text('Product: ' + report.product, style: style),
              SizedBox(height: 20),
              Divider(thickness: 4, color: Colors.black),
              SizedBox(height: 20),
              Text('Component: ' + report.component, style: style),
              SizedBox(height: 20),
              Text('Version: ' + report.version, style: style),
              SizedBox(height: 20),
              Text('Hardware: ' + report.hardware, style: style),
              SizedBox(height: 20),
              Text('Defect Type: ' + report.defect, style: style),
              SizedBox(height: 20),
              Text('OS: ' + report.os, style: style),
              SizedBox(height: 20),
              Text('Assignee: ' + report.assignee, style: style),
              SizedBox(height: 20),
              Text('Summary: \n\n' + report.summary, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
