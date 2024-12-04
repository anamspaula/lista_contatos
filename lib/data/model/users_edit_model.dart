class UsersEdit {
  final String? name;
  final String? email;
  final String? telefone;

  UsersEdit({
    required this.name,
    required this.email,
    required this.telefone,
  });

  factory UsersEdit.fromMap(Map<String, dynamic> map){
    return UsersEdit(
      name: map['name'],
      email: map['email'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "telefone": telefone,
    };
  }
}
