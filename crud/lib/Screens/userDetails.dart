import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  String id;

  UserDetails({required this.id});

  CollectionReference ref = FirebaseFirestore.instance.doc(
      'students') as CollectionReference<Object?>;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(


    );
  }
}