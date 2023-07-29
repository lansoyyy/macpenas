import 'dart:async';
import 'package:badges/badges.dart' as b;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../widgets/text_widget.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  double lat = 0;
  double long = 0;

  bool hasLoaded = false;
  final mapController = MapController();

  @override
  void initState() {
    super.initState();

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        hasLoaded = true;
        myCircles.add(
          CircleMarker(
              point: LatLng(position.latitude, position.longitude),
              radius: 5,
              borderStrokeWidth: 1,
              borderColor: Colors.black,
              useRadiusInMeter: true,
              color: Colors.blue),
        );
      });
      // getDirections(LatLng(position.latitude, position.longitude),
      //     LatLng(8.306295, 124.992959));
    }).catchError((error) {
      print('Error getting location: $error');
    });

    update();
  }

  late List<CircleMarker> myCircles = [];
  late List<Polyline> myPoly = [];
  late List<Marker> myMarker = [];

  update() async {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      Geolocator.getCurrentPosition().then((position) {
        setState(() {
          myPoly.clear();
          myCircles.clear();

          myCircles.add(
            CircleMarker(
                point: LatLng(position.latitude, position.longitude),
                radius: 5,
                borderStrokeWidth: 1,
                borderColor: Colors.black,
                useRadiusInMeter: true,
                color: Colors.blue),
          );

          mapController.move(LatLng(position.latitude, position.longitude), 18);

          lat = position.latitude;
          long = position.longitude;
        });
        FirebaseFirestore.instance
            .collection('Reports')
            .where('status', isEqualTo: 'Pending')
            .get()
            .then((QuerySnapshot querySnapshot) async {
          for (var doc in querySnapshot.docs) {
            myPoly.add(Polyline(points: [
              LatLng(position.latitude, position.longitude),
              LatLng(doc['lat'], doc['long']),
            ]));
          }
        });
      }).catchError((error) {
        print('Error getting location: $error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;

    return hasLoaded
        ? Container(
            color: Colors.white,
            width: isLargeScreen ? 1025 : 500,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBold(
                            text: 'Malaybalay Police Station',
                            fontSize: isLargeScreen ? 32 : 18,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Reports')
                                    .where('status', isEqualTo: 'Pending')
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
                                  return IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                                height: 300,
                                                width: 300,
                                                child: ListView.builder(
                                                  itemCount: data.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: ListTile(
                                                        leading: isLargeScreen
                                                            ? Image.asset(
                                                                'assets/images/profile.png',
                                                                height:
                                                                    isLargeScreen
                                                                        ? 50
                                                                        : 25,
                                                              )
                                                            : null,
                                                        title: TextBold(
                                                            text:
                                                                data.docs[index]
                                                                    ['type'],
                                                            fontSize:
                                                                isLargeScreen
                                                                    ? 14
                                                                    : 12,
                                                            color:
                                                                Colors.black),
                                                        subtitle: TextRegular(
                                                            text:
                                                                data.docs[index]
                                                                    ['name'],
                                                            fontSize:
                                                                isLargeScreen
                                                                    ? 12
                                                                    : 10,
                                                            color: Colors.grey),
                                                      ),
                                                    );
                                                  },
                                                )),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: TextBold(
                                                  text: 'Close',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: b.Badge(
                                      showBadge: data.docs.isNotEmpty,
                                      badgeAnimation:
                                          const b.BadgeAnimation.fade(),
                                      badgeStyle: const b.BadgeStyle(
                                        badgeColor: Colors.red,
                                      ),
                                      badgeContent: TextRegular(
                                          text: data.docs.length.toString(),
                                          fontSize: 12,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.notifications,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Reports')
                        .where('status', isEqualTo: 'Pending')
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

                      return Expanded(
                        child: SizedBox(
                          height: 425,
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              center: LatLng(lat, long),
                              zoom: 18.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  for (int i = 0; i < data.docs.length; i++)
                                    Marker(
                                      height: 150,
                                      width: 50,
                                      point: LatLng(data.docs[i]['lat'],
                                          data.docs[i]['long']),
                                      builder: (context) {
                                        return SizedBox(
                                          width: 300,
                                          height: 150,
                                          child: Row(
                                            children: [
                                              const SizedBox(),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 300,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20, 10, 20, 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextBold(
                                                          text: data.docs[i]
                                                              ['name'],
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextRegular(
                                                          text: data.docs[i]
                                                              ['contactNumber'],
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          height: 2.5,
                                                        ),
                                                        TextRegular(
                                                          text: data.docs[i]
                                                              ['address'],
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextBold(
                                                          text: data.docs[i]
                                                              ['type'],
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextBold(
                                                          text:
                                                              'Reporter is a ${data.docs[i]['reporterType']}',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                          height: 2.5,
                                                        ),
                                                        TextRegular(
                                                          text: DateFormat
                                                                  .yMMMd()
                                                              .add_jm()
                                                              .format(data
                                                                  .docs[i][
                                                                      'dateTime']
                                                                  .toDate()),
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                ],
                              ),
                              PolylineLayer(
                                polylines: myPoly,
                              ),
                              CircleLayer(
                                circles: myCircles,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: isLargeScreen ? 20 : 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                            text: 'Operations',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBold(
                                    text: 'Rescued',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Reports')
                                          .where('status',
                                              isEqualTo: 'Completed')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return const Center(
                                              child: Text('Error'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.black,
                                            )),
                                          );
                                        }

                                        final data = snapshot.requireData;
                                        return SizedBox(
                                          width: isLargeScreen ? 300 : 200,
                                          height: isLargeScreen ? 150 : 100,
                                          child: ListView.builder(
                                            itemCount: data.docs.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  leading: isLargeScreen
                                                      ? Image.asset(
                                                          'assets/images/profile.png',
                                                          height: isLargeScreen
                                                              ? 50
                                                              : 25,
                                                        )
                                                      : null,
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                          ['type'],
                                                      fontSize: isLargeScreen
                                                          ? 14
                                                          : 12,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: data.docs[index]
                                                          ['name'],
                                                      fontSize: isLargeScreen
                                                          ? 12
                                                          : 10,
                                                      color: Colors.grey),
                                                  trailing: IconButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Reports')
                                                            .doc(data
                                                                .docs[index].id)
                                                            .update({
                                                          'status': 'Pending'
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.check_box)),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                ],
                              ),
                              SizedBox(
                                width: isLargeScreen ? 20 : 0,
                              ),
                              const VerticalDivider(),
                              SizedBox(
                                width: isLargeScreen ? 20 : 0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBold(
                                    text: 'To Rescue',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Reports')
                                          .where('status', isEqualTo: 'Pending')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return const Center(
                                              child: Text('Error'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 50),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.black,
                                            )),
                                          );
                                        }

                                        final data = snapshot.requireData;
                                        return SizedBox(
                                          width: isLargeScreen ? 300 : 200,
                                          height: isLargeScreen ? 150 : 100,
                                          child: ListView.builder(
                                            itemCount: data.docs.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    mapController.move(
                                                        LatLng(
                                                            data.docs[index]
                                                                ['lat'],
                                                            data.docs[index]
                                                                ['long']),
                                                        18);
                                                  },
                                                  leading: isLargeScreen
                                                      ? Image.asset(
                                                          'assets/images/profile.png',
                                                          height: isLargeScreen
                                                              ? 50
                                                              : 25,
                                                        )
                                                      : null,
                                                  title: TextBold(
                                                      text: data.docs[index]
                                                          ['type'],
                                                      fontSize: isLargeScreen
                                                          ? 14
                                                          : 12,
                                                      color: Colors.black),
                                                  subtitle: TextRegular(
                                                      text: data.docs[index]
                                                          ['name'],
                                                      fontSize: isLargeScreen
                                                          ? 12
                                                          : 10,
                                                      color: Colors.grey),
                                                  trailing: IconButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Reports')
                                                            .doc(data
                                                                .docs[index].id)
                                                            .update({
                                                          'status': 'Completed'
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .check_box_outline_blank_outlined)),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
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
