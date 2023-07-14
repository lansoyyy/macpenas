import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:macpenas/services/add_report.dart';
import 'package:macpenas/widgets/text_widget.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    }).catchError((error) {
      print('Error getting location: $error');
    });
    getMyData();
  }

  String myName = '';
  String myNumber = '';
  String myAddress = '';
  bool hasLoaded = false;

  getMyData() {
    FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        setState(() {
          myName = doc['name'];
          myNumber = doc['contactNumber'];
          myAddress = doc['address'];
          hasLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Reports')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return hasLoaded
        ? Container(
            color: Colors.white,
            width: 1025,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 75,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextBold(
                        text: 'Welcome to Macpenas!',
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: userData,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      dynamic data = snapshot.data;
                      return data['status'] != 'Pending'
                          ? GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: TextBold(
                                          text: 'Emergency Alert',
                                          fontSize: 18,
                                          color: Colors.black),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextRegular(
                                            text:
                                                'Please select the type of emergency: ',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              addReport(
                                                  myName,
                                                  myNumber,
                                                  myAddress,
                                                  lat,
                                                  long,
                                                  'Rape',
                                                  'Pending');
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Emergency Alert Sent! Wait for further response',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'RAPE',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              addReport(
                                                  myName,
                                                  myNumber,
                                                  myAddress,
                                                  lat,
                                                  long,
                                                  'Traffic Incident',
                                                  'Pending');
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Emergency Alert Sent! Wait for further response',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'TRAFFIC INCIDENT',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              addReport(
                                                  myName,
                                                  myNumber,
                                                  myAddress,
                                                  lat,
                                                  long,
                                                  'Robbery',
                                                  'Pending');
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Emergency Alert Sent! Wait for further response',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'ROBBERY',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              addReport(
                                                  myName,
                                                  myNumber,
                                                  myAddress,
                                                  lat,
                                                  long,
                                                  'Others',
                                                  'Pending');
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Emergency Alert Sent! Wait for further response',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'OTHERS',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'CANCEL',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 125,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.campaign_rounded,
                                  color: Colors.white,
                                  size: 68,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Cancel Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to cancel your report?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Reports')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .update({
                                                  'status': 'Cancelled'
                                                }).then((value) {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: Container(
                                height: 125,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 68,
                                ),
                              ),
                            );
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextRegular(
                  text: 'Press the Red Button to trigger Report',
                  fontSize: 18,
                  color: Colors.red,
                ),
              ],
            ),
          )
        : const SizedBox(
            width: 1025,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
