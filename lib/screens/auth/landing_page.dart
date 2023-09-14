import 'dart:html';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:macpenas/services/add_user.dart';
import 'package:macpenas/utils/routes.dart';
import 'package:macpenas/widgets/textfield_widget.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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

  List<String> regions = [
    'Region 10',
  ];

  String region = 'Region 10';
  List<String> provinces = [
    'Bukidnon',
  ];

  String province = 'Bukidnon';
  List<String> municipalities = [
    'Malaybalay',
  ];

  String municipality = 'Malaybalay';

  List<String> brgys = [
    "Aglayan",
    "Bangcud",
    "Barangay 1",
    "Barangay 2",
    "Barangay 3",
    "Barangay 4",
    "Barangay 5",
    "Barangay 6",
    "Barangay 7",
    "Barangay 8",
    "Barangay 9",
    "Busdi",
    "Cabangahan",
    "Caburacanan",
    "Canayan",
    "Capitan Angel",
    "Casisang",
    "Dalwangan",
    "Imbayao",
    "Indalaza",
    "Kabalabag",
    "Kalasungay",
    "Kulaman",
    "Laguitas",
    "Linabo",
    "Magsaysay",
    "Maligaya",
    "Managok",
    "Manalog",
    "Mapayag",
    "Mapulo",
    "Miglamin",
    "Patpat",
    "Saint Peter",
    "San Jose",
    "San Martin",
    "Santo Ñino",
    "Silae",
    "Simaya",
    "Sinanglanan",
    "Sumpong",
    "Violeta",
    "Zamboanguita",
  ];

  String brgy = 'Aglayan';

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
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextBold(
                      text: 'Macpenas', fontSize: 28, color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    height: 400,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                              label: 'Main Administration',
                              onPressed: (() {
                                Navigator.pushNamed(
                                    context, Routes().loginscreen);
                              })),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                              label: 'Administration',
                              onPressed: (() {
                                Navigator.pushNamed(
                                    context, Routes().loginscreen);
                              })),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                              label: 'Intelligence',
                              onPressed: (() {
                                Navigator.pushNamed(
                                    context, Routes().loginscreen);
                              })),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                              label: 'Users',
                              onPressed: (() {
                                Navigator.pushNamed(
                                    context, Routes().loginscreen);
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
                                one();
                                // registerDialog();
                              },
                              child: TextBold(
                                  text: 'Register here',
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

  final newemailController = TextEditingController();

  one() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldWidget(
                    label: 'Enter your Email',
                    controller: newEmailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextRegular(
                    text:
                        "By tapping next, we'll collect your Email Address information to be able to send you a verification code",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                three();
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  two() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextRegular(
                    text:
                        "We send you a verification code. If you verify your email, you can proceed to logging in",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: TextBold(
                text: 'Close',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  final newfirstnamename = TextEditingController();
  final newmiddlenamename = TextEditingController();
  final newlastnamename = TextEditingController();
  final newregion = TextEditingController();
  final newprovince = TextEditingController();
  final newmunicipality = TextEditingController();
  final newbrgy = TextEditingController();
  final newstreet = TextEditingController();
  final newnumber = TextEditingController();

  three() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  one();
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              TextBold(
                text: 'Pre-Registration',
                fontSize: 18,
                color: Colors.black,
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldWidget(
                        label: 'First Name', controller: newfirstnamename),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        label: 'Middle Name (Leave as blank if n/a)',
                        controller: newmiddlenamename),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        label: 'Last Name', controller: newlastnamename),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        label: 'Contact Number', controller: newnumber),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextRegular(
                          text: 'Birthday', fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        halfDayDatePicker(context);
                      },
                      child: SizedBox(
                        width: 325,
                        height: 50,
                        child: TextFormField(
                          enabled: false,
                          style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                          ),

                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blue,
                            ),
                            hintStyle: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            hintText: bdayController.text,
                            border: InputBorder.none,
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            errorStyle: const TextStyle(
                                fontFamily: 'Bold', fontSize: 12),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),

                          controller: bdayController,
                          // Pass the validator to the TextFormField
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextRegular(
                          text: 'Region', fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: region,
                        items: regions.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: SizedBox(
                                width: 273,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'QRegular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            region = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextRegular(
                          text: 'Province', fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: province,
                        items: provinces.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: SizedBox(
                                width: 273,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'QRegular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            province = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextRegular(
                          text: 'Municipality',
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: municipality,
                        items: municipalities.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: SizedBox(
                                width: 273,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'QRegular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            municipality = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextRegular(
                          text: 'Baranggay', fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: brgy,
                        items: brgys.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: SizedBox(
                                width: 273,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'QRegular',
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            brgy = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(label: 'Street', controller: newstreet),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                four();
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  four() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRegular(
                        text:
                            'Review your information\nCheck your spelling and important details',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    TextRegular(
                        text: 'First Name: ${newfirstnamename.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Middle Name: ${newmiddlenamename.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Last Name: ${newlastnamename.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Contact Number: ${newNumberController.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Birthday: ${bdayController.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text:
                            'Address: $region, $province, $municipality, $brgy, ${newstreet.text}',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                three();
              },
              child: TextBold(
                text: 'Back',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                five();
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  final newmpin = TextEditingController();
  final newconfirmpin = TextEditingController();

  five() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRegular(
                        text:
                            'Set your MPIN.\nYour MPIN is the password to your account. For your account security, never share your MPIN with anyone',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Enter your MPIN: ',
                        controller: newmpin),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Confirm MPIN: ',
                        controller: newconfirmpin),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newmpin.text != newconfirmpin.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: TextRegular(
                          text: 'Your MPIN do not match!',
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  six();
                }
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  six() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRegular(
                        text: 'Upload your ID',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        id1Front == ''
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #1 (Front)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id1Front = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #1 (Front)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id1Front = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: NetworkImage(id1Front),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        id1Back == ''
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #1 (Back)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id1Back = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #1 (Back)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id1Back = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: NetworkImage(id1Front),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextRegular(
                              text: 'Uploaded ID Type: ',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              height: 40,
                              width: 275,
                              child: DropdownButton(
                                underline: const SizedBox(),
                                value: dropValue,
                                items: [
                                  for (int i = 0; i < ids.length; i++)
                                    DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          id1 = ids[i];
                                        });
                                      },
                                      value: i,
                                      child: TextRegular(
                                        text: ids[i],
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropValue = int.parse(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        id1Front == ''
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #2 (Front)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id2Front = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #2 (Front)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id2Front = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: NetworkImage(id1Front),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        id1Back == ''
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #2 (Back)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id2Back = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRegular(
                                      text: 'ID #2 (Back)',
                                      fontSize: 14,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      InputElement input =
                                          FileUploadInputElement()
                                              as InputElement
                                            ..accept = 'image/*';
                                      FirebaseStorage fs =
                                          FirebaseStorage.instance;
                                      input.click();
                                      input.onChange.listen((event) {
                                        final file = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(file);
                                        reader.onLoadEnd.listen((event) async {
                                          var snapshot = await fs
                                              .ref()
                                              .child('newfile')
                                              .putBlob(file);
                                          String downloadUrl = await snapshot
                                              .ref
                                              .getDownloadURL();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: TextRegular(
                                                      text:
                                                          'Uploaded Succesfully! Click update to see changes',
                                                      fontSize: 14,
                                                      color: Colors.white)));

                                          setState(() {
                                            id2Back = downloadUrl;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: NetworkImage(id1Front),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextRegular(
                              text: 'Uploaded ID Type: ',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              height: 40,
                              width: 275,
                              child: DropdownButton(
                                underline: const SizedBox(),
                                value: dropValue1,
                                items: [
                                  for (int i = 0; i < ids.length; i++)
                                    DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          id2 = ids[i];
                                        });
                                      },
                                      value: i,
                                      child: TextRegular(
                                        text: ids[i],
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropValue1 = int.parse(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Random random = Random();

                // Generate a random integer between 0 (inclusive) and 100 (exclusive).
                int randomNumber = random.nextInt(1000000);
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: newEmailController.text, password: newmpin.text);

                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: newEmailController.text, password: newmpin.text);

                  addUser(
                      '${newfirstnamename.text} ${newmiddlenamename.text} ${newlastnamename.text}',
                      newEmailController.text,
                      newnumber.text,
                      '$region, $province, $municipality, $brgy, ${newstreet.text}',
                      id1Front,
                      id1Back,
                      id1,
                      id2Front,
                      id2Back,
                      id2,
                      randomNumber,
                      brgy);

                  Navigator.pop(context);
                  seven(randomNumber);
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
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  seven(int refno) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(
            text: 'Pre-Registration',
            fontSize: 18,
            color: Colors.black,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRegular(
                        text:
                            'You are now Pre-registered to MACPENAS, kindly present this code to the Police Station to fully register your account.\n Ref. No.\n$refno\n\nNote: Bring your 2 Valid IDs during physical registration',
                        fontSize: 12,
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  await user.sendEmailVerification();

                  // You can show a success message or redirect the user to a verification screen.
                  // For example, you can use a SnackBar or Navigator.
                } else {
                  // Handle the case where the user is not logged in.
                }
                Navigator.pop(context);
                two();
              },
              child: TextBold(
                text: 'Next',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  final bdayController = TextEditingController();
  void halfDayDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('MM-dd-yyy').format(pickedDate);

      setState(() {
        bdayController.text = formattedDate;
      });
    } else {
      return null;
    }
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
