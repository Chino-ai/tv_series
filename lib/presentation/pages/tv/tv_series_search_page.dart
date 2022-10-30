import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit_tv_series/tv_series_search_cubit.dart';
import '../../widgets/tv_card_list.dart';

class TvSeriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search_tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<TvSeriesSearchCubit>()
                    .fetchTvSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSeriesSearchCubit, TvSeriesSearchState>(
              builder: (context, data) {
                if (data is TvSeriesSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is TvSeriesSearchHasData) {
                  final result = data.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = data.result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
