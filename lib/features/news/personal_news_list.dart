import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/news/bloc/personal_news/personal_news_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/utils/datetime_utils.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';

class PersonalNews extends StatelessWidget {
  const PersonalNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Posted News"))),
      body: SafeArea(
        child: BlocBuilder<PersonalNewsBloc, PersonalNewsState>(
            builder: (context, state) {
          if (state is PersonalNewsListSuccess) {
            return Column(
              children: state.newslist.map((news) {
                return Column(
                  children: [
                    Dismissible(
                      key: ValueKey(news.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (value) {
                        context
                            .read<PersonalNewsBloc>()
                            .add(DeleteNews(id: news.id.toString()));
                      },
                      child: GestureDetector(
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
                            Container(
                              height: 120,
                              width: 120,
                              alignment: Alignment.center,
                              child: Image.network(
                                  "${AppUrls.baseUrl}/${news.newsImage}"),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width: MediaQuery.of(context).size.width /
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
                                      padding: const EdgeInsets.only(top: 8),
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        DateTimeUtils.formatRelativeTime(
                                            news.newsDate),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            );
          }
          if (state is PersonalNewsListLoading) {
            return const CircularProgressIndicator();
          }
          if (state is PersonalNewsListFailure) {
            return const Text("Failure");
          }
          context.read<PersonalNewsBloc>().add(PersonalNewsPageOpened());
          return CustomElevatedButton(
            text: "Retry",
            onPressed: () {
              context.read<PersonalNewsBloc>().add(PersonalNewsPageOpened());
            },
          );
        }),
      ),
    );
  }
}
