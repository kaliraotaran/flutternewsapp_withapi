import 'package:flutter/material.dart';
import 'package:flutternewsapp_withapi/models/article.dart';
import 'package:flutternewsapp_withapi/news.dart';
import 'package:flutternewsapp_withapi/views/article_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = List<ArticleModel>.empty(growable: true);
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ezy'),
              Text(
                'News',
                style: TextStyle(
                    color: Colors.indigo[300], fontWeight: FontWeight.w700),
              )
            ],
          ),
          actions: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          ],
          elevation: 0.0,
          centerTitle: true,
        ),
        body: _loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: articles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                url: articles[index].url!,
                                imageUrl: articles[index].urlToImage!,
                                title: articles[index].title!,
                                desc: articles[index].description!,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.url,
      required this.desc});
  final String imageUrl, title, desc, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ArticleView(blogurl: url)));
        launchUrl(Uri.parse(url));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16, left: 10, right: 10),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(imageUrl)),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
            ],
          )),
    );
  }
}
