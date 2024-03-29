import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RegisterService {
  String hostname = "http://erie.curos.in";


   Future<List> getData() async {
    String url = hostname + "/api/feedback";
    http.Response res = await http.get(url); // get api call
    List data = json.decode(res.body);
    return data;
  }
   Future<bool> userExist(id) async {
    String url = hostname + "/api/users/exists?id=$id";
    http.Response res = await http.get(url); // get api call
    Map data = json.decode(res.body);

    return data['exists'];
  }

  Future<Map> postData(Map datavalue) async {
    String url = hostname + "/api/users/register";
    try {
      http.Response res =
          await http.post(url, body: datavalue); // post api call
      print(res.body);
      Map data = json.decode(res.body);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<Map> submitResponse(feedbackId, dataValue) async {
    String url = hostname + '/api/feedback/$feedbackId/responses/submit';
    try {
      http.Response res = await http.post(url, body: dataValue, headers: {'Content-Type': 'application/json'}); 
      print(res.body);
      Map data = json.decode(res.body);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
