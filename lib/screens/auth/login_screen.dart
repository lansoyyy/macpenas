import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

  String id1Front = '';
  String id1Back = '';
  String id2Front = '';
  String id2Back = '';

  final bool _isChecked = false;

  List ids = [
    'UMID',
    'Drivers License',
    'SSS ID',
    'PhilHealth ID',
    'TIN Card',
    'Postal ID',
    'Voters ID',
    'Passport',
    'Pag-ibig ID',
    'PRC ID',
    'National ID'
  ];

  String id1 = 'UMID';
  String id2 = 'UMID';

  int dropValue = 0;
  int dropValue1 = 0;

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
                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    print(user);
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
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Routes().homescreen);
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

  // registerDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //             backgroundColor: Colors.white.withOpacity(0.8),
  //             child: StatefulBuilder(builder: (context, setState) {
  //               return Container(
  //                 color: Colors.white.withOpacity(0.5),
  //                 height: 450,
  //                 width: 400,
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             id1Front == ''
  //                                 ? Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #1 (Front)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id1Front = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: const BoxDecoration(
  //                                             color: Colors.grey,
  //                                           ),
  //                                           child: const Icon(
  //                                             Icons.add,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 : Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #1 (Front)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id1Front = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.grey,
  //                                             image: DecorationImage(
  //                                                 image: NetworkImage(id1Front),
  //                                                 fit: BoxFit.cover),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                             id1Back == ''
  //                                 ? Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #1 (Back)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id1Back = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: const BoxDecoration(
  //                                             color: Colors.grey,
  //                                           ),
  //                                           child: const Icon(
  //                                             Icons.add,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 : Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #1 (Back)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id1Back = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.grey,
  //                                             image: DecorationImage(
  //                                                 image: NetworkImage(id1Front),
  //                                                 fit: BoxFit.cover),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 35),
  //                               child: Align(
  //                                 alignment: Alignment.topLeft,
  //                                 child: TextRegular(
  //                                   text: 'Uploaded ID Type: ',
  //                                   fontSize: 14,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               height: 5,
  //                             ),
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     left: 10, right: 10),
  //                                 child: SizedBox(
  //                                   height: 40,
  //                                   width: 275,
  //                                   child: DropdownButton(
  //                                     underline: const SizedBox(),
  //                                     value: dropValue,
  //                                     items: [
  //                                       for (int i = 0; i < ids.length; i++)
  //                                         DropdownMenuItem(
  //                                           onTap: () {
  //                                             setState(() {
  //                                               id1 = ids[i];
  //                                             });
  //                                           },
  //                                           value: i,
  //                                           child: TextRegular(
  //                                             text: ids[i],
  //                                             fontSize: 14,
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                     ],
  //                                     onChanged: (value) {
  //                                       setState(() {
  //                                         dropValue =
  //                                             int.parse(value.toString());
  //                                       });
  //                                     },
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             id1Front == ''
  //                                 ? Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #2 (Front)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id2Front = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: const BoxDecoration(
  //                                             color: Colors.grey,
  //                                           ),
  //                                           child: const Icon(
  //                                             Icons.add,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 : Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #2 (Front)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id2Front = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.grey,
  //                                             image: DecorationImage(
  //                                                 image: NetworkImage(id1Front),
  //                                                 fit: BoxFit.cover),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                             id1Back == ''
  //                                 ? Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #2 (Back)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id2Back = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: const BoxDecoration(
  //                                             color: Colors.grey,
  //                                           ),
  //                                           child: const Icon(
  //                                             Icons.add,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 : Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       TextRegular(
  //                                           text: 'ID #2 (Back)',
  //                                           fontSize: 14,
  //                                           color: Colors.grey),
  //                                       const SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           InputElement input =
  //                                               FileUploadInputElement()
  //                                                   as InputElement
  //                                                 ..accept = 'image/*';
  //                                           FirebaseStorage fs =
  //                                               FirebaseStorage.instance;
  //                                           input.click();
  //                                           input.onChange.listen((event) {
  //                                             final file = input.files!.first;
  //                                             final reader = FileReader();
  //                                             reader.readAsDataUrl(file);
  //                                             reader.onLoadEnd
  //                                                 .listen((event) async {
  //                                               var snapshot = await fs
  //                                                   .ref()
  //                                                   .child('newfile')
  //                                                   .putBlob(file);
  //                                               String downloadUrl =
  //                                                   await snapshot.ref
  //                                                       .getDownloadURL();
  //                                               ScaffoldMessenger.of(context)
  //                                                   .showSnackBar(SnackBar(
  //                                                       content: TextRegular(
  //                                                           text:
  //                                                               'Uploaded Succesfully! Click update to see changes',
  //                                                           fontSize: 14,
  //                                                           color:
  //                                                               Colors.white)));

  //                                               setState(() {
  //                                                 id2Back = downloadUrl;
  //                                               });
  //                                             });
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           height: 150,
  //                                           width: 150,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.grey,
  //                                             image: DecorationImage(
  //                                                 image: NetworkImage(id1Front),
  //                                                 fit: BoxFit.cover),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 35),
  //                               child: Align(
  //                                 alignment: Alignment.topLeft,
  //                                 child: TextRegular(
  //                                   text: 'Uploaded ID Type: ',
  //                                   fontSize: 14,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               height: 5,
  //                             ),
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.black,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     left: 10, right: 10),
  //                                 child: SizedBox(
  //                                   height: 40,
  //                                   width: 275,
  //                                   child: DropdownButton(
  //                                     underline: const SizedBox(),
  //                                     value: dropValue1,
  //                                     items: [
  //                                       for (int i = 0; i < ids.length; i++)
  //                                         DropdownMenuItem(
  //                                           onTap: () {
  //                                             setState(() {
  //                                               id2 = ids[i];
  //                                             });
  //                                           },
  //                                           value: i,
  //                                           child: TextRegular(
  //                                             text: ids[i],
  //                                             fontSize: 14,
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                     ],
  //                                     onChanged: (value) {
  //                                       setState(() {
  //                                         dropValue1 =
  //                                             int.parse(value.toString());
  //                                       });
  //                                     },
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             label: 'Full Name',
  //                             controller: newNameController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             label: 'Contact Number',
  //                             controller: newNumberController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             label: 'Address',
  //                             controller: newAddressController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             isEmail: true,
  //                             label: 'Email',
  //                             controller: newEmailController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             isObscure: true,
  //                             isPassword: true,
  //                             label: 'Password',
  //                             controller: newPassController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         TextFieldWidget(
  //                             isObscure: true,
  //                             isPassword: true,
  //                             label: 'Confirm Password',
  //                             controller: newConfirmPassController),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 20, right: 20),
  //                           child: CheckboxListTile(
  //                             title: GestureDetector(
  //                               onTap: () {
  //                                 showDialog(
  //                                   context: context,
  //                                   builder: (context) {
  //                                     return AlertDialog(
  //                                       title: TextBold(
  //                                         text: 'Macpenas Policy',
  //                                         fontSize: 18,
  //                                         color: Colors.black,
  //                                       ),
  //                                       content: SizedBox(
  //                                         width: 500,
  //                                         height: 300,
  //                                         child: TextRegular(
  //                                             text:
  //                                                 'MACPENAS App Policy\n\nBy using the MACPENAS App, you agree to the following policy:\n\nFalse Reporting: You understand and agree that providing false information through the MACPENAS App may result in false reporting of crimes, which is a punishable offense.\n\nAccuracy of Information: You are responsible for ensuring the accuracy and truthfulness of the information you provide when using the App.\n\nPlease read and understand this policy before using the MACPENAS App. Your use of the App indicates your acceptance of these terms.',
  //                                             fontSize: 14,
  //                                             color: Colors.grey),
  //                                       ),
  //                                       actions: [
  //                                         TextButton(
  //                                           onPressed: () {
  //                                             Navigator.pop(context);
  //                                           },
  //                                           child: TextRegular(
  //                                             text: 'Close',
  //                                             fontSize: 14,
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     );
  //                                   },
  //                                 );
  //                               },
  //                               child: const Text('I agree to the policies'),
  //                             ),
  //                             value: _isChecked,
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 _isChecked = value!;
  //                               });
  //                             },
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         _isChecked
  //                             ? ButtonWidget(
  //                                 label: 'Register',
  //                                 onPressed: (() async {
  //                                   if (newNameController.text == '' ||
  //                                       newNumberController.text == '' ||
  //                                       newAddressController.text == '' ||
  //                                       newEmailController.text == '' ||
  //                                       newPassController.text == '' ||
  //                                       newConfirmPassController.text == '' ||
  //                                       id1Front == '' ||
  //                                       id1Back == '' ||
  //                                       id2Front == '' ||
  //                                       id2Back == '') {
  //                                     Navigator.pop(context);
  //                                     ScaffoldMessenger.of(context)
  //                                         .showSnackBar(
  //                                       SnackBar(
  //                                         content: TextRegular(
  //                                             text:
  //                                                 'Please supply all the missing fields',
  //                                             fontSize: 14,
  //                                             color: Colors.white),
  //                                       ),
  //                                     );
  //                                   } else {
  //                                     if (newConfirmPassController.text !=
  //                                         newPassController.text) {
  //                                       Navigator.pop(context);
  //                                       ScaffoldMessenger.of(context)
  //                                           .showSnackBar(
  //                                         SnackBar(
  //                                           content: TextRegular(
  //                                               text: 'Password do not match!',
  //                                               fontSize: 14,
  //                                               color: Colors.white),
  //                                         ),
  //                                       );
  //                                     } else {
  //                                       if (id1Front == '') {
  //                                         ScaffoldMessenger.of(context)
  //                                             .showSnackBar(
  //                                           SnackBar(
  //                                             content: TextRegular(
  //                                                 text:
  //                                                     'Please upload your ID for verification',
  //                                                 fontSize: 14,
  //                                                 color: Colors.white),
  //                                           ),
  //                                         );
  //                                       } else {
  //                                         try {
  //                                           await FirebaseAuth.instance
  //                                               .createUserWithEmailAndPassword(
  //                                                   email:
  //                                                       newEmailController.text,
  //                                                   password:
  //                                                       newPassController.text);
  //                                           addUser(
  //                                               newNameController.text,
  //                                               newEmailController.text,
  //                                               newNumberController.text,
  //                                               newAddressController.text,
  //                                               id1Front,
  //                                               id1Back,
  //                                               id1,
  //                                               id2Front,
  //                                               id2Back,
  //                                               id2);
  //                                           Navigator.pop(context);
  //                                           ScaffoldMessenger.of(context)
  //                                               .showSnackBar(
  //                                             SnackBar(
  //                                               content: TextRegular(
  //                                                   text:
  //                                                       'Account created succesfully! Please wait for admin to approve your registration',
  //                                                   fontSize: 14,
  //                                                   color: Colors.white),
  //                                             ),
  //                                           );
  //                                         } catch (e) {
  //                                           ScaffoldMessenger.of(context)
  //                                               .showSnackBar(
  //                                             SnackBar(
  //                                               content: TextRegular(
  //                                                   text: e.toString(),
  //                                                   fontSize: 14,
  //                                                   color: Colors.white),
  //                                             ),
  //                                           );
  //                                         }
  //                                       }
  //                                     }
  //                                   }
  //                                 }))
  //                             : const SizedBox()
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }));
  //       });
  // }
}
