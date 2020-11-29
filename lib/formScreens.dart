import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class LiteProductForm extends StatefulWidget {
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
    S2Choice<String>(value: 'IDK', title: 'IDK')
  ];

  var title = '';
  var component = '';
  var version = '';
  var severity = '';
  var os = '';
  var hardware = '';
  var summary = '';
  var defectType = '';
  var productText = 'HIS KKM SIT Lite Version';

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final componentController = TextEditingController(text: component);
    final versionController = TextEditingController(text: version);
    final osController = TextEditingController(text: os);
    final severityController = TextEditingController(text: severity);
    final hardwareController = TextEditingController(text: hardware);
    final summaryController = TextEditingController(text: summary);
    final defectTypeController = TextEditingController(text: defectType);
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
                      return 'Please enter some text';
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
                SmartSelect<String>.single(
                    title: 'Component',
                    value: component,
                    choiceItems: componentOptions,
                    onChange: (state) =>
                        setState(() => component = state.value)),
                SmartSelect<String>.single(
                    title: 'Defect Type',
                    value: defectType,
                    choiceItems: defectTypeOptions,
                    onChange: (state) =>
                        setState(() => defectType = state.value)),
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
                        return 'Please enter some text';
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(titleController.text);
                        print(componentController.text);
                        print(versionController.text);
                        print(severityController.text);
                        print(osController.text);
                        print(hardwareController.text);
                        print(summaryController.text);
                        print(defectTypeController.text);
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
