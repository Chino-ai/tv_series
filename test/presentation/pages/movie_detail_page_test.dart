import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/cubit_movie/movies_detail_cubit.dart';
import 'package:ditonton/presentation/cubit_movie/movies_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MoviesDetailCubit])
void main() {
  late MockMovieDetailRecommendationsCubit
      mockMovieDetailRecommendationsCubit;

  setUp(() {
    mockMovieDetailRecommendationsCubit =
        MockMovieDetailRecommendationsCubit();
  });

  Widget _makeTestableWidgetDetailRecommendations() {
    return BlocProvider<MoviesRecommendationCubit>.value(
      value: mockMovieDetailRecommendationsCubit,
      child: MaterialApp(
        home: MovieRecom(),
      ),
    );
  }

    testWidgets('tv recommendation Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = MoviesRecommendationLoading();

      when(mockMovieDetailRecommendationsCubit.state).thenReturn(expected);
      when(mockMovieDetailRecommendationsCubit.stream)
          .thenAnswer((_) => Stream.value(expected));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

  testWidgets('tv recommendation Page should display center progress bar when error',
          (WidgetTester tester) async {
        final expected = MoviesRecommendationError("Failed");

        when(mockMovieDetailRecommendationsCubit.state).thenReturn(expected);
        when(mockMovieDetailRecommendationsCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

        expect(text, findsWidgets);

      });

  testWidgets('tv recommendation Page should display center progress bar when loaded',
          (WidgetTester tester) async {
        final expected = MoviesRecommendationHasData(<Movie>[]);

        when(mockMovieDetailRecommendationsCubit.state).thenReturn(expected);
        when(mockMovieDetailRecommendationsCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final listView = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

        expect(listView, findsOneWidget);

      });
}
