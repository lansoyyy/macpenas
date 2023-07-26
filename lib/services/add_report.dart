import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReport(name, contactNumber, address, lat, long, type, status,
    String reporterType) async {
  final docUser = FirebaseFirestore.instance
      .collection('Reports')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'contactNumber': contactNumber,
    'address': address,
    'id': docUser.id,
    'status': status,
    'lat': lat,
    'long': long,
    'dateTime': DateTime.now(),
    'type': type,
    'reporterType': reporterType,
  };

  await docUser.set(json);
}
