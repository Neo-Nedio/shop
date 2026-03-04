import 'package:flutter/material.dart';
import 'package:shop/pages/Login/Login.dart';
import 'package:shop/pages/Main/Main.dart';

Widget getRootWidget()
{
  return MaterialApp(
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes()
{
  return {
    "/": (context) => MainPage(),
    "/login" : (context) => LoginPage()
  };
}