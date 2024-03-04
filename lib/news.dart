import 'dart:convert';

import 'package:flutternewsapp_withapi/models/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String uri =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=64b7496844ea48ae86a7d7548be8d502';

    var response = await http.Client().get(Uri.parse(uri));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element['author'],
              content: element['content'],
              description: element['description'],
              title: element['title'],
              url: element['url'],
              urlToImage: element['urlToImage']);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String uri =
        'https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=64b7496844ea48ae86a7d7548be8d502';

    var response = await http.Client().get(Uri.parse(uri));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element['author'],
              content: element['content'],
              description: element['description'],
              title: element['title'],
              url: element['url'],
              urlToImage: element['urlToImage']);

          news.add(articleModel);
        }
      });
    }
  }
}
