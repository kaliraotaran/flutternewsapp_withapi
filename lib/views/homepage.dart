import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp_withapi/data.dart';
import 'package:flutternewsapp_withapi/models/article.dart';
import 'package:flutternewsapp_withapi/models/category_model.dart';
import 'package:flutternewsapp_withapi/news.dart';
import 'package:flutternewsapp_withapi/views/article_view.dart';
import 'package:flutternewsapp_withapi/views/category_news.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List<CategoryModel> categories = <CategoryModel>[];
  List<CategoryModel> categories = List<CategoryModel>.empty(growable: true);
  List<ArticleModel> articles = List<ArticleModel>.empty(growable: true);

  // List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    categories = getCategory();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
            Text(
              'Ezy',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              'News',
              style: TextStyle(
                  color: Colors.indigo[300], fontWeight: FontWeight.w700),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              Categoryname: categories[index].categoryName,
                            );
                          }),
                    ),

                    //Blogs

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
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, this.imageUrl, required this.Categoryname});
  final imageUrl;
  final String Categoryname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                    category: Categoryname.toString().toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6).copyWith(left: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Center(
                child: Text(
                  Categoryname,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(),
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
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Divider())
            ],
          )),
    );
  }
}
