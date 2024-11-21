class ReturnApiUsers<Response> {
    int code;
    String message;
    Response response;

    // Construtor com parâmetros
    ReturnApiUsers({
      required this.code, required this.message, required this.response
    });

    factory ReturnApiUsers.fromMap(Map<String, dynamic> map){
      return ReturnApiUsers(
        code: map['code'],
        message: map['message'],
        response: map['response']
      );
    }
}
