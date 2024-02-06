class Guest {
  String userId;
  String name;

  Guest({
    required this.userId,
    required this.name,
  });

  // Método para converter para um mapa
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
    };
  }

  // Método para criar um convidado a partir de um mapa
  factory Guest.fromMap(Map<String, dynamic> map) {
    return Guest(
      userId: map['userId'],
      name: map['name'],
    );
  }
}
