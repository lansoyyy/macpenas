import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    update();
  }

  String myName = '';
  String myNumber = '';
  String myAddress = '';
  String brgy = '';
  bool hasLoaded = false;
  bool isUploaded = false;
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
          brgy = doc['brgy'];
          hasLoaded = true;
        });
      }
    });
  }

  update() async {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      Geolocator.getCurrentPosition().then((position) async {
        lat = position.latitude;
        long = position.longitude;
        // });

        await FirebaseFirestore.instance
            .collection('Reports')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'lat': position.latitude,
          'long': position.longitude,
        });
      }).catchError((error) {
        print('Error getting location: $error');
      });
    });
  }

  String _selectedOption = '';

  String imgUrl = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Reports')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return hasLoaded
        ? Container(
            color: Colors.white,
            width: isLargeScreen ? 1025 : 500,
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
                        fontSize: isLargeScreen ? 32 : 18,
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
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Attemp Homicide',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'ATTEMPT HOMICIDE',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Kidnapping',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'KIDNAPPING',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Theft',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'THEFT',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Carnapping',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'CARNAPPING',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Act of Lasciviousness',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'ACT OF LASCIVIOUSNESS',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Attempt Murder',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            trailing: const Icon(Icons
                                                .keyboard_arrow_right_rounded),
                                            title: TextRegular(
                                                text: 'ATTEMPT MURDER',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text: 'I am the',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                InputElement
                                                                    input =
                                                                    FileUploadInputElement()
                                                                        as InputElement
                                                                      ..accept =
                                                                          'image/*';
                                                                FirebaseStorage
                                                                    fs =
                                                                    FirebaseStorage
                                                                        .instance;
                                                                input.click();
                                                                input.onChange
                                                                    .listen(
                                                                        (event) {
                                                                  final file =
                                                                      input
                                                                          .files!
                                                                          .first;
                                                                  final reader =
                                                                      FileReader();
                                                                  reader
                                                                      .readAsDataUrl(
                                                                          file);
                                                                  reader
                                                                      .onLoadEnd
                                                                      .listen(
                                                                          (event) async {
                                                                    var snapshot = await fs
                                                                        .ref()
                                                                        .child(DateTime.now()
                                                                            .toString())
                                                                        .putBlob(
                                                                            file);
                                                                    String
                                                                        downloadUrl =
                                                                        await snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Photo Uploaded Succesfully!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;

                                                                      isUploaded =
                                                                          true;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 100,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Witness'),
                                                            value: 'Witness',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Victim'),
                                                            value: 'Victim',
                                                            groupValue:
                                                                _selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          addReport(
                                                              myName,
                                                              myNumber,
                                                              myAddress,
                                                              lat,
                                                              long,
                                                              'Others',
                                                              'Pending',
                                                              _selectedOption,
                                                              brgy,
                                                              imgUrl,
                                                              true);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: TextRegular(
                                                                  text:
                                                                      'Emergency Alert Sent! Wait for further response',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                        child: TextBold(
                                                          text: 'Continue',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
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
                                child: Icon(
                                  Icons.campaign_rounded,
                                  color: Colors.white,
                                  size: isLargeScreen ? 68 : 32,
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
                                height: isLargeScreen ? 125 : 50,
                                width: isLargeScreen ? 150 : 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: isLargeScreen ? 68 : 32,
                                ),
                              ),
                            );
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextRegular(
                  text: 'Press the Red Button to trigger Report',
                  fontSize: isLargeScreen ? 18 : 14,
                  color: Colors.red,
                ),
              ],
            ),
          )
        : SizedBox(
            width: isLargeScreen ? 1025 : 50,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
