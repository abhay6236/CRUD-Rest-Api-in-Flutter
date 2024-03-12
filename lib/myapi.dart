import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApi {
  Future<List> getDetails() async {
    var res = await http.get(Uri.parse(
        "https://650c2e4247af3fd22f67397e.mockapi.io/StudentDetails"));
    return jsonDecode(res.body);
  }

  Future<List> getDetailsById(String id) async {
    var res = await http.get(Uri.parse(
        "https://650c2e4247af3fd22f67397e.mockapi.io/StudentDetails/" + id));
    return jsonDecode(res.body);
  }

  Future<void> deleteDetails(String id) async {
    var res = await http.delete(Uri.parse(
        "https://650c2e4247af3fd22f67397e.mockapi.io/StudentDetails/" + id));
  }

  Future<void> insertDetails(Map<String, dynamic> map) async {
    var res = await http.post(
        Uri.parse("https://650c2e4247af3fd22f67397e.mockapi.io/StudentDetails"),
        body: map);
  }


  Future<void> updateDetails(Map<String,dynamic> map,id) async {
    var res=await http.put(Uri.parse("https://650c2e4247af3fd22f67397e.mockapi.io/StudentDetails/"+id),
        body: jsonEncode(map),
        headers: <String,String>{
          'Content-Type':'application/json',
        });
  }
}
