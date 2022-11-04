import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([OnAirTvSeriesCubit])
void main() {
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;

  setUp(() {
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesCubit>.value(
      value: mockPopularTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  testWidgets('Popular Tv Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = PopularTvSeriesLoading();
    when(mockPopularTvSeriesCubit.state).thenReturn(expected);
    when(mockPopularTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(expected));
    final progressBar = find.byType(CircularProgressIndicator);
    final center = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));
    expect(center, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('Popular Tv Page should display center progress bar when Error',
          (WidgetTester tester) async {
        final expected = PopularTvSeriesError("Failed");
        when(mockPopularTvSeriesCubit.state).thenReturn(expected);
        when(mockPopularTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));
        final text = find.byType(Text);
        final center = find.byType(Center);
        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));
        expect(center, findsWidgets);
        expect(text, findsWidgets);
      });
  testWidgets('Popular Tv Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        final expected = PopularTvSeriesHasData(<TvSeries>[]);
        when(mockPopularTvSeriesCubit.state).thenReturn(expected);
        when(mockPopularTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));

        final listView = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

        expect(listView, findsWidgets);
      });

}
