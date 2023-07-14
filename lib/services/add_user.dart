import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, email, contactNumber, address) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'address': address,
    'id': docUser.id,
    'role': 'User'
  };

  await docUser.set(json);
}
