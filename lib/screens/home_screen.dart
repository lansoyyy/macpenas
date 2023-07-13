import 'package:flutter/material.dart';
import 'package:macpenas/screens/pages/about_us_page.dart';
import 'package:macpenas/screens/pages/admin_dashboard_page.dart';
import 'package:macpenas/screens/pages/profile_page.dart';
import 'package:macpenas/screens/pages/role_management_page.dart';
import 'package:macpenas/screens/pages/user_home_page.dart';
import 'package:macpenas/screens/pages/user_management_page.dart';
import 'package:macpenas/utils/routes.dart';

import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHome = true;

  bool isDashboard = false;

  bool isInfo = false;

  bool isProfile = false;
  bool isRole = false;
  bool isUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey[200],
            width: 400,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                            text: 'MACPENAS',
                            fontSize: 28,
                            color: Colors.blue,
                          ),
                          TextRegular(
                            text: 'Malaybalay City, Bukidnon',
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ExpansionTile(
                    title: TextBold(
                      text: 'Main Menu',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    children: [
                      ListTile(
                        onTap: () {
                          setState(() {
                            isHome = true;
                            isDashboard = false;
                            isInfo = false;
                            isProfile = false;
                            isRole = false;
                            isUser = false;
                          });
                        },
                        leading: Icon(
                          Icons.home,
                          color: isHome ? Colors.blue : Colors.grey,
                        ),
                        title: TextRegular(
                          text: 'Home',
                          fontSize: 16,
                          color: isHome ? Colors.blue : Colors.grey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isDashboard = true;
                            isInfo = false;
                            isProfile = false;
                            isRole = false;
                            isUser = false;
                          });
                        },
                        leading: Icon(
                          Icons.dashboard,
                          color: isDashboard ? Colors.blue : Colors.grey,
                        ),
                        title: TextRegular(
                          text: 'Admin Dashboard',
                          fontSize: 16,
                          color: isDashboard ? Colors.blue : Colors.grey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isDashboard = false;
                            isInfo = false;
                            isProfile = false;
                            isRole = false;
                            isUser = true;
                          });
                        },
                        leading: Icon(
                          Icons.person,
                          color: isUser ? Colors.blue : Colors.grey,
                        ),
                        title: TextRegular(
                          text: 'User Management',
                          fontSize: 16,
                          color: isUser ? Colors.blue : Colors.grey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isDashboard = false;
                            isInfo = false;
                            isProfile = false;
                            isRole = true;
                            isUser = false;
                          });
                        },
                        leading: Icon(
                          Icons.work_outline,
                          color: isRole ? Colors.blue : Colors.grey,
                        ),
                        title: TextRegular(
                          text: 'Role Management',
                          fontSize: 16,
                          color: isRole ? Colors.blue : Colors.grey,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isDashboard = false;
                            isInfo = true;
                            isProfile = false;
                            isRole = false;
                            isUser = false;
                          });
                        },
                        leading: Icon(
                          Icons.info,
                          color: isInfo ? Colors.blue : Colors.grey,
                        ),
                        title: TextRegular(
                          text: 'Info',
                          fontSize: 16,
                          color: isInfo ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    trailing: const SizedBox(),
                    title: TextBold(
                      text: 'Account',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        isHome = false;
                        isDashboard = false;
                        isInfo = false;
                        isProfile = true;
                        isRole = false;
                        isUser = false;
                      });
                    },
                    leading: Icon(
                      Icons.person,
                      color: isProfile ? Colors.blue : Colors.grey,
                    ),
                    title: TextRegular(
                      text: 'My Account',
                      fontSize: 16,
                      color: isProfile ? Colors.blue : Colors.grey,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  'Logout Confirmation',
                                  style: TextStyle(
                                      fontFamily: 'QBold',
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Are you sure you want to Logout?',
                                  style: TextStyle(fontFamily: 'QRegular'),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Routes().loginscreen);
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    leading: const Icon(Icons.logout),
                    title: TextRegular(
                      text: 'Logout',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          isHome
              ? const UserHomePage()
              : isInfo
                  ? const AboutUsPage()
                  : isProfile
                      ? const ProfileScreen()
                      : isDashboard
                          ? const AdminDashboardScreen()
                          : isRole
                              ? const RoleManagementScreen()
                              : isUser
                                  ? const UserManagementScreen()
                                  : const SizedBox()
        ],
      ),
    );
  }
}
