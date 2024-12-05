import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/data/model/users_edit_model.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/https/https_client.dart';

abstract class IUsersRepository{
  Future<List<Users>> getUsers();
  Future<ReturnApiUsers<Users>> save({required UsersEdit user});
  Future<ReturnApiUsers<Users>> edit({required String id, required UsersEdit user});
  Future<ReturnApiUsers<Null>> delete({required String id});
}

class UsersRepository implements IUsersRepository{
  final IHttpClient client;
  final logger = Logger();

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

  @override
  Future<ReturnApiUsers<Users>> save({required UsersEdit user}) async{
    final response = await client.save(url: "http://localhost:8080/usuario", user: user);

    if(response.statusCode == 200){
      final ReturnApiUsers<Users> body = ReturnApiUsers<Users>.objEdit(json.decode(response.body));
      logger.d(body);
      
      return body;
    } else if(response.statusCode == 404){
      throw NotFoundException("Link inacessivel");
    }
    else {
      throw Exception("Erro inesperado");
    }
  }

  @override
  Future<ReturnApiUsers<Users>> edit({required String id, required UsersEdit user}) async{
    final response = await client.put(url: "http://localhost:8080/usuario/$id", user: user);

    if(response.statusCode == 200){
      final ReturnApiUsers<Users> body = ReturnApiUsers<Users>.objEdit(json.decode(response.body));
      logger.d(body);
      
      return body;
    } else if(response.statusCode == 404){
      throw NotFoundException("Link inacessivel");
    }
    else {
      throw Exception("Erro inesperado");
    }
  }
  
  @override
  Future<ReturnApiUsers<Null>> delete({required String id}) async{
    final response = await client.delete(url: "http://localhost:8080/usuario/$id");

    if(response.statusCode == 200){
      final ReturnApiUsers<Null> body = ReturnApiUsers<Null>.objDeleted(json.decode(response.body));
      
      return body;
    } else if(response.statusCode == 404){
      throw NotFoundException("Link inacessivel");
    }
    else {
      throw Exception("Erro inesperado");
    }
  }
}