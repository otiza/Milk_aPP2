import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_collection/api/Get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loGout(dynamic context) async {
  deleteLoginCred();
  Navigator.of(context).pushReplacementNamed('/login');
}

Future<void> storeAuthCred(String user, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', user);
  prefs.setString('pass', password);
}

Future<void> storeCookieToken(String coockie) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('session_id', coockie);
}

Future<void> deleteLoginCred() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
  prefs.remove('pass');
  prefs.remove('session_id');
}

Future<String> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('session_id') ?? '';
}

Future<bool> authenticateUser(String email, String password) async {
  const loginUrl = '$api/auth/';
  try{
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'params': {'login': email, 'password': password, 'db': 'testdb'}
      }),
    );

    if (response.statusCode == 200) {
      // save cookies for subsequent requests
      Map<String, dynamic> res = jsonDecode(response.body);

      String? cookies = response.headers['set-cookie'];
      final test = res['error'];

      if (test != null) {
        return false;
      } else {
        storeAuthCred(email, password);
        storeCookieToken(cookies!);
        return true;
      }
    } else {
      throw Exception('Failed to authenticate user');
    }
  }catch(exept){
    throw HttpException("Error while connecting to server");
  }
}

String extractSessionId(String cookieString) {
  List<String> cookieParts = cookieString.split('; ');
  for (String part in cookieParts) {
    if (part.startsWith('session_id=')) {
      return part.substring('session_id='.length);
    }
  }
  return '';
}

Future<bool> checkSession(String email, String password) async {
  const loginUrl = '$api/auth/';
  try{
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'params': {'login': email, 'password': password, 'db': 'testdb'}
        }),
      );

      if (response.statusCode == 200) {
        // save cookies for subsequent requests
        Map<String, dynamic> res = jsonDecode(response.body);

        String? cookies = response.headers['set-cookie'];
        final test = res['error'];

        if (test != null) {
          deleteLoginCred();
          return false;
        } else {
          storeCookieToken(cookies!);
          return true;
        }
      } else {
        throw Exception('Failed to authenticate user');
      }
  }
  catch(error){
    throw HttpException("Error while connecting to server");
  }
}
