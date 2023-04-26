import 'dart:convert';


import 'package:http/http.dart' as http;

import '../auth/auth_service.dart';
import 'Get.dart';

class response {
  String? jsonrpc;

  int? result;

  response({this.jsonrpc, this.result});

  response.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['jsonrpc'] = jsonrpc;   
    data['result'] = result;
    return data;
  }
}

Future<int> initCollection(int? tourneeID,int? sourceID,int? centreID)async{
  Map<String,dynamic> data = new Map<String, dynamic>();
  print("tourneeID :${tourneeID}  unite_id:${sourceID} centre_id:${centreID}");
      data["tournee_id"] = tourneeID;
			data["product_id"] = 44;
			data["unite_id"] = sourceID;
			data["centre_id"] = centreID;
    return createCollection(data);
			
}
Future<int> createCollection(Map<String,dynamic> data) async{
  Map<String,dynamic> params =  new Map<String, dynamic>();
  Map<String,dynamic> request =  new Map<String, dynamic>();
  params["data"]  = data;
  request["params"] = params;
  print("hooola ${jsonEncode(request)}");
  final sessionId = await getAuthToken();

   String searchUrl =
      "$api/api/milk.collection";

  final response = await http.post(
    Uri.parse(searchUrl),
    headers: {'Cookie': sessionId,'Content-Type' : 'application/json'},
    body: jsonEncode(request),
  );
  final res = jsonDecode(response.body);
  print(response.body);
  final test = res['error'];
  if  (response.statusCode != 200 || test != null)
  {
    return 0;
  }
  return res["result"];
}
Future<int> initLine(int? bacID,String quantity,int? collectionID)async{
  Map<String,dynamic> data = new Map<String, dynamic>();
  
      data["bac_alait"] = bacID;
			data["quantity"] = quantity;
			data["milk_collection_id"] = collectionID;
    return createLine(data);
			
}
Future<int> createLine(Map<String,dynamic> data) async{
  Map<String,dynamic> params =  new Map<String, dynamic>();
  Map<String,dynamic> request =  new Map<String, dynamic>();
  params["data"]  = data;
  request["params"] = params;

  final sessionId = await getAuthToken();

   String searchUrl =
      "$api/api/collection.line";

  final response = await http.post(
    Uri.parse(searchUrl),
    headers: {'Cookie': sessionId,'Content-Type' : 'application/json'},
    body: jsonEncode(request),
  );
  final res = jsonDecode(response.body);
  print(response.body);
  final test = res['error'];
  if  (response.statusCode != 200 || test != null)
  {
    return 0;
  }
  return res["result"];
}