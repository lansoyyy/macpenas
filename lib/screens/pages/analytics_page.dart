import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macpenas/widgets/text_widget.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({
    super.key,
  });

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  List<String> types = [
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

  String type = 'Aglayan';

  List<String> risks = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    return Container(
      width: isLargeScreen ? 1025 : 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            opacity: 150.0,
            image: AssetImage(
              'assets/images/back.jpg',
            ),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      value: type,
                      items: types.map((String item) {
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
                          type = newValue.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Level of Risk', fontSize: 18, color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
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

                    for (int i = 0; i < data.docs.length; i++) {
                      risks.add(data.docs[i]['brgy']);
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            TextBold(
                                text: 'High Risk',
                                fontSize: 16,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBold(
                                      text: 'Name of Brgy',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextRegular(
                                      text: 'Robbery: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    TextRegular(
                                      text: 'Theft: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            TextBold(
                                text: 'Medium Risk',
                                fontSize: 16,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBold(
                                      text: 'Name of Brgy',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextRegular(
                                      text: 'Robbery: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    TextRegular(
                                      text: 'Theft: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            TextBold(
                                text: 'Low Risk',
                                fontSize: 16,
                                color: Colors.black),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBold(
                                      text: 'Name of Brgy',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextRegular(
                                      text: 'Robbery: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    TextRegular(
                                      text: 'Theft: 1',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
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
}
