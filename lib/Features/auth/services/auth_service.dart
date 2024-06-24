import 'dart:convert';
import 'package:ecommerce_demo/Constants/error_handeling.dart';
import 'package:ecommerce_demo/Constants/global_variables.dart';
import 'package:ecommerce_demo/Constants/utils.dart';
import 'package:ecommerce_demo/Features/Home/screens/home_screen.dart';
import 'package:ecommerce_demo/models/user.dart';
import 'package:ecommerce_demo/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService{

  //sign up user
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  })async{
    
    try {
      
      User user =  User(
        id: '', 
        name: name, 
        email: email,
        password: password, 
        address: '', 
        type: '', 
        token: '', 
      ); 

      http.Response res=await http.post(
        Uri.parse('$uri/api/signup'),
        body:user.toJson(),
        headers: <String, String>{
          'content-type':'application/json; charset=UTF-8'
        }
      );
      
      httperrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          showSnackBar(context, "Account hase been created ");
        }
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }

  //sign in user
  void signInUser({
    required BuildContext context,
    
    required String email,
    required String password,
  })async{
    
    try {
      http.Response res=await http.post(
        Uri.parse('$uri/api/signin'),
        body:jsonEncode({
          'email':email,
          'password':password 
        }),
        headers: <String, String>{
          'content-type':'application/json; charset=UTF-8'
        }
      );
      
      httperrorHandle(
        response: res, 
        context: context, 
        onSuccess: ()async{
          
          SharedPreferences pref = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false ).setUser(res.body);
          pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context, 
            HomeScreen.routeName, 
            (route)=>false,
          );
        }
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //geting user data 
  void getUserData(BuildContext context)async{
    
    try {
      SharedPreferences pref=await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if(token == null){
         pref.setString('x-auth-token','');
      }

      var tokenRes=await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String,String>{
          'content-type':'application/json; charset=UTF-8',
          'x-auth-token': token!
        }
      );
      
      var response=jsonDecode(tokenRes.body);

      if(response ==true){
        http.Response userResponse=await http.get(
            Uri.parse("$uri/"),
            headers:  <String,String>{
          'content-type':'application/json; charset=UTF-8',
          'x-auth-token': token
        }
       );
       var userProvider=Provider.of<UserProvider>(context,listen: false);
       userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }

  //sign up user

}