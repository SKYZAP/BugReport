import 'package:bug_report/report.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'main.dart';

class LiteProductForm extends StatefulWidget {
  final String email;
  final String username;

  LiteProductForm({Key key, this.email, this.username}) : super(key: key);
  @override
  LiteProductFormState createState() {
    return LiteProductFormState();
  }
}

class LiteProductFormState extends State<LiteProductForm> {
  final _formKey = GlobalKey<FormState>();

  List<S2Choice<String>> componentOptions = [
    S2Choice<String>(
        value: 'Dietetic and Food Services',
        title: 'Dietetic and Food Services'),
    S2Choice<String>(value: 'Laboratory', title: 'Laboratory'),
    S2Choice<String>(value: 'Medical Record', title: 'Medical Record'),
  ];

  List<S2Choice<String>> versionOptions = [
    S2Choice<String>(value: 'Unspecified', title: 'Unspecified'),
  ];

  List<S2Choice<String>> osOptions = [
    S2Choice<String>(value: 'Windows', title: 'Windows'),
    S2Choice<String>(value: 'Linux', title: 'Linux'),
    S2Choice<String>(value: 'Ubuntu', title: 'Ubuntu'),
  ];

  List<S2Choice<String>> severityOptions = [
    S2Choice<String>(value: 'Low', title: 'Low'),
    S2Choice<String>(value: 'Moderate', title: 'Moderate'),
    S2Choice<String>(value: 'Critical', title: 'Critical'),
    S2Choice<String>(value: 'Major', title: 'Major'),
  ];

  List<S2Choice<String>> hardwareOptions = [
    S2Choice<String>(value: 'PC', title: 'PC'),
    S2Choice<String>(value: 'Mobile', title: 'Mobile'),
  ];

  List<S2Choice<String>> defectTypeOptions = [
    S2Choice<String>(value: 'Functionality', title: 'Functionality'),
    S2Choice<String>(value: 'Data', title: 'Data'),
    S2Choice<String>(value: 'Performance Issue', title: 'Performance Issue'),
    S2Choice<String>(value: 'Interface', title: 'Interface'),
    S2Choice<String>(value: 'Syntax', title: 'Syntax'),
  ];

  var title = '';
  var component = '';
  var version = '';
  var severity = '';
  var os = '';
  var hardware = '';
  var summary = '';
  var defect = '';
  var productText = 'HIS KKM SIT Lite Version';
  var assignee = '';

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final username = widget.username;
    final titleController = TextEditingController(text: title);
    final componentController = TextEditingController(text: component);
    final versionController = TextEditingController(text: version);
    final osController = TextEditingController(text: os);
    final severityController = TextEditingController(text: severity);
    final hardwareController = TextEditingController(text: hardware);
    final summaryController = TextEditingController(text: summary);
    final defectTypeController = TextEditingController(text: defect);
    final assigneeController = TextEditingController(text: assignee);

    var ReportDb = new Report();

    return Scaffold(
      appBar: AppBar(title: Text('HIS KKM SIT Lite Report')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      assignee = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an assignee email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Assignee",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                SmartSelect<String>.single(
                    title: 'Component',
                    value: component,
                    choiceItems: componentOptions,
                    onChange: (state) =>
                        setState(() => component = state.value)),
                SmartSelect<String>.single(
                    title: 'Defect Type',
                    value: defect,
                    choiceItems: defectTypeOptions,
                    onChange: (state) => setState(() => defect = state.value)),
                SmartSelect<String>.single(
                    title: 'Version',
                    value: version,
                    choiceItems: versionOptions,
                    onChange: (state) => setState(() => version = state.value)),
                SmartSelect<String>.single(
                    title: 'Severity',
                    value: severity,
                    choiceItems: severityOptions,
                    onChange: (state) =>
                        setState(() => severity = state.value)),
                SmartSelect<String>.single(
                    title: 'Hardware',
                    value: hardware,
                    choiceItems: hardwareOptions,
                    onChange: (state) =>
                        setState(() => hardware = state.value)),
                SmartSelect<String>.single(
                    title: 'OS',
                    value: os,
                    choiceItems: osOptions,
                    onChange: (state) => setState(() => os = state.value)),
                SizedBox(height: 10.0),
                Container(
                  height: 100.0,
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        summary = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the summary';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Summary",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var report = Report(
                            title: titleController.text,
                            assignee: assigneeController.text,
                            component: componentController.text,
                            defect: defectTypeController.text,
                            version: versionController.text,
                            severity: severityController.text,
                            hardware: hardwareController.text,
                            os: osController.text,
                            summary: summaryController.text,
                            reporter: email,
                            product: productText);
                        await ReportDb.addReport(report);
                        print(await ReportDb.fetchReports());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrawerPage(
                                  title: "View Bug Report",
                                  username: username)),
                        );
                      }
                    },
                    child: Text("Submit",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.greenAccent)),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class TestingProductForm extends StatefulWidget {
  final String email;
  final String username;

  TestingProductForm({Key key, this.email, this.username}) : super(key: key);
  @override
  TestingProductFormState createState() {
    return TestingProductFormState();
  }
}

class TestingProductFormState extends State<TestingProductForm> {
  final _formKey = GlobalKey<FormState>();

  List<S2Choice<String>> componentOptions = [
    S2Choice<String>(
        value: 'Administrator Tools', title: 'Administrator Tools'),
    S2Choice<String>(
        value: 'Billing and Payment', title: 'Billing and Payment'),
    S2Choice<String>(value: 'Common Issue', title: 'Common Issue'),
    S2Choice<String>(
        value: 'Dietetic and Food Services',
        title: 'Dietetic and Food Services'),
    S2Choice<String>(
        value: 'Emergency and Trauma Department',
        title: 'Emergency and Trauma Department'),
    S2Choice<String>(value: 'General', title: 'General'),
    S2Choice<String>(
        value: 'Inpatient/Outpatient Module',
        title: 'Inpatient/Outpatient Module'),
    S2Choice<String>(value: 'Laboratory', title: 'Laboratory'),
    S2Choice<String>(value: 'Medical Record', title: 'Medical Record'),
    S2Choice<String>(value: 'Medicine', title: 'Medicine'),
    S2Choice<String>(value: 'Mobile Application', title: 'Mobile Application'),
    S2Choice<String>(value: 'Nursing', title: 'Nursing'),
    S2Choice<String>(
        value: 'Obstetrics and Gynaecology',
        title: 'Obstetrics and Gynaecology'),
    S2Choice<String>(value: 'Ophthalmology', title: 'Ophthalmology'),
    S2Choice<String>(value: 'Oral Health', title: 'Oral Health'),
    S2Choice<String>(value: 'Orthopaedics', title: 'Orthopaedics'),
    S2Choice<String>(
        value: 'Otorhinolaryngology', title: 'Otorhinolaryngology'),
    S2Choice<String>(
        value: 'Paediatrics and Neonatology',
        title: 'Paediatrics and Neonatology'),
    S2Choice<String>(
        value: 'Patient Management System', title: 'Patient Management System'),
    S2Choice<String>(value: 'Psychiatry', title: 'Psychiatry'),
    S2Choice<String>(value: 'Radiology', title: 'Radiology'),
  ];

  List<S2Choice<String>> versionOptions = [
    S2Choice<String>(value: 'Build 6', title: 'Build 6'),
    S2Choice<String>(value: 'Build 7', title: 'Build 7'),
    S2Choice<String>(value: 'Cycle 1', title: 'Cycle 1'),
    S2Choice<String>(value: 'Cycle 2', title: 'Cycle 2'),
    S2Choice<String>(value: 'Cycle 3', title: 'Cycle 3'),
  ];

  List<S2Choice<String>> osOptions = [
    S2Choice<String>(value: 'Windows', title: 'Windows'),
    S2Choice<String>(value: 'Linux', title: 'Linux'),
    S2Choice<String>(value: 'Ubuntu', title: 'Ubuntu'),
  ];

  List<S2Choice<String>> severityOptions = [
    S2Choice<String>(value: 'Low', title: 'Low'),
    S2Choice<String>(value: 'Moderate', title: 'Moderate'),
    S2Choice<String>(value: 'Critical', title: 'Critical'),
    S2Choice<String>(value: 'Major', title: 'Major'),
  ];

  List<S2Choice<String>> hardwareOptions = [
    S2Choice<String>(value: 'PC', title: 'PC'),
    S2Choice<String>(value: 'Mobile', title: 'Mobile'),
  ];

  List<S2Choice<String>> defectTypeOptions = [
    S2Choice<String>(value: 'Functionality', title: 'Functionality'),
    S2Choice<String>(value: 'Data', title: 'Data'),
    S2Choice<String>(value: 'Performance Issue', title: 'Performance Issue'),
    S2Choice<String>(value: 'Interface', title: 'Interface'),
    S2Choice<String>(value: 'Syntax', title: 'Syntax'),
  ];

  var title = '';
  var component = '';
  var version = '';
  var severity = '';
  var os = '';
  var hardware = '';
  var summary = '';
  var defect = '';
  var productText = 'HIS KKM System Testing';
  var assignee = '';

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final username = widget.username;
    final titleController = TextEditingController(text: title);
    final componentController = TextEditingController(text: component);
    final versionController = TextEditingController(text: version);
    final osController = TextEditingController(text: os);
    final severityController = TextEditingController(text: severity);
    final hardwareController = TextEditingController(text: hardware);
    final summaryController = TextEditingController(text: summary);
    final defectTypeController = TextEditingController(text: defect);
    final assigneeController = TextEditingController(text: assignee);

    var ReportDb = new Report();

    return Scaffold(
      appBar: AppBar(title: Text('HIS KKM System Testing')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      assignee = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an assignee email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Assignee",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                SmartSelect<String>.single(
                    title: 'Component',
                    value: component,
                    choiceItems: componentOptions,
                    onChange: (state) =>
                        setState(() => component = state.value)),
                SmartSelect<String>.single(
                    title: 'Defect Type',
                    value: defect,
                    choiceItems: defectTypeOptions,
                    onChange: (state) => setState(() => defect = state.value)),
                SmartSelect<String>.single(
                    title: 'Version',
                    value: version,
                    choiceItems: versionOptions,
                    onChange: (state) => setState(() => version = state.value)),
                SmartSelect<String>.single(
                    title: 'Severity',
                    value: severity,
                    choiceItems: severityOptions,
                    onChange: (state) =>
                        setState(() => severity = state.value)),
                SmartSelect<String>.single(
                    title: 'Hardware',
                    value: hardware,
                    choiceItems: hardwareOptions,
                    onChange: (state) =>
                        setState(() => hardware = state.value)),
                SmartSelect<String>.single(
                    title: 'OS',
                    value: os,
                    choiceItems: osOptions,
                    onChange: (state) => setState(() => os = state.value)),
                SizedBox(height: 10.0),
                Container(
                  height: 100.0,
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        summary = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the summary';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Summary",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var report = Report(
                            title: titleController.text,
                            assignee: assigneeController.text,
                            component: componentController.text,
                            defect: defectTypeController.text,
                            version: versionController.text,
                            severity: severityController.text,
                            hardware: hardwareController.text,
                            os: osController.text,
                            summary: summaryController.text,
                            reporter: email,
                            product: productText);
                        await ReportDb.addReport(report);
                        print(await ReportDb.fetchReports());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrawerPage(
                                  title: "View Bug Report",
                                  username: username)),
                        );
                      }
                    },
                    child: Text("Submit",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.greenAccent)),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class BasicProductForm extends StatefulWidget {
  final String email;
  final String username;

  BasicProductForm({Key key, this.email, this.username}) : super(key: key);
  @override
  BasicProductFormState createState() {
    return BasicProductFormState();
  }
}

class BasicProductFormState extends State<BasicProductForm> {
  final _formKey = GlobalKey<FormState>();

  List<S2Choice<String>> componentOptions = [
    S2Choice<String>(
        value: 'Administrator Tools', title: 'Administrator Tools'),
    S2Choice<String>(
        value: 'Billing and Payment', title: 'Billing and Payment'),
    S2Choice<String>(
        value: 'Dietetic and Food Services',
        title: 'Dietetic and Food Services'),
    S2Choice<String>(value: 'General', title: 'General'),
    S2Choice<String>(value: 'Laboratory', title: 'Laboratory'),
    S2Choice<String>(value: 'Medical Record', title: 'Medical Record'),
    S2Choice<String>(
        value: 'Patient Management System', title: 'Patient Management System'),
    S2Choice<String>(value: 'Staff Management', title: 'Staff Management'),
  ];

  List<S2Choice<String>> versionOptions = [
    S2Choice<String>(value: 'Cycle 1', title: 'Cycle 1'),
    S2Choice<String>(value: 'Cycle 2', title: 'Cycle 2'),
    S2Choice<String>(value: 'Cycle 3', title: 'Cycle 3'),
  ];

  List<S2Choice<String>> osOptions = [
    S2Choice<String>(value: 'Windows', title: 'Windows'),
    S2Choice<String>(value: 'Linux', title: 'Linux'),
    S2Choice<String>(value: 'Ubuntu', title: 'Ubuntu'),
  ];

  List<S2Choice<String>> severityOptions = [
    S2Choice<String>(value: 'Low', title: 'Low'),
    S2Choice<String>(value: 'Moderate', title: 'Moderate'),
    S2Choice<String>(value: 'Critical', title: 'Critical'),
    S2Choice<String>(value: 'Major', title: 'Major'),
  ];

  List<S2Choice<String>> hardwareOptions = [
    S2Choice<String>(value: 'PC', title: 'PC'),
    S2Choice<String>(value: 'Mobile', title: 'Mobile'),
  ];

  List<S2Choice<String>> defectTypeOptions = [
    S2Choice<String>(value: 'Functionality', title: 'Functionality'),
    S2Choice<String>(value: 'Data', title: 'Data'),
    S2Choice<String>(value: 'Performance Issue', title: 'Performance Issue'),
    S2Choice<String>(value: 'Interface', title: 'Interface'),
    S2Choice<String>(value: 'Syntax', title: 'Syntax'),
  ];

  var title = '';
  var component = '';
  var version = '';
  var severity = '';
  var os = '';
  var hardware = '';
  var summary = '';
  var defect = '';
  var productText = 'HIS KKM UAT EMR Basic';
  var assignee = '';

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final username = widget.username;
    final titleController = TextEditingController(text: title);
    final componentController = TextEditingController(text: component);
    final versionController = TextEditingController(text: version);
    final osController = TextEditingController(text: os);
    final severityController = TextEditingController(text: severity);
    final hardwareController = TextEditingController(text: hardware);
    final summaryController = TextEditingController(text: summary);
    final defectTypeController = TextEditingController(text: defect);
    final assigneeController = TextEditingController(text: assignee);

    var ReportDb = new Report();

    return Scaffold(
      appBar: AppBar(title: Text('HIS KKM UAT EMR Basic')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      assignee = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an assignee email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Assignee",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 10.0),
                SmartSelect<String>.single(
                    title: 'Component',
                    value: component,
                    choiceItems: componentOptions,
                    onChange: (state) =>
                        setState(() => component = state.value)),
                SmartSelect<String>.single(
                    title: 'Defect Type',
                    value: defect,
                    choiceItems: defectTypeOptions,
                    onChange: (state) => setState(() => defect = state.value)),
                SmartSelect<String>.single(
                    title: 'Version',
                    value: version,
                    choiceItems: versionOptions,
                    onChange: (state) => setState(() => version = state.value)),
                SmartSelect<String>.single(
                    title: 'Severity',
                    value: severity,
                    choiceItems: severityOptions,
                    onChange: (state) =>
                        setState(() => severity = state.value)),
                SmartSelect<String>.single(
                    title: 'Hardware',
                    value: hardware,
                    choiceItems: hardwareOptions,
                    onChange: (state) =>
                        setState(() => hardware = state.value)),
                SmartSelect<String>.single(
                    title: 'OS',
                    value: os,
                    choiceItems: osOptions,
                    onChange: (state) => setState(() => os = state.value)),
                SizedBox(height: 10.0),
                Container(
                  height: 100.0,
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        summary = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the summary';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Summary",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var report = Report(
                            title: titleController.text,
                            assignee: assigneeController.text,
                            component: componentController.text,
                            defect: defectTypeController.text,
                            version: versionController.text,
                            severity: severityController.text,
                            hardware: hardwareController.text,
                            os: osController.text,
                            summary: summaryController.text,
                            reporter: email,
                            product: productText);
                        await ReportDb.addReport(report);
                        print(await ReportDb.fetchReports());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DrawerPage(
                                  title: "View Bug Report",
                                  username: username)),
                        );
                      }
                    },
                    child: Text("Submit",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.greenAccent)),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
