import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
import '../../widgets/text_widget.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String nameSearched = '';
  final searchController = TextEditingController();

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    return Container(
      color: Colors.white,
      width: isLargeScreen ? 1025 : 350,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextBold(
                  text: 'User Management',
                  fontSize: isLargeScreen ? 32 : 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: isLargeScreen ? 300 : 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    nameSearched = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Search User',
                    hintStyle: TextStyle(fontFamily: 'QRegular'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
                controller: searchController,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('name',
                      isGreaterThanOrEqualTo:
                          toBeginningOfSentenceCase(nameSearched))
                  .where('name',
                      isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return isLargeScreen
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          child: DataTable(columns: [
                            DataColumn(
                              label: TextBold(
                                text: '',
                                fontSize: 0,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'ID',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'Name',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'Email',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'Contact Number',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'Address',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataColumn(
                              label: TextBold(
                                text: 'Verified',
                                fontSize: 0,
                                color: Colors.black,
                              ),
                            ),
                          ], rows: [
                            for (int i = 0; i < data.docs.length; i++)
                              DataRow(
                                cells: [
                                  DataCell(
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: TextBold(
                                                  text: 'User ID',
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              content: Image.network(
                                                  data.docs[i]['imageId']),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: TextRegular(
                                                    text: 'Close',
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                      text: (i + 1).toString(),
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                      text: data.docs[i]['name'],
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                      text: data.docs[i]['email'],
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                      text: data.docs[i]['contactNumber'],
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                      text: data.docs[i]['address'],
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        TextRegular(
                                          text: data.docs[i]['isVerified']
                                              .toString(),
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        data.docs[i]['isVerified'] == true
                                            ? const SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                              'Verified Confirmation',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'QBold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            content: const Text(
                                                              'Are you sure you want to verify this user?',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'QRegular'),
                                                            ),
                                                            actions: <Widget>[
                                                              MaterialButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true),
                                                                child:
                                                                    const Text(
                                                                  'Close',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'QRegular',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              MaterialButton(
                                                                onPressed:
                                                                    () async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Users')
                                                                      .doc(data
                                                                          .docs[
                                                                              i]
                                                                          .id)
                                                                      .update({
                                                                    'isVerified':
                                                                        true
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Continue',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'QRegular',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                },
                                                icon: const Icon(
                                                  Icons.verified_outlined,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ]),
                        ),
                      )
                    : Scrollbar(
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              child: DataTable(columns: [
                                DataColumn(
                                  label: TextBold(
                                    text: '',
                                    fontSize: 0,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'ID',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'Name',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'Email',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'Contact Number',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'Address',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                DataColumn(
                                  label: TextBold(
                                    text: 'Verified',
                                    fontSize: 0,
                                    color: Colors.black,
                                  ),
                                ),
                              ], rows: [
                                for (int i = 0; i < data.docs.length; i++)
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: TextBold(
                                                      text: 'User ID',
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  content: Image.network(
                                                      data.docs[i]['imageId']),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: TextRegular(
                                                        text: 'Close',
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.visibility,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        TextRegular(
                                          text: (i + 1).toString(),
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      DataCell(
                                        TextRegular(
                                          text: data.docs[i]['name'],
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      DataCell(
                                        TextRegular(
                                          text: data.docs[i]['email'],
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      DataCell(
                                        TextRegular(
                                          text: data.docs[i]['contactNumber'],
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      DataCell(
                                        TextRegular(
                                          text: data.docs[i]['address'],
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            TextRegular(
                                              text: data.docs[i]['isVerified']
                                                  .toString(),
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            data.docs[i]['isVerified'] == true
                                                ? const SizedBox()
                                                : IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      'Verified Confirmation',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'QBold',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    content:
                                                                        const Text(
                                                                      'Are you sure you want to verify this user?',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'QRegular'),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.of(context).pop(true),
                                                                        child:
                                                                            const Text(
                                                                          'Close',
                                                                          style: TextStyle(
                                                                              fontFamily: 'QRegular',
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await FirebaseFirestore.instance.collection('Users').doc(data.docs[i].id).update({
                                                                            'isVerified':
                                                                                true
                                                                          });
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Continue',
                                                                          style: TextStyle(
                                                                              fontFamily: 'QRegular',
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ));
                                                    },
                                                    icon: const Icon(
                                                      Icons.verified_outlined,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ]),
                            ),
                          ),
                        ),
                      );
              })
        ],
      ),
    );
  }
}
