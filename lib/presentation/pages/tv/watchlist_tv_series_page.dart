import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../cubit_tv_series/watch_tv_series_cubit.dart';
import '../../provider/tv/watch_tv_series_notifier.dart';
import '../../widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_tv';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistTvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvSeriesCubit>()
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesCubit>()
        .fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
          builder: (context, data) {
            if (data is WatchlistTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is WatchlistTvSeriesHasData) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
