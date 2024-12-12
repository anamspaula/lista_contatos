import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/data/model/users_edit_model.dart';

abstract class IHttpClient{
  Future get({required String url});
  Future save({required String url, required UsersEdit user});
  Future put({required String url, required UsersEdit user});
  Future delete({required String url});
}

class HttpsClient implements IHttpClient{
  final client = http.Client();

  @override
  Future get({required String url}) async{
    return await client.get(Uri.parse(url));
  }

  @override
  Future save({required String url, required UsersEdit user}) async {
    return await client.post(
      Uri.parse(url), 
      headers: {'Content-Type': 'application/json'}, // Definir o cabeçalho Content-Type
      body: json.encode(user.toJson()),
    );
  }

  @override
  Future put({required String url, required UsersEdit user}) async{
    return await client.put(
      Uri.parse(url), 
      headers: {'Content-Type': 'application/json'}, // Definir o cabeçalho Content-Type
      body: json.encode(user.toJson()),
    );
  }

  @override
  Future delete({required String url}) async{
    return await client.delete(
      Uri.parse(url), 
      headers: {'Content-Type': 'application/json'}, // Definir o cabeçalho Content-Type
    );
  }
}