import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../cubit_tv_series/top_rated_tv_series_cubit.dart';
import '../../widgets/tv_card_list.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top_rated_tv';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvSeriesCubit>()
            .fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Top Rated Tv'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
              builder: (context, data) {
                if (data is TopRatedTvSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is TopRatedTvSeriesHasData) {
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
    );
  }
}
