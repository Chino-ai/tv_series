import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/cubit_tv_series/on_air_tv_series_cubit.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/on_air_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/tv_card_list.dart';

class OnAirTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/air_tv';

  @override
  _OnAirTvSeriesPageState createState() => _OnAirTvSeriesPageState();
}

class _OnAirTvSeriesPageState extends State<OnAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>

    context.read<OnAirTvSeriesCubit>().fetchOnAirTv());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvSeriesCubit, OnAirTvSeriesState>(
          builder: (context, data) {
            if (data is  OnAirTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is OnAirTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.result[index];
                  return TvCard(tv);
                },
                itemCount: data.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
