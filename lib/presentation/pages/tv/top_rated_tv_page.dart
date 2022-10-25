import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        Provider.of<TopRatedTvSeriesNotifier>(context, listen: false)
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
            child: Consumer<TopRatedTvSeriesNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.tv[index];
                      return TvCard(tv);
                    },
                    itemCount: data.tv.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
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
