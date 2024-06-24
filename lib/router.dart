import 'package:ecommerce_demo/Features/Home/screens/home_screen.dart';
import 'package:ecommerce_demo/Features/auth/screens/auth_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesSettings){
  switch(routesSettings.name){
    case AuthScreen.routeName:
    return MaterialPageRoute(
      settings: routesSettings,
      builder: (_)=> const AuthScreen()
    );

    case HomeScreen.routeName:
    return MaterialPageRoute(
      settings: routesSettings,
      builder: (_)=> const HomeScreen()
    );

    default:
      
    return MaterialPageRoute(
      settings: routesSettings,
      builder: (_)=> const Scaffold(
        body: Center(
          child: Text('Screen does not exist'),
        ),
      )
    );

  }
}