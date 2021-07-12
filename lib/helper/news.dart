import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/article_model.dart';

class news with ChangeNotifier {
  List<article_model> _newsList = [];
  var jsondata;

  fetchNews() async {
    String Rawurl =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a951c6e994a34606baa96349857d88bd";
    var url = Uri.parse(Rawurl);
    var response = await http.get(url);
    jsondata = jsonDecode(response.body);

    if (jsondata['status'] == "ok") {
      jsondata['articles'].forEach((element) {
        article_model obj1 = article_model(
          author: element['author'],
          description: element['description'],
          title: element['title'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['content'],
        );
        _newsList.add(obj1);
      });
      // return _newsList;
    }
  }

  List<article_model> get getNews {
    return [..._newsList];
  }
}

class Categorynews with ChangeNotifier {
  List<article_model> _newsList = [];
  var jsondata;

  fetchNews(String category) async {
    String Rawurl =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=a951c6e994a34606baa96349857d88bd";
    var url = Uri.parse(Rawurl);
    var response = await http.get(url);
    jsondata = jsonDecode(response.body);

    if (jsondata['status'] == "ok") {
      jsondata['articles'].forEach((element) {
        article_model obj1 = article_model(
          author: element['author'],
          description: element['description'],
          title: element['title'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['content'],
        );
        _newsList.add(obj1);
      });
      // return _newsList;
    }
  }

  List<article_model> get getNews {
    return [..._newsList];
  }
}
