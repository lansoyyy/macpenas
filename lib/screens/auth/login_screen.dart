import 'package:flutter/material.dart';
import 'package:macpenas/utils/routes.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final newEmailController = TextEditingController();
  final newPassController = TextEditingController();
  final newNameController = TextEditingController();
  final newAddressController = TextEditingController();
  final newNumberController = TextEditingController();

  LoginScreen({super.key});

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
                              label: 'Email', controller: emailController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              isObscure: true,
                              label: 'Password',
                              controller: passController),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                              label: 'Login',
                              onPressed: (() async {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes().homescreen);
                                // if (emailController.text == 'admin' &&
                                //     passController.text == 'admin') {
                                //   Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const HomeScreen()));
                                // } else {
                                //   // try {
                                //   //   await FirebaseAuth.instance
                                //   //       .signInWithEmailAndPassword(
                                //   //           email: emailController.text,
                                //   //           password: passController.text);
                                //   //   Navigator.of(context).pushReplacement(
                                //   //       MaterialPageRoute(
                                //   //           builder: (context) =>
                                //   //               const HomeScreen(
                                //   //                 userType: UserType.user,
                                //   //               )));
                                //   // } catch (e) {
                                //   //   ScaffoldMessenger.of(context).showSnackBar(
                                //   //     SnackBar(
                                //   //       content: TextRegular(
                                //   //           text: e.toString(),
                                //   //           fontSize: 14,
                                //   //           color: Colors.white),
                                //   //     ),
                                //   //   );
                                //   // }
                                // }
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
                                          child: Container(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            height: 375,
                                            width: 300,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextFieldWidget(
                                                      label: 'Full Name',
                                                      controller:
                                                          newNameController),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFieldWidget(
                                                      label: 'Contact Number',
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
                                                      label: 'Email',
                                                      controller:
                                                          newEmailController),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFieldWidget(
                                                      label: 'Password',
                                                      controller:
                                                          newPassController),
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
                                          ));
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
