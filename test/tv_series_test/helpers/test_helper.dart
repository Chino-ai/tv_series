
import 'package:ditonton/data/datasources/db/tv/database_helper.dart';
import 'package:ditonton/data/datasources/db/tv/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/db/tv/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
