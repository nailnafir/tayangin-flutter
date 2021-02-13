part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    client ??= http.Client();

    var response = await client.get(url);

    // jika gagal
    if (response.statusCode != 200) {
      return [];
    }

    // jika berhasil
    var data = json.decode(response.body);
    List result = data['result'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }
}
