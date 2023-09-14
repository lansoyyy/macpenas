import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:macpenas/services/add_report.dart';

Future addUser(name, email, contactNumber, address, id1Front, id1Back, id1Type,
    id2Front, id2Back, id2Type, refno, brgy) async {
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
    'isVerified': false,
    'id1Front': id1Front,
    'id1Back': id1Back,
    'id1Type': id1Type,
    'id2Front': id2Front,
    'id2Back': id2Back,
    'id2Type': id2Type,
    'refno': refno,
    'brgy': brgy
  };

  addReport(
      name, contactNumber, address, 0, 0, 'Others', 'No', 'Witness', brgy);

  await docUser.set(json);
}
