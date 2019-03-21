import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RegisterService {
   Future<List> getData() async {
    String url = "http://e9d0a8e9.ngrok.io/api/feedback";
    http.Response res = await http.get(url); // get api call
    List data = json.decode(res.body);
    return data;
  }

  Future<Map> postData(Map datavalue) async {
    String url = "http://e9d0a8e9.ngrok.io/api/users/register";
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
}
