import 'package:flutter/material.dart';
import 'package:macpenas/widgets/button_widget.dart';

import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class RoleManagementScreen extends StatefulWidget {
  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  String nameSearched = '';
  final searchController = TextEditingController();
  final newEmailController = TextEditingController();
  final newPassController = TextEditingController();
  final newNameController = TextEditingController();
  final newAddressController = TextEditingController();
  final newNumberController = TextEditingController();
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
                  text: 'Role Management',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                ButtonWidget(
                  width: 150,
                  fontSize: 16,
                  label: 'Create',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              backgroundColor: Colors.white.withOpacity(0.8),
                              child: Container(
                                color: Colors.white.withOpacity(0.5),
                                height: 375,
                                width: 300,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFieldWidget(
                                            label: 'Full Name',
                                            controller: newNameController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            label: 'Contact Number',
                                            controller: newNumberController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            label: 'Address',
                                            controller: newAddressController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            label: 'Email',
                                            controller: newEmailController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            label: 'Password',
                                            controller: newPassController),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ButtonWidget(
                                            label: 'Register',
                                            onPressed: (() async {
                                              // try {
                                              //   await FirebaseAuth
                                              //       .instance
                                              //       .createUserWithEmailAndPassword(
                                              //           email:
                                              //               newEmailController
                                              //                   .text,
                                              //           password:
                                              //               newPassController
                                              //                   .text);
                                              //   addUser(
                                              //       newNameController
                                              //           .text,
                                              //       newEmailController
                                              //           .text,
                                              //       newPassController
                                              //           .text);
                                              //   Navigator.pop(
                                              //       context);
                                              //   ScaffoldMessenger.of(
                                              //           context)
                                              //       .showSnackBar(
                                              //     SnackBar(
                                              //       content: TextRegular(
                                              //           text:
                                              //               'Account created succesfully!',
                                              //           fontSize: 14,
                                              //           color: Colors
                                              //               .white),
                                              //     ),
                                              //   );
                                              // } catch (e) {
                                              //   ScaffoldMessenger.of(
                                              //           context)
                                              //       .showSnackBar(
                                              //     SnackBar(
                                              //       content: TextRegular(
                                              //           text: e
                                              //               .toString(),
                                              //           fontSize: 14,
                                              //           color: Colors
                                              //               .white),
                                              //     ),
                                              //   );
                                              // }
                                            })),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
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
                DataColumn(
                  label: TextBold(
                    text: 'Role',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ], rows: [
                DataRow(
                  cells: [
                    DataCell(
                      TextRegular(
                        text: '0',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    DataCell(
                      TextRegular(
                        text: 'John Doe',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    DataCell(
                      TextRegular(
                        text: 'doe123@gmail.com',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    DataCell(
                      TextRegular(
                        text: '09090104355',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    DataCell(
                      TextRegular(
                        text: 'Malaybalay City Bukidnon',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            TextRegular(
                              text: 'User',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.refresh_rounded,
                                size: 24,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
