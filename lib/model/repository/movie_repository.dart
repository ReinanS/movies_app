import 'package:cubos_movies/model/movie_genre.dart';
import 'package:cubos_movies/model/movie.dart';
import 'package:cubos_movies/model/movie_detail.dart';
import 'package:cubos_movies/model/movie_response.dart';
import 'package:cubos_movies/model/services/base_service.dart';
import 'package:cubos_movies/model/services/genre_service.dart';
import 'package:cubos_movies/model/services/movie_by_genre_service.dart';
import 'package:cubos_movies/model/services/movie_detail_service.dart';
import 'package:cubos_movies/model/services/movie_service.dart';

class MovieRepository {
  MovieService _movieService = MovieService();
  MovieByGenreService _movieGenreService = MovieByGenreService();

  BaseService _genreService = GenreService();
  BaseService _movieDetailService = MovieDetailService();

  Future<MovieResponse> fetchAllMovies(int page) async {
    dynamic response = await _movieService.getAllMovies(page);
    MovieResponse movie = MovieResponse.fromJson(response);
    return movie;
  }

  Future<MovieResponse> fetchMoviesByGenre(int page, int genre) async {
    dynamic response = await _movieGenreService.getAllMovies(page, genre);
    MovieResponse movie = MovieResponse.fromJson(response);
    return movie;
  }

  Future<List<Movie>> fetchMovieListByGenre() async {
    dynamic response = await _movieService.getResponse("/movie/popular");
    List<Movie> movieList =
        List.from(response['results']).map((e) => Movie.fromJson(e)).toList();

    return movieList;
  }

  Future<List<MovieGenre>> fetchGenreList() async {
    dynamic response = await _genreService.getResponse("/genre/movie/list");
    final jsonData = response['genres'] as List;
    List<MovieGenre> movieGenreList =
        jsonData.map((e) => MovieGenre.fromJson(e)).toList();

    return movieGenreList;
  }

  Future<MovieDetail> fetchMovieDetails(int movieId) async {
    dynamic response = await _movieDetailService
        .getResponse("/movie" + '/' + movieId.toString());

    MovieDetail movieDetail = MovieDetail.fromJson(response);

    return movieDetail;
  }
}
