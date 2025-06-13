import 'package:cloud_firestore/cloud_firestore.dart';

class UserDomain {
  String id;
  String email;
  String role;

  UserDomain({required this.id, required this.email, required this.role});

  UserDomain.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : id = documentSnapshot.id,
        email =
            (documentSnapshot.data() as Map<String, dynamic>)['email'] ?? '',
        role =
            (documentSnapshot.data() as Map<String, dynamic>)['role'];
}
