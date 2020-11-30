import 'package:bug_report/User.dart';
import 'package:bug_report/detailScreen.dart';
import 'package:bug_report/formScreens.dart';
import 'package:bug_report/report.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());

  final Users = new User();
  await Users.createDb();
  final User1 = new User(
      id: 0,
      firstName: 'Bobby',
      lastName: 'Jenkins',
      username: 'Bob',
      email: 'bob@gmail.com',
      password: '1234');
  final User2 = new User(
      id: 1,
      firstName: 'Jimmy',
      lastName: 'Fenian',
      username: 'Jim',
      email: 'jim@gmail.com',
      password: '1234');
  final User3 = new User(
      id: (await Users.getIndex() + 1),
      firstName: 'Sarah',
      lastName: 'Rosli',
      username: 'sarah',
      email: 'sarah@gmail.com',
      password: '1234');

  await Users.addUser(User1);
  await Users.addUser(User2);
  await Users.addUser(User3);
  print(await Users.getUser(0));
  print(await Users.getUser(1));
  print(await Users.fetchUsers());
  print(await Users.signIn('Bob', '1234'));
  print(await Users.signIn('Bob', '124'));
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

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
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
                    builder: (context) => DrawerPage(
                        title: "View Bug Report", username: username)),
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

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Text("Sign Up",
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
                  height: 130.0,
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
                signUpButton,
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
                    leading: CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 35,
                      child: Center(
                        child: Text(
                          post.severity,
                          style: TextStyle(
                              color: post.severity == 'Critical'
                                  ? Colors.red
                                  : (post.severity == 'Major')
                                      ? Colors.orange
                                      : (post.severity == 'Moderate')
                                          ? Colors.blueGrey
                                          : Colors.greenAccent),
                        ),
                      ),
                    ),
                    title: Text(
                      '[ ' + post.product + ']' + '\n' + post.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Reporter: ' + post.reporter),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            report: post,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateReportPage(
                    title: "Create Bug Report", username: username)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
      drawer: Drawer(
        child: ListView(
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

class SignUpPageState extends State<SignUpPage> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );
  var username = "";
  var password = "";
  var firstName = "";
  var lastName = "";
  var email = "";

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);
    final passwordController = TextEditingController(text: password);
    final usernameController = TextEditingController(text: username);
    final emailController = TextEditingController(text: email);
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

    final firstNameField = TextFormField(
      controller: null,
      initialValue: firstName,
      onChanged: (value) {
        setState(() {
          firstName = value;
        });
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final lastNameField = TextFormField(
      controller: null,
      initialValue: lastName,
      onChanged: (value) {
        setState(() {
          lastName = value;
        });
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
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

    final emailField = TextFormField(
      controller: null,
      initialValue: email,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
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

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            if (usernameController.text != "" &&
                passwordController.text != "" &&
                firstNameController.text != "" &&
                lastNameController.text != "" &&
                emailController.text != "") {
              var newUser = User(
                  id: (await Users.getIndex() + 1),
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  username: usernameController.text,
                  password: passwordController.text);
              await Users.addUser(newUser);
              print(await Users.fetchUsers());
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            } else {
              _showAlertDialog("Please fill up all the fields");
            }
          } catch (error) {
            _showAlertDialog("Invalid username or password");
          }
        },
        child: Text("Register Account",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.greenAccent)),
      ),
    );

    return Scaffold(
        appBar: AppBar(title: Text('Sign Up Page')),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: [
                Expanded(child: firstNameField),
                SizedBox(width: 15.0),
                Expanded(child: lastNameField)
              ]),
              SizedBox(height: 10.0),
              usernameField,
              SizedBox(height: 10.0),
              emailField,
              SizedBox(height: 10.0),
              passwordField,
              SizedBox(
                height: 25.0,
              ),
              signUpButton,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}

class CreateReportPage extends StatelessWidget {
  final String title;
  final String username;
  List data;
  var Reports = new Report();
  var Users = new User();

  CreateReportPage({Key key, this.title, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text('HIS KKM SIT Lite Version'),
              subtitle: Text('System Integration Test for Lite Version'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                var email = await Users.getEmail(this.username);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LiteProductForm(
                          email: email, username: this.username)),
                );
              },
            ),
            ListTile(
              title: Text('HIS KKM SIT System Testing'),
              subtitle: Text('System Testing for HIS KKM'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                var email = await Users.getEmail(this.username);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestingProductForm(
                          email: email, username: this.username)),
                );
              },
            ),
            ListTile(
              title: Text('HIS KKM UAT EMR Basic'),
              subtitle: Text('User Acceptance for EMR Basis HIS KKM'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                var email = await Users.getEmail(this.username);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasicProductForm(
                          email: email, username: this.username)),
                );
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
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
