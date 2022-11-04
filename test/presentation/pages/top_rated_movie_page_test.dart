import 'package:ditonton/presentation/cubit_movie/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;

  setUp(() {
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockTopRatedMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = TopRatedMoviesLoading();

    when(mockTopRatedMovieCubit.state).thenReturn(expected);
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(expected));

    final progressBar = find.byType(CircularProgressIndicator);
    final center = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(center, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when error',
          (WidgetTester tester) async {
        final expected = TopRatedMoviesError("Failed");

        when(mockTopRatedMovieCubit.state).thenReturn(expected);
        when(mockTopRatedMovieCubit.stream)
            .thenAnswer((_) => Stream.value(expected));

        final progressBar = find.byType(Text);
        final center = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(center, findsWidgets);
        expect(progressBar, findsWidgets);
      });

  testWidgets('Page should display center progress bar when loaded',
          (WidgetTester tester) async {
        final expected = TopRatedMoviesHasData(testMovieList);

        when(mockTopRatedMovieCubit.state).thenReturn(expected);
        when(mockTopRatedMovieCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final listView = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));


        expect(listView, findsWidgets);
      });
}
