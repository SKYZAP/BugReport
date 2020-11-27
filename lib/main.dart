import 'package:bug_report/User.dart';
import 'package:bug_report/report.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());

  final Users = new User();
  await Users.createDb();
  final User1 = new User(
      id: 0, username: 'Bob', email: 'bob@gmail.com', password: '1234');
  final User2 = new User(
      id: 1, username: 'Jim', email: 'jim@gmail.com', password: '1234');
  final User3 = new User(
      id: 1, username: 'sarah', email: 'sarah@gmail.com', password: '1234');

  await Users.addUser(User1);
  await Users.addUser(User2);
  await Users.addUser(User3);
  print(await Users.getUser(0));
  print(await Users.getUser(1));
  print(await Users.fetchUsers());
  print(await Users.signIn('Bob', '1234'));
  print(await Users.signIn('Bob', '124'));

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
        initialRoute: '/',
        routes: {
          '/home': (context) => MyHomePage(),
          '/viewReport': (context) => DrawerPage(),
          '/createReport': (context) => CreateReportPage()
        },
        home: MyHomePage(title: appTitle),
        theme: ThemeData(primaryColor: Colors.greenAccent));
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
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );
  var username = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController(text: password);
    final usernameController = TextEditingController(text: username);
    final Users = new User();
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
    void _showAlertDialog(String message) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            if (await Users.signIn(
                usernameController.text, passwordController.text)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DrawerPage(title: "Bug Report", username: username)),
              );
            } else {
              _showAlertDialog("Invalid username or password");
            }
          } catch (error) {
            _showAlertDialog("Invalid username or password");
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.greenAccent)),
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
                builder: (context) => CreateReportPage(
                    title: "Create Bug Report", username: username)),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
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
                backgroundColor: Colors.white,
                child: Text(
                  username,
                  style: TextStyle(color: Colors.black),
                ),
                radius: 50.0,
              )),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
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
            SizedBox(
              height: 380.0,
            ),
            ListTile(
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                trailing: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
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
                backgroundColor: Colors.white,
                child: Text(username, style: TextStyle(color: Colors.black)),
                radius: 50.0,
              )),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
            ),
            ListTile(
              title: Text('View Bug Report'),
              onTap: () {
                Navigator.push(
                    context,
                    SlideRightRoute(
                        page: DrawerPage(
                            title: "View Bug Report", username: username)));
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
            SizedBox(
              height: 380.0,
            ),
            ListTile(
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                trailing: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
