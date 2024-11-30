class Users {
    final String id;
  final String name;
  final String email;
  final String telefone;
  final DateTime? createdAt; // Agora aceita nulo
  final DateTime? updatedAt; // Agora aceita nulo

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.telefone,
    required Object createdAt, // Aceita String, DateTime ou null
    Object? updatedAt, // Aceita String, DateTime ou null
  })  : createdAt = _convertToDateTime(createdAt),
        updatedAt = _convertToDateTime(updatedAt);

  // Método para converter valores em DateTime, considerando valores nulos
  static DateTime? _convertToDateTime(Object? value) {
    if (value == null) {
      return DateTime(2024); // Permite null como valor
    } else if (value is DateTime) {
      return value; // Já é DateTime
    } else if (value is String) {
      try {
        return DateTime.parse(value); // Tenta converter a String
      } catch (_) {
        throw ArgumentError('Invalid date format: $value');
      }
    } else {
      throw ArgumentError('Invalid type for date field: $value');
    }
  }


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
