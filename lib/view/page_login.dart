import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_search_film.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    _passwordVisible = false;
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PageSearchFilm()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0,),
              Text(
                "Login Form",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0,),
              _usernameSection(),
              _passwordSection(),
              _buttonLogin(context),
            ]
        ),
      ),
    );
  }

  Widget _usernameSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: username_controller,
        selectionHeightStyle: BoxHeightStyle.max,
        style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 15)),
        decoration: InputDecoration(
          labelText: 'Username',
          hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
          hintText: "input username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
          filled: true,
        ),
      ),
    );
  }

  Widget _passwordSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: password_controller,
        obscureText: !_passwordVisible,
        selectionHeightStyle: BoxHeightStyle.max,
        style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 15)),
        decoration: InputDecoration(
          labelText: 'Password',
          hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
          hintText: "input password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () => {
              setState(() {
                _passwordVisible = !_passwordVisible;
              },),
            },
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          String username = username_controller.text;
          String password = password_controller.text;

          if (username != '' && password != '') {
            print('Successfull');
            logindata.setBool('login', false);
            logindata.setString('username', username);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PageSearchFilm()));
          }
        },
        child: Text("Login",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(fontStyle: FontStyle.normal, fontSize: 20.0)),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        ),
      ),
    );
  }
}
