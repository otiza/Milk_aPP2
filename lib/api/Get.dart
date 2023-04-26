import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:milk_collection/api/Post.dart';
import 'package:milk_collection/auth/auth_service.dart';
import 'package:milk_collection/models/data_models.dart';
import 'package:milk_collection/pages/tournee_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String api = "http://10.10.10.165:8069";
Future<bool> findTournee(dynamic context, String number) async {
  //final prefs = await SharedPreferences.getInstance();
  final sessionId = await getAuthToken();
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  String searchUrl =
      "$api/api/milk.tournee/?filter=[[\"number\",\"=\",$number]]";
  try{
    final response = await http.get(
      Uri.parse(searchUrl),
      headers: {'Cookie': sessionId},
    ).catchError((error) {
      throw("error");
    });
    Map<String, dynamic> res = jsonDecode(response.body);
    if (res["count"] != 0) {

      int id = res["result"][0]["id"];
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TourneeInfo(id: id, number: number,)),
      );
    }
    else {
      return false;}
      
    return true;}
    catch(error){
      throw const HttpException("Error while connecting to server");
    }
}

Future<Tournee> getTourneeId(dynamic id) async{
  final sessionId = await getAuthToken();
  String searchUrl =
      "$api/api/milk.tournee/$id/?query={id,number,chauffeur_id{name},agent_id{name},camion_id{license},trajet_ids{id,name,latitude,longitude,producer_id{name,phone},bacalait_ids{id,reference,capacite}}}";
  try{  
    final response = await http.get(
      Uri.parse(searchUrl),
      headers: {'Cookie': sessionId},
    );
    Tournee ret = Tournee.fromJson(jsonDecode(response.body));
    
    return ret;}
    catch(error){
      throw const HttpException("Error while connecting to server");
    }
}

Future<List<Result>?> getDestinations() async{
  final sessionId = await getAuthToken();
  String searchUrl = "$api/api/collect.center/";
  try {
    final resposne = await http.get(
      Uri.parse(searchUrl),
      headers: {'Cookie': sessionId},
    );


    Resposne res = Resposne.fromJson(jsonDecode(resposne.body));
    
    return res.result;}
    catch(error){
      throw ("Error while connecting to server");
    }
}

Future<List <Baclait>?> getBacAlait(int? centreId) async{
  final sessionId = await getAuthToken();
  String searchUrl = "$api/api/bac.lait/?filter=[[\"unite_production_id\",\"=\",$centreId]]&query={reference,id}";
  try {
    final response = await http.get(
      Uri.parse(searchUrl),
      headers: {'Cookie': sessionId}
    );

    BacLaitResponse ret = BacLaitResponse.fromJson(jsonDecode(response.body));
    return ret.result;
  }
  catch(error){
    throw ("error while connection to server");
  
  }

}