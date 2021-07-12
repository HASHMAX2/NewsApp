import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/Model/Category_model.dart';
import 'package:newsapp/Model/article_model.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'article_view.dart';
import 'category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  data data1 = data();
  bool loading = true;
  List<article_model> articles = [];
  List<article_model> articles1 = [];
  news newsobj = news();

  getnewss() async {
    await newsobj.fetchNews() ?? [];
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
    final categoryList = Provider.of<data>(context);
    final blogtiledata = Provider.of<news>(context);

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
              padding: EdgeInsets.all(10),
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                children: [
                  Container(
                    //padding: EdgeInsets.only(top: 10),
                    height: 70,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.list.length,
                        itemBuilder: (ctx, i) => CategoryTile(
                              categoryName: categoryList.list[i].CategoryName,
                              imageUrl: categoryList.list[i].ImageUrl,
                            )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                ],
              )),
    );
  }
}

class CategoryTile extends StatelessWidget {
  var imageUrl;
  var categoryName;
  CategoryTile({@required this.imageUrl, @required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => category_news(
                    category: categoryName.toString().toLowerCase())));
      },
      child: Container(
        //color: Colors.amber,
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                categoryName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  BlogTile(
      {required this.title,
      required this.imageUrl,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => article_view(
                      blogUrl: url,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold), // title
            ),
            SizedBox(
              height: 6,
            ),
            Text(description, style: TextStyle(color: Colors.grey)),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
