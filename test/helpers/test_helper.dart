import 'package:ditonton/data/datasources/db/movies/database_helper.dart';
import 'package:ditonton/data/datasources/db/movies/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/db/movies/movie_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
