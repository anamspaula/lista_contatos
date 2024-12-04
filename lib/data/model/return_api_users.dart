import 'package:myapp/data/model/users_model.dart';

class ReturnApiUsers<Response>{
    int code;
    String message;
    Response? response;

    // Construtor com parâmetros
    ReturnApiUsers({
      required this.code, required this.message, required this.response
    });

    ReturnApiUsers.obj( dynamic response)
      : code = response['code'],
        response = (response['response'] as List).map<Users>((item) => Users.fromMap(item)).toList() as Response,
        message = response['message'];

    
    ReturnApiUsers.objEdit( dynamic response)
      : code = response['code'],
        response = Users.fromMap(response['response']) as Response,
        message = response['message'];

    ReturnApiUsers.objDeleted( dynamic response)
      : code = response['code'],
        response = Null as Response,
        message = response['message'];

    factory ReturnApiUsers.fromMap(Map<String, dynamic> map){
      var list = map['response'] as List;
      List<Users> usersList = list.map<Users>((item) => Users.fromMap(item)).toList();
      return ReturnApiUsers(
        code: map['code'],
        message: map['message'],
        response: usersList as Response
      );
    }
}
