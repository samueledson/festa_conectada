import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festa_conectada/src/enums/my_party_status.dart';

class MyParty {
  final String id;
  String name;
  MyPartyStatus status;
  DateTime createdAt;

  MyParty({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status.index,
      'created_at': createdAt,
    };
  }

  // Método para criar uma festa a partir de um mapa
  factory MyParty.fromMap(Map<String, dynamic> map, String id) {
    return MyParty(
      id: id,
      name: map['name'],
      status: MyPartyStatus.values[map['status']],
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }
}
