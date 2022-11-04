import 'package:ditonton/presentation/cubit_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_page_test.mocks.dart';

@GenerateMocks([PopularMoviesCubit])
void main() {
  late MockPopularMovieCubit mockPopularMovieCubit;

  setUp(() {
    mockPopularMovieCubit = MockPopularMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockPopularMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = PopularMoviesLoading();

    when(mockPopularMovieCubit.state).thenReturn(expected);
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_) => Stream.value(expected));

    final progressBar = find.byType(CircularProgressIndicator);
    final center = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(center, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when error',
          (WidgetTester tester) async {
        final expected = PopularMoviesError("Failed");

        when(mockPopularMovieCubit.state).thenReturn(expected);
        when(mockPopularMovieCubit.stream)
            .thenAnswer((_) => Stream.value(expected));

        final progressBar = find.byType(Text);
        final center = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(center, findsWidgets);
        expect(progressBar, findsWidgets);
      });

  testWidgets('Page should display center progress bar when loaded',
          (WidgetTester tester) async {
        final expected = PopularMoviesHasData(testMovieList);

        when(mockPopularMovieCubit.state).thenReturn(expected);
        when(mockPopularMovieCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final listView = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));


        expect(listView, findsWidgets);
      });
}
