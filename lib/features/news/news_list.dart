import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/news/bloc/news/news_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
// import 'package:intl/intl.dart';
import 'package:serophero/utils/datetime_utils.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final NewsBloc newslistbloc = NewsBloc();

  @override
  void initState() {
    newslistbloc.add(NewsPageOPened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newslistbloc.add(NewsPageOPened());

    return BlocBuilder<NewsBloc, NewsState>(
      bloc: newslistbloc,
      builder: (BuildContext context, NewsState state) {
        if (state is TokenExpired) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Token is expired'),
                duration: Duration(seconds: 1),
              ),
            );
          });
        } else if (state is NewsListFailure) {
          if (mounted) {
            // Show SnackBar using ScaffoldMessenger outside the build method

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            });
          }
        } else if (state is NewsListSuccess) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Column(
                    children: state.newslist.map((news) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  GeneratedRoute().onGeneratedRoute(
                                    RouteSettings(
                                        arguments: {'news': news},
                                        name: '/view_news'),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Container for the image
                                Container(
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Image.network(
                                      "${AppUrls.baseUrl}/${news.newsImage}"),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // News title text
                                      Text(
                                        news.newsTitle,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),

                                      // Description text for events
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.45,
                                        child: Text(
                                          news.newsDescription,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            DateTimeUtils.formatRelativeTime(
                                                news.newsDate),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
