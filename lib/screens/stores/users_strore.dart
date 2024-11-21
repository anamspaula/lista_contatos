import 'package:flutter/material.dart';
import 'package:myapp/https/exceptions.dart';
import 'package:myapp/repository/users_repository.dart';

class UsersStrore<ResponseAPI> {
  final IUsersRepository repository;

  //loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //state
  final ValueNotifier<ResponseAPI> state= ValueNotifier<ResponseAPI>([] as ResponseAPI);
  //error
  final ValueNotifier<String> error = ValueNotifier<String>("");

  UsersStrore({required this.repository});

  getUsers() async {
    isLoading.value = true;

    try{
      final result = await repository.getUsers();
      state.value = result as ResponseAPI;
    } on NotFoundException catch(err){
      error.value = err.message;
    } catch(err) {
      error.value = err.toString();
    }

    isLoading.value = false;
  }
}