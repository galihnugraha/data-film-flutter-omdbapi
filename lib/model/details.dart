class FilmDetails {
  final String? title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? poster;
  final List<Ratings>? ratings;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbID;
  final String? type;
  final String? dVD;
  final String? boxOffice;
  final String? production;
  final String? website;
  final String? response;

  FilmDetails({
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.ratings,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.type,
    this.dVD,
    this.boxOffice,
    this.production,
    this.website,
    this.response,
  });

  FilmDetails.fromJson(Map<String, dynamic> json)
      : title = json['Title'] as String?,
        year = json['Year'] as String?,
        rated = json['Rated'] as String?,
        released = json['Released'] as String?,
        runtime = json['Runtime'] as String?,
        genre = json['Genre'] as String?,
        director = json['Director'] as String?,
        writer = json['Writer'] as String?,
        actors = json['Actors'] as String?,
        plot = json['Plot'] as String?,
        language = json['Language'] as String?,
        country = json['Country'] as String?,
        awards = json['Awards'] as String?,
        poster = json['Poster'] as String?,
        ratings = (json['Ratings'] as List?)?.map((dynamic e) => Ratings.fromJson(e as Map<String,dynamic>)).toList(),
        metascore = json['Metascore'] as String?,
        imdbRating = json['imdbRating'] as String?,
        imdbVotes = json['imdbVotes'] as String?,
        imdbID = json['imdbID'] as String?,
        type = json['Type'] as String?,
        dVD = json['DVD'] as String?,
        boxOffice = json['BoxOffice'] as String?,
        production = json['Production'] as String?,
        website = json['Website'] as String?,
        response = json['Response'] as String?;

  Map<String, dynamic> toJson() => {
    'Title' : title,
    'Year' : year,
    'Rated' : rated,
    'Released' : released,
    'Runtime' : runtime,
    'Genre' : genre,
    'Director' : director,
    'Writer' : writer,
    'Actors' : actors,
    'Plot' : plot,
    'Language' : language,
    'Country' : country,
    'Awards' : awards,
    'Poster' : poster,
    'Ratings' : ratings?.map((e) => e.toJson()).toList(),
    'Metascore' : metascore,
    'imdbRating' : imdbRating,
    'imdbVotes' : imdbVotes,
    'imdbID' : imdbID,
    'Type' : type,
    'DVD' : dVD,
    'BoxOffice' : boxOffice,
    'Production' : production,
    'Website' : website,
    'Response' : response
  };
}

class Ratings {
  final String? source;
  final String? value;

  Ratings({
    this.source,
    this.value,
  });

  Ratings.fromJson(Map<String, dynamic> json)
      : source = json['Source'] as String?,
        value = json['Value'] as String?;

  Map<String, dynamic> toJson() => {
    'Source' : source,
    'Value' : value
  };
}