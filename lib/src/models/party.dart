import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festa_conectada/src/enums/party_status.dart';
import 'package:festa_conectada/src/models/my_party.dart';

class Party {
  final String id;
  MyParty party;
  PartyStatus status;
  DateTime entryInto;

  Party({
    required this.id,
    required this.party,
    required this.status,
    required this.entryInto,
  });

  Map<String, dynamic> toMap() {
    return {
      'party': party.toMap(),
      'status': status.index,
      'entry_into': entryInto,
    };
  }

  factory Party.fromMap(Map<String, dynamic> map, String id) {
    return Party(
      id: id,
      party: MyParty.fromMap(map['party'], id),
      status: PartyStatus.values[map['status']],
      entryInto: (map['entry_into'] as Timestamp).toDate(),
    );
  }
}