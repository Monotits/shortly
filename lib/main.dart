import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortly/provider/url_provider.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UrlProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shortly',
        home: WelcomePage(),
      ),
    );
  }
}
