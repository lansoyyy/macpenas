import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:macpenas/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyData();
  }

  String myName = '';
  String myNumber = '';
  String myAddress = '';
  String myRole = '';
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
          myRole = doc['role'];
          hasLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    return hasLoaded
        ? SizedBox(
            width: isLargeScreen ? 1025 : 500,
            child: Padding(
              padding: isLargeScreen
                  ? const EdgeInsets.fromLTRB(30, 50, 30, 50)
                  : const EdgeInsets.fromLTRB(15, 50, 15, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                        height: isLargeScreen ? 125 : 75,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextBold(
                        text: myName,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextRegular(
                        text: myRole,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: isLargeScreen ? 20 : 10,
                  ),
                  const VerticalDivider(),
                  SizedBox(
                    width: isLargeScreen ? 20 : 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBold(
                          text: 'Email',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextRegular(
                          text: FirebaseAuth.instance.currentUser!.email!,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextBold(
                          text: 'Address',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextRegular(
                          text: myAddress,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextBold(
                          text: 'Contact Number',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextRegular(
                          text: myNumber,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
