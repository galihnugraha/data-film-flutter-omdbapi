import '../boxes.dart';
import '../model/bookmarks.dart';
import '../controller/films_data_source.dart';
import '../model/details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PageDetailFilm extends StatefulWidget {
  final String text;
  const PageDetailFilm({Key? key, required this.text}) : super(key: key);
  @override
  State<PageDetailFilm> createState() => _PageDetailFilmState();
}

class _PageDetailFilmState extends State<PageDetailFilm> {
  late String title, released, poster;

  void _onAddToBookmark() {
    Box<Bookmark> bookmarkBox = Hive.box<Bookmark>(HiveBoxes.bookmark);
    bookmarkBox.add(Bookmark(title: title, released: released, poster: poster,));
    Navigator.of(context).pop();
    print(bookmarkBox);
  }

  void openBoxHive() async {
    await Hive.openBox<Bookmark>(HiveBoxes.bookmark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Film"),
      ),
      body: _buildListUsersBody(context),
    );
  }

  Widget _buildListUsersBody(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: FilmsDataSource.instance.loadDetailFilm(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika link API tidak dapat diakses, maka akan menmapilkan error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            FilmDetails detailFilm = FilmDetails.fromJson(snapshot.data);
            return _buildSuccessSection(detailFilm, context);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 35.0,
          ),
          Text("Link API tidak dapat diakses"),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.all(1),
            child: ElevatedButton(
              child: Text('Kembali ke halaman list film'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessSection(FilmDetails detailFilm, BuildContext context) {
    title = detailFilm.title!;
    released = detailFilm.released!;
    poster = detailFilm.poster!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          // bisa di slide
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.network(detailFilm.poster!),
          ),
        ),
        Container(
          child: Text(
            detailFilm.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailFilmText("Date Released :  ${detailFilm.released!}",
                  const EdgeInsets.only(bottom: 3, top: 25, left: 50)),
              _detailFilmText("Genre :  ${detailFilm.genre!}",
                  const EdgeInsets.only(bottom: 3, left: 50)),
              _detailFilmText("Director :  ${detailFilm.director!}",
                  const EdgeInsets.only(bottom: 3, left: 50)),
              _detailFilmText("Actor :  ${detailFilm.actors!}",
                  const EdgeInsets.only(bottom: 3, left: 50)),
              _detailFilmText("Plot : ",
                  const EdgeInsets.only(bottom: 3, left: 50)),
              _detailFilmText(detailFilm.plot!,
                  const EdgeInsets.only(bottom: 3, left: 50)),
              const SizedBox(height: 10.0),
              _buttonAddBookmark(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailFilmText(String text, EdgeInsetsGeometry paddingCustom) {
    return Padding(
      padding: paddingCustom,
      child: Text(text),
    );
  }

  Widget _buttonAddBookmark(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          _onAddToBookmark();
        },
        child: Text(
          "Add to Bookmark",
          style: GoogleFonts.nunitoSans(
              textStyle:
                  const TextStyle(fontStyle: FontStyle.normal, fontSize: 15.0)),
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
}
