import 'package:flutter/material.dart';
import 'package:newsapp/Model/article_model.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/views/Home.dart';

class category_news extends StatefulWidget {
  final String category;

  const category_news({Key? key, required this.category}) : super(key: key);

  @override
  _category_newsState createState() => _category_newsState();
}

class _category_newsState extends State<category_news> {
  List<article_model> articles = [];
  bool loading = true;
  Categorynews newsobj = Categorynews();
  getnewss() async {
    await newsobj.fetchNews(widget.category) ?? [];
    articles = newsobj.getNews;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getnewss();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : Container(
              padding: EdgeInsets.all(16),
              width: deviceWidth,
              height: deviceHeight,
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) => BlogTile(
                            title: articles[index].title ?? '',
                            imageUrl: articles[index].urlToImage ?? '',
                            description: articles[index].description ?? '',
                            url: articles[index].url ?? '',
                          )),
                ),
              ]),
            ),
    );
  }
}
