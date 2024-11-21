class Users {
    final String id;
    final String name;
    final String email;
    final String telefone;
    final DateTime createdAt;
    final DateTime updatedAt;

    // Construtor com parâmetros
    Users({
      required this.id, required this.name, required this.email, required this.telefone, required this.createdAt, required this.updatedAt
    });

    factory Users.fromMap(Map<String, dynamic> map){
      return Users(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        telefone: map['telefone'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at']
      );
    }
}
