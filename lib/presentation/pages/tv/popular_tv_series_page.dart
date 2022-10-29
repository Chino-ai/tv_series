import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../cubit_tv_series/popular_tv_series_cubit.dart';
import '../../widgets/tv_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular_tv';

  @override
  _PopularTvSeriesPagePageState createState() => _PopularTvSeriesPagePageState();
}

class _PopularTvSeriesPagePageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTvSeriesCubit>().fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, data) {
            if (data is PopularTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is PopularTvSeriesHasData) {
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
