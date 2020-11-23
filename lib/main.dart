import 'package:bug_report/report.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());

  final Reports = new Report();
  final report1 = new Report(
      id: 0, title: 'Report bugs', body: 'word word word words', type: 'BUG');
  final report2 = new Report(
      id: 1, title: 'Report bugs', body: 'word word word words', type: 'BUG');
  final report3 = new Report(
      id: 2, title: 'Report bugs', body: 'word word word words', type: 'BUG');

  await Reports.addReport(report1);
  await Reports.addReport(report2);
  await Reports.addReport(report3);

  await Reports.resetDb();
}

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        home: MyHomePage(title: appTitle),
        theme: ThemeData(primaryColor: Colors.green));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var username = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController(text: password);
    final usernameController = TextEditingController(text: username);
    final usernameField = TextFormField(
      controller: null,
      initialValue: username,
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      controller: null,
      initialValue: password,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (passwordController.text == "1234" &&
              usernameController.text == "sarah") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DrawerPage(title: "Bug Report", username: username)),
            );
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                usernameField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerPage extends StatelessWidget {
  final String title;
  final String username;
  List data;
  var Reports = new Report();

  DrawerPage({Key key, this.title, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: new FutureBuilder<List<Report>>(
        future: Reports.fetchReports(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          List<Report> posts = snapshot.data;
          return new ListView(
            children: posts
                .map(
                  (post) => ListTile(
                    title: Text('Title: ' + post.title),
                    subtitle: Text(post.body),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      // do something
                    },
                    onLongPress: () {
                      // do something else
                    },
                  ),
                )
                .toList(),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var rep = Report(
              id: await Reports.getIndex() + 1,
              title: 'Bug Report',
              body: 'wordy word',
              type: 'BUG');
          Reports.addReport(rep);
          print(await Reports.fetchReports());
          print(await Reports.getIndex());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DrawerPage(title: "Bug Report", username: username)),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(username),
                radius: 50.0,
              )),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('View Bug Report'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Create Bug Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateReportPage(
                          title: "Create Bug Report", username: username)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CreateReportPage extends StatelessWidget {
  final String title;
  final String username;
  List data;
  var Reports = new Report();

  CreateReportPage({Key key, this.title, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var rep = Report(
              id: await Reports.getIndex() + 1,
              title: 'Bug Report',
              body: 'wordy word',
              type: 'BUG');
          Reports.addReport(rep);
          print(await Reports.fetchReports());
          print(await Reports.getIndex());
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(username),
                radius: 50.0,
              )),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('View Bug Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DrawerPage(
                          title: "View Bug Report", username: username)),
                );
              },
            ),
            ListTile(
              title: Text('Create Bug Report'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
