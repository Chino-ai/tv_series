import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/cubit_tv_series/top_rated_tv_series_cubit.dart';
import 'top_rated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesCubit])
void main() {
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesCubit>.value(
      value: mockTopRatedTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  testWidgets('top rated Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = TopRatedTvSeriesLoading();
    when(mockTopRatedTvSeriesCubit.state).thenReturn(expected);
    when(mockTopRatedTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(expected));
    final progressBar = find.byType(CircularProgressIndicator);
    final center = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(center, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('top rated Page should display text with message when Error',
          (WidgetTester tester) async {
        final expected = TopRatedTvSeriesError("Failed");
        when(mockTopRatedTvSeriesCubit.state).thenReturn(expected);
        when(mockTopRatedTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));
        final center = find.byType(Center);
        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

        expect(center, findsWidgets);
        expect(text, findsWidgets);
      });

  testWidgets('top rated Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        final expected = TopRatedTvSeriesHasData(<TvSeries>[]);
        when(mockTopRatedTvSeriesCubit.state).thenReturn(expected);
        when(mockTopRatedTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));

        final listView = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

        expect(listView, findsWidgets);
      });


}


