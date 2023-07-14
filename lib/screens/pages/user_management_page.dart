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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1025,
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
                  fontSize: 32,
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
              width: 300,
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
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    child: DataTable(columns: [
                      DataColumn(
                        label: TextBold(
                          text: 'ID',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      DataColumn(
                        label: TextBold(
                          text: 'Name',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      DataColumn(
                        label: TextBold(
                          text: 'Email',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      DataColumn(
                        label: TextBold(
                          text: 'Contact Number',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      DataColumn(
                        label: TextBold(
                          text: 'Address',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ], rows: [
                      for (int i = 0; i < data.docs.length; i++)
                        DataRow(
                          cells: [
                            DataCell(
                              TextRegular(
                                text: (i + 1).toString(),
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                text: data.docs[i]['name'],
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                text: data.docs[i]['email'],
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                text: data.docs[i]['contactNumber'],
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                text: data.docs[i]['address'],
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                    ]),
                  ),
                );
              })
        ],
      ),
    );
  }
}
