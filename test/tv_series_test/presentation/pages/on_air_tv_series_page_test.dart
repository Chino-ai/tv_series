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
  testWidgets('Page should display center progress bar when loading',
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
}
