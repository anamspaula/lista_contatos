import 'package:flutter/material.dart';
import 'package:myapp/data/model/return_api_users.dart';
import 'package:myapp/data/model/users_edit_model.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/repository/users_repository.dart';

class UsersStrore {
  final IUsersRepository repository;

  //loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //state
  final ValueNotifier<List<Users>?> state= ValueNotifier([
        Users(id: "id", name: "name", email: "email", telefone: "telefone", createdAt: DateTime(2024))
      ]);
  //error
  final ValueNotifier<String> error = ValueNotifier<String>("");

  UsersStrore({required this.repository});

  Future getUsers() async {
    isLoading.value = true;

    try{
      final result = await repository.getUsers();
      state.value = result;
    } on NotFoundException catch(err){
      // throw Exception(err);
      error.value = err.message;
    } catch(err) {
      // throw Exception(err);
      error.value = err.toString();
    }

    isLoading.value = false;
  }

  Future save({required UsersEdit user}) async {
    try{
      ReturnApiUsers<Users> userCreated = await repository.save(user: user);

      final result = await repository.getUsers();
      state.value = result;

      return userCreated;
    } on NotFoundException catch(err){
      throw Exception(err);
      // error.value = err.message;
    } catch(err) {
      // throw Exception(err);
      error.value = err.toString();
    }
  }
  
  Future editUsers({required String id, required UsersEdit user, required ValueChanged<bool> onEditSuccess}) async {
    try{
      ReturnApiUsers<Users> userCreated = await repository.edit(id: id, user: user);

      onEditSuccess(true);

      final result = await repository.getUsers();
      state.value = result;

      return userCreated;
    } on NotFoundException catch(err){
      throw Exception(err);
      // error.value = err.message;
    } catch(err) {
      // throw Exception(err);
      error.value = err.toString();
    }
  }

  Future deleteUsers({required String id}) async {
    try{
      ReturnApiUsers<Null> userCreated = await repository.delete(id: id);

      // final result = await repository.getUsers();
      // state.value = result;

      return userCreated;
    } on NotFoundException catch(err){
      throw Exception(err);
      // error.value = err.message;
    } catch(err) {
      // throw Exception(err);
      error.value = err.toString();
    }
  }
}