import 'package:flutter/material.dart';
import 'package:newsapp/views/Home.dart';
import 'package:provider/provider.dart';

import 'helper/data.dart';
import 'helper/news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => data()),
        ChangeNotifierProvider(
          create: (context) => news(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: Home()),
    );
  }
}
