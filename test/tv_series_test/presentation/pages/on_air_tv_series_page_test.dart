import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tv/on_air_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'on_air_tv_series_page_test.mocks.dart';

@GenerateMocks([OnAirTvSeriesCubit])
void main() {
  late MockOnAirTvSeriesCubit mockOnAirTvSeriesCubit;

  setUp(() {
    mockOnAirTvSeriesCubit = MockOnAirTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvSeriesCubit>.value(
      value: mockOnAirTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  testWidgets('On Air Tv Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = OnAirTvSeriesLoading();
    when(mockOnAirTvSeriesCubit.state).thenReturn(expected);
    when(mockOnAirTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(expected));
    final progressBar = find.byType(CircularProgressIndicator);
    final center = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(OnAirTvSeriesPage()));
    expect(center, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('On Air Tv Page should display center progress bar when error',
          (WidgetTester tester) async {
        final expected = OnAirTvSeriesError("Failed");
        when(mockOnAirTvSeriesCubit.state).thenReturn(expected);
        when(mockOnAirTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));
        final text = find.byType(Text);
        final center = find.byType(Center);
        await tester.pumpWidget(_makeTestableWidget(OnAirTvSeriesPage()));
        expect(center, findsWidgets);
        expect(text, findsWidgets);
      });

  testWidgets('On Air Tv Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        final expected = OnAirTvSeriesHasData(<TvSeries>[]);
        when(mockOnAirTvSeriesCubit.state).thenReturn(expected);
        when(mockOnAirTvSeriesCubit.stream)
            .thenAnswer((_) => Stream.value(expected));

        final listView = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(OnAirTvSeriesPage()));
        expect(listView, findsOneWidget);

      });
}
