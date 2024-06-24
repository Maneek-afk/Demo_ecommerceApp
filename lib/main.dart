import 'package:ecommerce_demo/Constants/global_variables.dart';
import 'package:ecommerce_demo/Features/Home/screens/home_screen.dart';
import 'package:ecommerce_demo/Features/auth/screens/auth_screens.dart';
import 'package:ecommerce_demo/Features/auth/services/auth_service.dart';
import 'package:ecommerce_demo/provider/user_provider.dart';
import 'package:ecommerce_demo/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers:[ ChangeNotifierProvider(
      create: (context)=>UserProvider(), 
      ) 
    ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trailer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),

      onGenerateRoute: (settings)=> generateRoute(settings),

      home: Provider.of<UserProvider>(context).user.token.isNotEmpty 
      ? const HomeScreen()
      : const AuthScreen()
    );
  }
}

