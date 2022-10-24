// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/tv_Series_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv/tv_series.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_on_air_tv_series.dart' as _i4;
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart' as _i8;
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTvSeriesRepository extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetOnAirTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOnAirTvSeries extends _i1.Mock
    implements _i4.GetOnAirTvSeries {
  MockGetOnAirTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetPopularTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvSeries extends _i1.Mock implements _i8.GetPopularTvSeries{
  MockGetPopularTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetTopRatedTvSeriess].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvSeries extends _i1.Mock implements _i9.GetTopRatedTvSeries {
  MockGetTopRatedTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}
