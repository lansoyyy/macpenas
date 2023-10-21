import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macpenas/widgets/text_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  final scrollController = ScrollController();

  List<String> crimeTypes = [
    "Attempt Homicide",
    "Kidnapping",
    "Theft",
    "Carnapping",
    "Act of Lasciviousness",
    "Attempt Murder",
    "Others"
  ];

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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
                      .where('brgy', isEqualTo: type)
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
                    return Card(
                      child: SizedBox(
                          width: double.infinity,
                          height: 350,
                          child: SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(),
                            series: <BarSeries<SalesData, String>>[
                              // Use BarSeries instead of LineSeries
                              BarSeries<SalesData, String>(
                                // Bind data source
                                dataSource: <SalesData>[
                                  for (int i = 0; i < crimeTypes.length; i++)
                                    SalesData(
                                      crimeTypes[i],
                                      data.docs
                                          .where((number) =>
                                              number['type'] == crimeTypes[i])
                                          .toList()
                                          .length
                                          .toDouble(),
                                    ),
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                              ),
                            ],
                          )),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Level of Risk', fontSize: 18, color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < types.length; i++)
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Reports')
                                .where('brgy', isEqualTo: types[i])
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  )),
                                );
                              }

                              final data = snapshot.requireData;

                              return data.docs.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextBold(
                                                      text: data.docs.length
                                                          .toString(),
                                                      fontSize: 24,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextBold(
                                                        text: data.docs.length <
                                                                5
                                                            ? 'Low Risk'
                                                            : data.docs.length >
                                                                        5 &&
                                                                    data.docs
                                                                            .length <
                                                                        10
                                                                ? 'Medium Risk'
                                                                : 'High Risk',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextBold(
                                                      text: types[i],
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                    ],
                  ),
                ),
              ),
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
