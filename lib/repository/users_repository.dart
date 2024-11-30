import 'dart:convert';

import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/https/https_client.dart';

abstract class IUsersRepository{
  Future<List<Users>> getUsers();
  // Future<ReturnApiUsers<Users>> create();
  // Future<ReturnApiUsers<Users>> edit();
  // Future<ReturnApiUsers<Users>> delete();
}

class UsersRepository implements IUsersRepository{
  final IHttpClient client;

  UsersRepository({required this.client});

  @override
  Future<List<Users>> getUsers() async {
    final response = await client.get(url: "http://localhost:8080/usuario");
    // _logger(response);

    if(response.statusCode == 200){
      final List<Users> responseAPI;

      // final ReturnApiUsers body = ReturnApiUsers.obj(JsonDecoder(response.body));
      final ReturnApiUsers body = ReturnApiUsers.obj(json.decode(response.body));

      responseAPI = body.response;

      return responseAPI;
    } else if(response.statusCode == 404){
      throw NotFoundException("Link inacessivel");
    }
    else {
      throw Exception("Erro inesperado");
    }
  }
}