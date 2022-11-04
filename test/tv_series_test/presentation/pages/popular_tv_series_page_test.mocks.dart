// Mocks generated by Mockito 5.0.15 from annotations
// in tv/test/presentation/pages/popular_movie_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ditonton/presentation/cubit_tv_series/popular_tv_series_cubit.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakePopularTvSeriesState_0 extends _i1.Fake
    implements _i2.PopularTvSeriesState {}

/// A class which mocks [PopularTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTvSeriesCubit extends _i1.Mock
    implements _i2.PopularTvSeriesCubit {
  MockPopularTvSeriesCubit() {
    _i1.throwOnMissingStub(this);
  }
  @override
  _i2.PopularTvSeriesState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakePopularTvSeriesState_0()) as _i2.PopularTvSeriesState);
  @override
  _i3.Stream<_i2.PopularTvSeriesState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.PopularTvSeriesState>.empty())
          as _i3.Stream<_i2.PopularTvSeriesState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i3.Future<void> fetchPopularTv() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularTv, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  void emit(_i2.PopularTvSeriesState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i4.Change<_i2.PopularTvSeriesState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
