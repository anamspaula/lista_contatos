import 'package:flutter/material.dart';
import 'package:myapp/data/model/users_model.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/repository/users_repository.dart';

class UsersStrore {
  final IUsersRepository repository;

  //loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //state
  final ValueNotifier<List<Users>> state= ValueNotifier([]);
  //error
  final ValueNotifier<String> error = ValueNotifier<String>("");

  UsersStrore({required this.repository});

  Future getUsers() async {
    isLoading.value = true;

    try{
      final result = await repository.getUsers();
      state.value = result;
    } on NotFoundException catch(err){
      error.value = err.message;
    } catch(err) {
      error.value = err.toString();
    }

    isLoading.value = false;
  }
}