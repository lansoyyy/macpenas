import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macpenas/widgets/button_widget.dart';
import 'package:macpenas/widgets/text_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String type = 'Sample';

  List<String> types = [
    'Sample',
  ];

  List brgys = [];
  List streets = [];
  List names = [];
  List emergencyTypes = [];
  List dates = [];
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
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Reports')
                          // .where('dateTime',
                          //     isGreaterThanOrEqualTo:
                          //         DateTime.parse(bdayController.text))
                          // .where('dateTime',
                          //     isLessThanOrEqualTo:
                          //         DateTime.parse(bdayController.text))
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
                        return ButtonWidget(
                          height: 35,
                          width: 100,
                          fontSize: 14,
                          label: 'PRINT',
                          onPressed: () {
                            generatePdf(data.docs);
                          },
                        );
                      }),
                  GestureDetector(
                    onTap: () {
                      halfDayDatePicker(context);
                    },
                    child: SizedBox(
                      width: 200,
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
                          errorStyle:
                              const TextStyle(fontFamily: 'Bold', fontSize: 12),
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
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBold(
                    text: DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
                      // .where('dateTime',
                      //     isGreaterThanOrEqualTo:
                      //         DateTime.parse(bdayController.text))
                      // .where('dateTime',
                      //     isLessThanOrEqualTo:
                      //         DateTime.parse(bdayController.text))
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
                    return Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: DataTable(columns: [
                          DataColumn(
                            label: TextBold(
                              text: 'Baranggay',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Street',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Emergency Type',
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
                              text: 'Date',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ], rows: [
                          for (int i = 0; i < data.docs.length; i++)
                            DataRow(cells: [
                              DataCell(
                                TextRegular(
                                  text: data.docs[i]['brgy'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextRegular(
                                  text: data.docs[i]['address'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextRegular(
                                  text: data.docs[i]['type'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextRegular(
                                  text: data.docs[i]['name'],
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              DataCell(
                                TextRegular(
                                  text: DateFormat.yMMMd().add_jm().format(
                                      data.docs[i]['dateTime'].toDate()),
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ])
                        ]),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final bdayController = TextEditingController(text: DateTime.now().toString());
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
      String formattedDate = pickedDate.toString();

      setState(() {
        bdayController.text = formattedDate;
      });
    } else {
      return null;
    }
  }

  void generatePdf(List tableDataList) async {
    final pdf = pw.Document();
    final tableHeaders = [
      'Baranggay',
      'Street',
      'Name',
      'Emergency Type',
      'Date and Time',
    ];

    String cdate1 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

    List<List<String>> tableData = [];
    for (var i = 0; i < tableDataList.length; i++) {
      tableData.add([
        tableDataList[i]['brgy'],
        tableDataList[i]['address'],
        tableDataList[i]['name'],
        tableDataList[i]['type'],
        DateFormat.yMMMd()
            .add_jm()
            .format(tableDataList[i]['dateTime'].toDate()),
      ]);
    }

    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        pageFormat: PdfPageFormat.letter,
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('MACPENAS',
                    style: const pw.TextStyle(
                      fontSize: 18,
                    )),
                pw.SizedBox(height: 10),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                  'Reports History',
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                  cdate1,
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            headerDecoration: const pw.BoxDecoration(),
            rowDecoration: const pw.BoxDecoration(),
            headerHeight: 25,
            cellHeight: 45,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
            },
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());

    final output = await getTemporaryDirectory();
    final file = io.File("${output.path}/reports.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
