import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/my_party.dart';

class MyPartyDetailsPage extends StatefulWidget {
  final MyParty party;

  const MyPartyDetailsPage({super.key, required this.party});

  @override
  _MyPartyDetailsPageState createState() => _MyPartyDetailsPageState();
}

class _MyPartyDetailsPageState extends State<MyPartyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String qrData = jsonEncode({'partyId': widget.party.id});

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.party.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nome: ${widget.party.name}'),
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SelectableText(widget.party.id),
          ],
        ),
      ),
    );
  }
}