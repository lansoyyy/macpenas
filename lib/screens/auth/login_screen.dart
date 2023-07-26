import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macpenas/services/add_user.dart';
import 'package:macpenas/utils/routes.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  final newEmailController = TextEditingController();

  final newPassController = TextEditingController();
  final newConfirmPassController = TextEditingController();

  final newNameController = TextEditingController();

  final newAddressController = TextEditingController();

  final newNumberController = TextEditingController();

  final box = GetStorage();

  String imgUrl = '';

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 150.0,
              image: AssetImage('assets/images/back.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 800,
                      child: TextBold(
                          text: 'Macpenas', fontSize: 28, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    height: 375,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                              isEmail: true,
                              label: 'Email',
                              controller: emailController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              isObscure: true,
                              isPassword: true,
                              label: 'Password',
                              controller: passController),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                              label: 'Login',
                              onPressed: (() async {
                                bool isVerified = false;
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passController.text)
                                      .then((value) {
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('id',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .get()
                                        .then((QuerySnapshot
                                            querySnapshot) async {
                                      for (var doc in querySnapshot.docs) {
                                        box.write('user', doc['role']);

                                        setState(() {
                                          isVerified = doc['isVerified'];
                                        });
                                      }
                                    }).then((value) {
                                      if (isVerified) {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                Routes().homescreen);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: TextRegular(
                                                text:
                                                    'Your account has not been verified! Wait for the admins response',
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                    });
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: TextRegular(
                                          text: e.toString(),
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  );
                                }
                              })),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Divider(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextBold(
                                    text: 'or',
                                    fontSize: 14,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 100,
                                  child: Divider(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.8),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return Container(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              height: 450,
                                              width: 400,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      imgUrl == ''
                                                          ? GestureDetector(
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
                                                                        .child(
                                                                            'newfile')
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
                                                                                'Uploaded Succesfully! Click update to see changes',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 150,
                                                                width: 150,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          : GestureDetector(
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
                                                                        .child(
                                                                            'newfile')
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
                                                                                'Uploaded Succesfully! Click update to see changes',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white)));

                                                                    setState(
                                                                        () {
                                                                      imgUrl =
                                                                          downloadUrl;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 150,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          imgUrl),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          label: 'Full Name',
                                                          controller:
                                                              newNameController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          label:
                                                              'Contact Number',
                                                          controller:
                                                              newNumberController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          label: 'Address',
                                                          controller:
                                                              newAddressController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          isEmail: true,
                                                          label: 'Email',
                                                          controller:
                                                              newEmailController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          isObscure: true,
                                                          isPassword: true,
                                                          label: 'Password',
                                                          controller:
                                                              newPassController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextFieldWidget(
                                                          isObscure: true,
                                                          isPassword: true,
                                                          label:
                                                              'Confirm Password',
                                                          controller:
                                                              newConfirmPassController),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: CheckboxListTile(
                                                          title:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        TextBold(
                                                                      text:
                                                                          'Macpenas Policy',
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    content:
                                                                        SizedBox(
                                                                      width:
                                                                          500,
                                                                      height:
                                                                          300,
                                                                      child: TextRegular(
                                                                          text:
                                                                              'MACPENAS App Policy\n\nBy using the MACPENAS App, you agree to the following policy:\n\nFalse Reporting: You understand and agree that providing false information through the MACPENAS App may result in false reporting of crimes, which is a punishable offense.\n\nAccuracy of Information: You are responsible for ensuring the accuracy and truthfulness of the information you provide when using the App.\n\nPlease read and understand this policy before using the MACPENAS App. Your use of the App indicates your acceptance of these terms.',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            TextRegular(
                                                                          text:
                                                                              'Close',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: const Text(
                                                                'I agree to the policies'),
                                                          ),
                                                          value: _isChecked,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isChecked =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      _isChecked
                                                          ? ButtonWidget(
                                                              label: 'Register',
                                                              onPressed:
                                                                  (() async {
                                                                if (newNameController.text == '' ||
                                                                    newNumberController
                                                                            .text ==
                                                                        '' ||
                                                                    newAddressController
                                                                            .text ==
                                                                        '' ||
                                                                    newEmailController
                                                                            .text ==
                                                                        '' ||
                                                                    newPassController
                                                                            .text ==
                                                                        '' ||
                                                                    newConfirmPassController
                                                                            .text ==
                                                                        '') {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: TextRegular(
                                                                          text:
                                                                              'Please supply all the missing fields',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  if (newConfirmPassController
                                                                          .text !=
                                                                      newPassController
                                                                          .text) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content: TextRegular(
                                                                            text:
                                                                                'Password do not match!',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    if (imgUrl ==
                                                                        '') {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content: TextRegular(
                                                                              text: 'Please upload your ID for verification',
                                                                              fontSize: 14,
                                                                              color: Colors.white),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      try {
                                                                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                                            email:
                                                                                newEmailController.text,
                                                                            password: newPassController.text);
                                                                        addUser(
                                                                            newNameController.text,
                                                                            newEmailController.text,
                                                                            newNumberController.text,
                                                                            newAddressController.text,
                                                                            imgUrl);
                                                                        Navigator.pop(
                                                                            context);
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content: TextRegular(
                                                                                text: 'Account created succesfully!',
                                                                                fontSize: 14,
                                                                                color: Colors.white),
                                                                          ),
                                                                        );
                                                                      } catch (e) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content: TextRegular(
                                                                                text: e.toString(),
                                                                                fontSize: 14,
                                                                                color: Colors.white),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }))
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                    });
                              },
                              child: TextBold(
                                  text: 'Register',
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
