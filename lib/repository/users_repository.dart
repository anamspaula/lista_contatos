import 'dart:convert';

import 'package:myapp/data/model/Users_Model.dart';
import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/https/https_client.dart';

abstract class IUsersRepository{
  Future<List<Users>> getUsers();
  Future<Users> getUser();
  // Future<ReturnApiUsers<Users>> create();
  // Future<ReturnApiUsers<Users>> edit();
  // Future<ReturnApiUsers<Users>> delete();
}

class UsersRepository implements IUsersRepository{
  final IHttpClient client;

  UsersRepository({required this.client});

  @override
  Future<List<Users>> getUsers() async {
    final response = await client.get(url: "localhost:8080");

    if(response.statusCode == 200){
      final List<Users> responseAPI = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final ReturnApiUsers<List<Users>> responseModel = ReturnApiUsers<List<Users>>.fromMap(item);
        responseAPI.addAll(responseModel.response);
      });

      return responseAPI;
    } else if(response.statusCode == 404){
      throw NotFoundException("Link inacessivel");
    }
    else {
      throw Exception("Erro inesperado");
    }
  }

  @override
  Future<Users> getUser() async {
    try{
      final response = await client.get(url: "localhost:8080");

      if(response.statusCode == 200){
        final List<Users> responseAPI = [];

        final body = jsonDecode(response.body);

        body.map((item) {
          final ReturnApiUsers<List<Users>> responseModel = ReturnApiUsers<List<Users>>.fromMap(item);
          responseAPI.addAll(responseModel.response);
        });

        return responseAPI.first;
      } else {
        return Users(id: "0", name: "", email: "", telefone: "", createdAt: DateTime(2024), updatedAt: DateTime(2024));
      }
    } catch (err){
     throw NotFoundException("Usuários não encontrados");
    } 
  }
  
}