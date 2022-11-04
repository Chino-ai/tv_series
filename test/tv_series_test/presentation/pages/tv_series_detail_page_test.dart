import 'package:ditonton/presentation/cubit_tv_series/tv_series_recommendation_cubit.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvRecommendationCubit])
void main() {
  late MockTvSeriesDetailRecommendationsCubit
      mockTvSeriesDetailRecommendationsCubit;

  setUp(() {
    mockTvSeriesDetailRecommendationsCubit =
        MockTvSeriesDetailRecommendationsCubit();
  });

  Widget _makeTestableWidgetDetailRecommendations() {
    return BlocProvider<TvRecommendationCubit>.value(
      value: mockTvSeriesDetailRecommendationsCubit,
      child: MaterialApp(
        home: TvRecom(),
      ),
    );
  }

    testWidgets('tv recommendation Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = TvRecommendationLoading();

      when(mockTvSeriesDetailRecommendationsCubit.state).thenReturn(expected);
      when(mockTvSeriesDetailRecommendationsCubit.stream)
          .thenAnswer((_) => Stream.value(expected));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    });

  testWidgets('tv recommendation Page should display center progress bar when error',
          (WidgetTester tester) async {
        final expected = TvRecommendationError("Failed");

        when(mockTvSeriesDetailRecommendationsCubit.state).thenReturn(expected);
        when(mockTvSeriesDetailRecommendationsCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

        expect(text, findsWidgets);

      });

  testWidgets('tv recommendation Page should display center progress bar when loaded',
          (WidgetTester tester) async {
        final expected = TvRecommendationHasData(<TvSeries>[]);

        when(mockTvSeriesDetailRecommendationsCubit.state).thenReturn(expected);
        when(mockTvSeriesDetailRecommendationsCubit.stream)
            .thenAnswer((_) => Stream.value(expected));


        final listView = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

        expect(listView, findsOneWidget);

      });
}
