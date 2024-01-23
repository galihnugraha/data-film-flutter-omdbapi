import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_list_film.dart';
import 'page_login.dart';
import 'page_bookmarks.dart';

class PageSearchFilm extends StatefulWidget {
  const PageSearchFilm({Key? key}) : super(key: key);

  @override
  _PageSearchFilmState createState() => _PageSearchFilmState();
}

class _PageSearchFilmState extends State<PageSearchFilm> {
  final _keywordSearch = TextEditingController();

  late SharedPreferences logindata;
  late String? username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Film"),
        actions: <Widget> [
          _buttonLogout(context),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _searchSection(),
            SizedBox(height: 10.0,),
            _searchButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => PageBookmarks(),
              ))
        },
        tooltip: 'Bookmarked Films',
        child: Icon(Icons.bookmark),
      ),
    );
  }

  Widget _searchSection() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(1),
        child: Container(
          child: _searchTextField(),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      selectionHeightStyle: BoxHeightStyle.max,
      style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 15)),
      decoration: InputDecoration(
        hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
        hintText: "Enter film title",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
        filled: true,
        icon: Icon(
          Icons.search,
          size: 40.0,
        ),
      ),
      controller: _keywordSearch,
    );
  }

  Widget _searchButton() {
    return Container(
      padding: EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PageListFilm(keywordSearch: _keywordSearch.text);
          }));
        },
        child: Text("Search",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(fontStyle: FontStyle.normal, fontSize: 20.0)),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        ),
      ),
    );
  }

  Widget _buttonLogout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          Hive.close();
          logindata.setBool('login', true);
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text("Logout",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(fontStyle: FontStyle.normal, fontSize: 15.0)),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
          side: const BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }
}
