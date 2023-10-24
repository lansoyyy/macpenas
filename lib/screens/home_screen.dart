import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macpenas/screens/pages/about_us_page.dart';
import 'package:macpenas/screens/pages/admin_dashboard_page.dart';
import 'package:macpenas/screens/pages/analytics_page.dart';
import 'package:macpenas/screens/pages/history_page.dart';
import 'package:macpenas/screens/pages/profile_page.dart';
import 'package:macpenas/screens/pages/role_management_page.dart';
import 'package:macpenas/screens/pages/user_home_page.dart';
import 'package:macpenas/screens/pages/user_management_page.dart';
import 'package:macpenas/utils/routes.dart';

import '../widgets/text_widget.dart';

final box = GetStorage();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHome = box.read('user') == 'main admin' ? false : true;

  bool isDashboard = box.read('user') == 'user' ? false : true;

  bool isInfo = false;

  bool isProfile = false;
  bool isRole = false;
  bool isUser = false;

  bool isAnalytics = false;

  bool isHistory = false;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    return Scaffold(
      appBar: isLargeScreen ? null : AppBar(),
      drawer: isLargeScreen
          ? null
          : Container(
              color: Colors.grey[200],
              width: isLargeScreen ? 400 : 150,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        isLargeScreen
                            ? Image.asset(
                                'assets/images/logo.png',
                                height: isLargeScreen ? 100 : 75,
                              )
                            : Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: isLargeScreen ? 100 : 75,
                                ),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold(
                              text: 'MACPENAS',
                              fontSize: isLargeScreen ? 28 : 0,
                              color: Colors.blue,
                            ),
                            TextRegular(
                              text: 'Malaybalay City, Bukidnon',
                              fontSize: isLargeScreen ? 14 : 0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isLargeScreen ? 50 : 10,
                    ),
                    ExpansionTile(
                      title: TextBold(
                        text: isLargeScreen ? 'Main Menu' : 'Menu',
                        fontSize: isLargeScreen ? 18 : 12,
                        color: Colors.grey,
                      ),
                      children: [
                        box.read('user') != 'main admin'
                            ? isLargeScreen
                                ? ListTile(
                                    onTap: () {
                                      setState(() {
                                        isHome = true;
                                        isDashboard = false;
                                        isInfo = false;
                                        isProfile = false;
                                        isRole = false;
                                        isUser = false;
                                        isAnalytics = false;
                                        isHistory = false;
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
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHome = true;
                                          isDashboard = false;
                                          isInfo = false;
                                          isProfile = false;
                                          isRole = false;
                                          isUser = false;
                                          isAnalytics = false;
                                          isHistory = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.home,
                                        color:
                                            isHome ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                  )
                            : const SizedBox(),
                        box.read('user') == 'main admin'
                            ? isLargeScreen
                                ? ListTile(
                                    onTap: () {
                                      setState(() {
                                        isHome = false;
                                        isDashboard = true;
                                        isInfo = false;
                                        isProfile = false;
                                        isRole = false;
                                        isUser = false;
                                        isAnalytics = false;
                                        isHistory = false;
                                      });
                                    },
                                    leading: Icon(
                                      Icons.dashboard,
                                      color: isDashboard
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    title: TextRegular(
                                      text: 'Admin Dashboard',
                                      fontSize: 16,
                                      color: isDashboard
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHome = false;
                                          isDashboard = true;
                                          isInfo = false;
                                          isProfile = false;
                                          isRole = false;
                                          isUser = false;
                                          isAnalytics = false;
                                          isHistory = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.dashboard,
                                        color: isDashboard
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                  )
                            : const SizedBox(),
                        box.read('user') == 'main admin'
                            ? isLargeScreen
                                ? ListTile(
                                    onTap: () {
                                      setState(() {
                                        isHome = false;
                                        isDashboard = false;
                                        isInfo = false;
                                        isProfile = false;
                                        isRole = false;
                                        isUser = true;
                                        isAnalytics = false;
                                        isHistory = false;
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
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHome = false;
                                          isDashboard = false;
                                          isInfo = false;
                                          isProfile = false;
                                          isRole = false;
                                          isUser = true;
                                          isAnalytics = false;
                                          isHistory = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.person,
                                        color:
                                            isUser ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                  )
                            : const SizedBox(),
                        box.read('user') == 'main admin'
                            ? isLargeScreen
                                ? ListTile(
                                    onTap: () {
                                      setState(() {
                                        isHome = false;
                                        isDashboard = false;
                                        isInfo = false;
                                        isProfile = false;
                                        isRole = true;
                                        isUser = false;
                                        isAnalytics = false;
                                        isHistory = false;
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
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHome = false;
                                          isDashboard = false;
                                          isInfo = false;
                                          isProfile = false;
                                          isRole = true;
                                          isUser = false;
                                          isAnalytics = false;
                                          isHistory = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.work_outline,
                                        color:
                                            isRole ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                  )
                            : const SizedBox(),
                        isLargeScreen
                            ? ListTile(
                                onTap: () {
                                  setState(() {
                                    isHome = false;
                                    isDashboard = false;
                                    isInfo = true;
                                    isProfile = false;
                                    isRole = false;
                                    isUser = false;
                                    isAnalytics = false;
                                    isHistory = false;
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
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isHome = false;
                                      isDashboard = false;
                                      isInfo = true;
                                      isProfile = false;
                                      isRole = false;
                                      isUser = false;
                                      isAnalytics = false;
                                      isHistory = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.info,
                                    color: isInfo ? Colors.blue : Colors.grey,
                                  ),
                                ),
                              )
                      ],
                    ),
                    isLargeScreen
                        ? ExpansionTile(
                            trailing: const SizedBox(),
                            title: TextBold(
                              text: 'Account',
                              fontSize: isLargeScreen ? 18 : 14,
                              color: Colors.grey,
                            ),
                          )
                        : const SizedBox(),
                    isLargeScreen
                        ? ListTile(
                            onTap: () {
                              setState(() {
                                isHome = false;
                                isDashboard = false;
                                isInfo = false;
                                isProfile = true;
                                isRole = false;
                                isUser = false;
                                isAnalytics = false;
                                isHistory = false;
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
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: isLargeScreen ? 0 : 15,
                                top: 10,
                                bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHome = false;
                                  isDashboard = false;
                                  isInfo = false;
                                  isProfile = true;
                                  isRole = false;
                                  isUser = false;
                                  isAnalytics = false;
                                  isHistory = false;
                                });
                              },
                              child: Icon(
                                Icons.person,
                                color: isProfile ? Colors.blue : Colors.grey,
                              ),
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
                        title: isLargeScreen
                            ? TextRegular(
                                text: 'Logout',
                                fontSize: isLargeScreen ? 16 : 12,
                                color: Colors.grey,
                              )
                            : const SizedBox()),
                  ],
                ),
              ),
            ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLargeScreen
              ? Container(
                  color: Colors.grey[200],
                  width: isLargeScreen ? 400 : 150,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            isLargeScreen
                                ? Image.asset(
                                    'assets/images/logo.png',
                                    height: isLargeScreen ? 100 : 75,
                                  )
                                : Center(
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      height: isLargeScreen ? 100 : 75,
                                    ),
                                  ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBold(
                                  text: 'MACPENAS',
                                  fontSize: isLargeScreen ? 28 : 0,
                                  color: Colors.blue,
                                ),
                                TextRegular(
                                  text: 'Malaybalay City, Bukidnon',
                                  fontSize: isLargeScreen ? 14 : 0,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: isLargeScreen ? 50 : 10,
                        ),
                        ExpansionTile(
                          title: TextBold(
                            text: isLargeScreen ? 'Main Menu' : 'Menu',
                            fontSize: isLargeScreen ? 18 : 12,
                            color: Colors.grey,
                          ),
                          children: [
                            box.read('user') != 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = true;
                                            isDashboard = false;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = false;
                                            isUser = false;
                                            isAnalytics = false;
                                            isHistory = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.home,
                                          color: isHome
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'Home',
                                          fontSize: 16,
                                          color: isHome
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = true;
                                              isDashboard = false;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = false;
                                              isAnalytics = false;
                                              isHistory = false;
                                              isUser = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.home,
                                            color: isHome
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            box.read('user') == 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = false;
                                            isDashboard = true;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = false;
                                            isUser = false;
                                            isAnalytics = false;
                                            isHistory = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.dashboard,
                                          color: isDashboard
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'Admin Dashboard',
                                          fontSize: 16,
                                          color: isDashboard
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = false;
                                              isDashboard = true;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = false;
                                              isUser = false;
                                              isAnalytics = false;
                                              isHistory = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.dashboard,
                                            color: isDashboard
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            box.read('user') == 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = false;
                                            isDashboard = false;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = false;
                                            isUser = true;
                                            isAnalytics = false;
                                            isHistory = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.person,
                                          color: isUser
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'User Management',
                                          fontSize: 16,
                                          color: isUser
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = false;
                                              isDashboard = false;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = false;
                                              isUser = true;
                                              isAnalytics = false;
                                              isHistory = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.person,
                                            color: isUser
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            box.read('user') == 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = false;
                                            isDashboard = false;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = true;
                                            isAnalytics = false;
                                            isHistory = false;
                                            isUser = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.work_outline,
                                          color: isRole
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'Role Management',
                                          fontSize: 16,
                                          color: isRole
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = false;
                                              isDashboard = false;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = true;
                                              isAnalytics = false;
                                              isHistory = false;
                                              isUser = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.work_outline,
                                            color: isRole
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            box.read('user') == 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = false;
                                            isDashboard = false;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = false;
                                            isAnalytics = true;
                                            isHistory = false;
                                            isUser = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.analytics,
                                          color: isAnalytics
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'Analytics',
                                          fontSize: 16,
                                          color: isAnalytics
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = false;
                                              isDashboard = false;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = false;
                                              isAnalytics = true;
                                              isHistory = false;
                                              isUser = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.analytics,
                                            color: isAnalytics
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            box.read('user') == 'main admin'
                                ? isLargeScreen
                                    ? ListTile(
                                        onTap: () {
                                          setState(() {
                                            isHome = false;
                                            isDashboard = false;
                                            isInfo = false;
                                            isProfile = false;
                                            isRole = false;
                                            isAnalytics = false;
                                            isHistory = true;
                                            isUser = false;
                                          });
                                        },
                                        leading: Icon(
                                          Icons.history,
                                          color: isHistory
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        title: TextRegular(
                                          text: 'History',
                                          fontSize: 16,
                                          color: isHistory
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHome = false;
                                              isDashboard = false;
                                              isInfo = false;
                                              isProfile = false;
                                              isRole = false;
                                              isAnalytics = false;
                                              isHistory = true;
                                              isUser = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.history,
                                            color: isHistory
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            isLargeScreen
                                ? ListTile(
                                    onTap: () {
                                      setState(() {
                                        isAnalytics = false;
                                        isHistory = false;
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
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isAnalytics = false;
                                          isHistory = false;
                                          isHome = false;
                                          isDashboard = false;
                                          isInfo = true;
                                          isProfile = false;
                                          isRole = false;
                                          isUser = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.info,
                                        color:
                                            isInfo ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        isLargeScreen
                            ? ExpansionTile(
                                trailing: const SizedBox(),
                                title: TextBold(
                                  text: 'Account',
                                  fontSize: isLargeScreen ? 18 : 14,
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox(),
                        isLargeScreen
                            ? ListTile(
                                onTap: () {
                                  setState(() {
                                    isAnalytics = false;
                                    isHistory = false;
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
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: isLargeScreen ? 0 : 15,
                                    top: 10,
                                    bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAnalytics = false;
                                      isHistory = false;
                                      isHome = false;
                                      isDashboard = false;
                                      isInfo = false;
                                      isProfile = true;
                                      isRole = false;
                                      isUser = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.person,
                                    color:
                                        isProfile ? Colors.blue : Colors.grey,
                                  ),
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
                                          style:
                                              TextStyle(fontFamily: 'QRegular'),
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
                            title: isLargeScreen
                                ? TextRegular(
                                    text: 'Logout',
                                    fontSize: isLargeScreen ? 16 : 12,
                                    color: Colors.grey,
                                  )
                                : const SizedBox()),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
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
                                  : isAnalytics
                                      ? const AnalyticsPage()
                                      : const HistoryPage()
        ],
      ),
    );
  }
}
