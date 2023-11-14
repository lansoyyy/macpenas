import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReport(name, contactNumber, address, lat, long, type, status,
    String reporterType, brgy, img, bool trig) async {
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
    'day': DateTime.now().day,
    'month': DateTime.now().month,
    'brgy': brgy,
    'img': img,
    'trig': trig
  };

  await docUser.set(json);
}
