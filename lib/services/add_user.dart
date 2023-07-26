import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:macpenas/services/add_report.dart';

Future addUser(name, email, contactNumber, address, imageId, idType) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'address': address,
    'id': docUser.id,
    'role': 'user',
    'imageId': imageId,
    'isVerified': false,
    'idType': idType
  };

  addReport(name, contactNumber, address, 0, 0, 'Others', 'No', 'Witness');

  await docUser.set(json);
}
