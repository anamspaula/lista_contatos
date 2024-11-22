import 'package:myapp/data/model/users_model.dart';

class ReturnApiUsers{
    int code;
    String message;
    List<Users> response;

    // Construtor com parâmetros
    ReturnApiUsers({
      required this.code, required this.message, required this.response
    });

    factory ReturnApiUsers.fromMap(Map<String, dynamic> map){
      var list = map['response'] as List;
      List<Users> usersList = list.map((item) => Users.fromMap(item)).toList();
      return ReturnApiUsers(
        code: map['code'],
        message: map['message'],
        response: usersList
      );
    }
}
