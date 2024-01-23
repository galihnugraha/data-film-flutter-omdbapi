import 'page_bookmarks.dart';
import 'page_detail_film.dart';
import '../controller/films_data_source.dart';
import '../model/films.dart';
import 'package:flutter/material.dart';

class PageListFilm extends StatefulWidget {
  final String keywordSearch;
  const PageListFilm({Key? key, required this.keywordSearch}) : super(key: key);
  @override
  State<PageListFilm> createState() => _PageListFilmState();
}

class _PageListFilmState extends State<PageListFilm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Film"),
      ),
      body: _buildListUsersBody(),
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

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: FilmsDataSource.instance.loadFilms(widget.keywordSearch),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika link API tidak dapat diakses, maka akan menmapilkan error
            return _buildErrorSection("Link API tidak dapat diakses");
          }
          if (snapshot.hasData) {
            if (snapshot.data.containsKey("Response")) {
              if (snapshot.data["Response"] == "False") {
                // Jika eror yang dikarenakan tidak valid API KEY atau MOVIE NOT FOUND
                if (!snapshot.data.containsKey("Error")) {
                  return _buildErrorSection("Terjadi Kesalahan");
                } else {
                  if (snapshot.data["Error"] == "Invalid API key!") {
                    print(snapshot.data["Error"]);
                    return _buildErrorSection("API KEY tidak valid!");
                  } else if (snapshot.data["Error"] == "Movie not found!") {
                    print(snapshot.data["Error"]);
                    return _buildErrorSection(
                        "Film yang anda cari tidak tersedia");
                  } else {
                    print(snapshot.data);
                    return _buildErrorSection("Terjadi Kesalahan");
                  }
                }
              } else {
                // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
                print("Success get data from OMDB API");
                FilmList filmsModel = FilmList.fromJson(snapshot.data);
                return _buildSuccessSection(filmsModel);
              }
            } else {
              print(snapshot.data);
              return _buildErrorSection("Terjadi Kesalahan");
            }
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

  Widget _buildErrorSection(String errorMessage) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 35.0,
          ),
          Text(errorMessage),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.all(1),
            child: ElevatedButton(
              child: Text('Kembali ke halaman pencarian'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessSection(FilmList filmsModel) {
    return ListView.builder(
      itemCount: filmsModel.search!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(filmsModel.search![index]);
      },
    );
  }

  Widget _buildItemUsers(Search filmData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageDetailFilm(text: filmData.imdbID!))),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(filmData.poster!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(filmData.title!), Text(filmData.year!)],
            ),
          ],
        ),
      ),
    );
  }
}
