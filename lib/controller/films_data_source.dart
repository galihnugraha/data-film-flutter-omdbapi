import '../service/base_network.dart';

class FilmsDataSource {
  static FilmsDataSource instance = FilmsDataSource();

  Future<Map<String, dynamic>> loadFilms(String text) {
    return BaseNetwork.get("s=" + text);
  }

  Future<Map<String, dynamic>> loadDetailFilm(String imdbID) {
    return BaseNetwork.get("i=${imdbID}");
  }
}