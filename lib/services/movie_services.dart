part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    // code versi dibawah sudah usang dengan http package jadul
    // String url =
    //     "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    // code http request versi baru
    var host = "api.themoviedb.org";
    var path = "/3/discover/movie";
    var params = {
      "api_key": "$apiKey",
      "language": "en-US",
      "sort_by": "popularity.desc",
      "include_adult": "false",
      "include_video": "false",
      "page": "$page",
    };

    var url = Uri.https(host, path, params);

    client ??= http.Client();
    var response = await client.get(url);

    // jika gagal
    if (response.statusCode != 200) {
      return [];
    }

    // jika berhasil
    var data = json.decode(response.body);
    List result = data['results'];

    // ambil movie dari API json
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    // code versi dibawah sudah usang dengan http package jadul
    // String url =
    //     "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    // code http request versi baru
    var host = "api.themoviedb.org";
    var path = "/3/movie/${movieID ?? movie.id}";
    var params = {
      "api_key": "$apiKey",
      "language": "en-US",
    };

    var url = Uri.https(host, path, params);

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    // ambil list genre dari API
    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    // ubah bahasa
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'en':
        language = "English";
        break;
    }

    // ambil genre name dari API json
    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    // code versi dibawah sudah usang dengan http package jadul
    // String url =
    //     "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey";

    // code http request versi baru
    var host = "api.themoviedb.org";
    var path = "/3/movie/$movieID/credits";
    var params = {
      "api_key": "$apiKey",
    };

    var url = Uri.https(host, path, params);

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    // ambil nama cast dari API json, list of map
    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
              name: (e as Map<String, dynamic>)['name'],
              profilePath: (e as Map<String, dynamic>)['profile_path'],
            ))
        .take(8)
        .toList();
  }
}
