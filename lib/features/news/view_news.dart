import 'package:flutter/material.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/news/data/news_model.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/utils/datetime_utils.dart';
// import 'package:serophero/routes/generated_routes.dart';

class ViewNews extends StatelessWidget {
  final NewsListModel news;

  const ViewNews({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("News")),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(news.newsTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            //image
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "${AppUrls.baseUrl}/${news.newsImage}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //datetime
            Container(
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(right: 8.0),
              child: Text(
                'by ${news.username}, ${DateTimeUtils.formatRelativeTime(news.newsDate)}',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            //desc
            Expanded(
                child: Text(
              news.newsDescription,
              maxLines: 20,
            )),
            //report
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Noticed something wrong?",
                  // style: TextStyle(fontSize: 17)
                ),
                GestureDetector(
                  onTap: () {
                    print("inside news report page before");
                    print(news.id);
                    Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          RouteSettings(
                              arguments: {'id': news.id, 'type': 'news'},
                              name: '/report'),
                        ));
                  },
                  child: const Text("Report the news",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                )
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      )),
    );
  }
}
