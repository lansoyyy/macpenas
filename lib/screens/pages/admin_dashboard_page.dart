import 'dart:async';
import 'dart:collection';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:badges/badges.dart' as b;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:just_audio/just_audio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../utils/const.dart';
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

  final box = GetStorage();

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = kGoogleApiKey;

  @override
  void initState() {
    super.initState();

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        hasLoaded = true;

        _markers.add(Marker(
            markerId: const MarkerId('myId'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Your location')));
        // myCircles.add(
        //   CircleMarker(
        //       point: LatLng(position.latitude, position.longitude),
        //       radius: 5,
        //       borderStrokeWidth: 1,
        //       borderColor: Colors.black,
        //       useRadiusInMeter: true,
        //       color: Colors.blue),
        // );
      });
      // getDirections(LatLng(position.latitude, position.longitude),
      //     LatLng(8.306295, 124.992959));
    }).catchError((error) {
      print('Error getting location: $error');
    });
  }

  // late List<CircleMarker> myCircles = [];

  GoogleMapController? mapController;

  final latController = TextEditingController();
  final longController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Polyline> _poly = [];

  final scrollController = ScrollController();

  String newUrl = '';
  Set<Polygon> polygon = HashSet<Polygon>();
  update(String docId) async {
    Timer.periodic(const Duration(seconds: 60), (timer) {
      Geolocator.getCurrentPosition().then((position) async {
        _markers.clear();
        _poly.clear();

        _markers.add(Marker(
            markerId: const MarkerId('myId'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Your location')));

        // setState(() {
        //   myPoly.clear();
        //   myCircles.clear();

        //   myCircles.add(
        //     CircleMarker(
        //         point: LatLng(position.latitude, position.longitude),
        //         radius: 5,
        //         borderStrokeWidth: 1,
        //         borderColor: Colors.black,
        //         useRadiusInMeter: true,
        //         color: Colors.blue),
        //   );

        //   // mapController.move(LatLng(position.latitude, position.longitude), 18);

        lat = position.latitude;
        long = position.longitude;
        // });
        FirebaseFirestore.instance
            .collection('Reports')
            .where('id', isEqualTo: docId)
            .get()
            .then((QuerySnapshot querySnapshot) async {
          for (var doc in querySnapshot.docs) {
            print('here');
            try {
              PolylineResult result =
                  await polylinePoints.getRouteBetweenCoordinates(
                      'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
                      PointLatLng(position.latitude, position.longitude),
                      PointLatLng(doc['lat'], doc['long']));

              if (result.points.isNotEmpty) {
                polylineCoordinates = result.points
                    .map((point) => LatLng(point.latitude, point.longitude))
                    .toList();
              }
            } catch (e) {
              print('error $e');
            }

            _poly.add(Polyline(
                color: Colors.red,
                polylineId: PolylineId(doc['name']),
                points: [
                  LatLng(position.latitude, position.longitude),
                  const LatLng(8.1479, 125.1321)
                ],
                width: 4));

            _markers.add(Marker(
                markerId: MarkerId(doc['name']),
                position: LatLng(doc['lat'], doc['long']),
                infoWindow: InfoWindow(
                    title: doc['name'],
                    snippet: box.read('user') == 'intelligence'
                        ? ''
                        : '${doc['type']} - ${doc['contactNumber']} - Reporter is a ${doc['reporterType']} - ${DateFormat.yMMMd().add_jm().format(doc['dateTime'].toDate())}')));
            setState(() {});
          }
        });
      }).catchError((error) {
        print('Error getting location: $error');
      });
    });
  }

  final List<Marker> _markers = <Marker>[];

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;

    CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(8.1479, 125.1321),
      zoom: 14,
    );

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
                                    .where('status', isNotEqualTo: 'Completed')
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

                                  if (data.docs.isNotEmpty) {
                                    try {
                                      AssetsAudioPlayer.newPlayer().open(
                                        Audio(
                                            "assets/images/videoplayback.m4a"),
                                        autoStart: true,
                                        showNotification: true,
                                      );
                                    } catch (e) {
                                      print(e);
                                    }

                                    print('eee');
                                    // Audio here
                                  }
                                  return IconButton(
                                    onPressed: () async {
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
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          update(data
                                                              .docs[index].id);
                                                          mapController!.animateCamera(
                                                              CameraUpdate.newCameraPosition(CameraPosition(
                                                                  zoom: 14,
                                                                  target: LatLng(
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'lat'],
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'long']))));
                                                        },
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
                    stream: box.read('user') != 'intelligence'
                        ? box.read('user') == 'main admin'
                            ? FirebaseFirestore.instance
                                .collection('Reports')
                                .where('status', isNotEqualTo: 'Completed')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('Reports')
                                .where('status', isEqualTo: 'Pending')
                                .snapshots()
                        : FirebaseFirestore.instance
                            .collection('Reports')
                            .where('status', isEqualTo: 'Forwarded')
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
                          height: 400,
                          child: GoogleMap(
                            polylines: Set<Polyline>.of(_poly),
                            markers: Set<Marker>.of(_markers),
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            polygons: polygon,
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: initialCameraPosition,
                          ),
                        ),
                      );
                    }),
                Container(
                  width: double.infinity,
                  height: 275,
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
                          Scrollbar(
                            controller: scrollController,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  box.read('user') == 'intelligence'
                                      ? const SizedBox()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('Reports')
                                                    .where('trig',
                                                        isEqualTo: true)
                                                    .where('status',
                                                        whereNotIn: [
                                                      'Forwarded',
                                                      'Completed',
                                                      'Patrol',
                                                      'Forwarded to Admin',
                                                      'Cancelled'
                                                    ]).snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    print(snapshot.error);
                                                    return const Center(
                                                        child: Text('Error'));
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 50),
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: Colors.black,
                                                      )),
                                                    );
                                                  }

                                                  final data =
                                                      snapshot.requireData;
                                                  return SizedBox(
                                                    width: isLargeScreen
                                                        ? 300
                                                        : 200,
                                                    height: 100,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          data.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                            onTap: () {
                                                              update(data
                                                                  .docs[index]
                                                                  .id);
                                                              mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                                  zoom: 14,
                                                                  target: LatLng(
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'lat'],
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'long']))));

                                                              setState(() {
                                                                _markers.add(Marker(
                                                                    markerId: MarkerId(data
                                                                            .docs[index]
                                                                        ['id']),
                                                                    position: LatLng(
                                                                        data.docs[index]
                                                                            [
                                                                            'lat'],
                                                                        data.docs[index]
                                                                            [
                                                                            'long']),
                                                                    infoWindow:
                                                                        InfoWindow(
                                                                            title:
                                                                                data.docs[index]['name'])));
                                                              });
                                                            },
                                                            leading:
                                                                isLargeScreen
                                                                    ? Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                    content: Image.network(data.docs[index]['img']),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                TextRegular(
                                                                              text: 'View proof',
                                                                              fontSize: 12,
                                                                              color: Colors.blue,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : null,
                                                            title: TextBold(
                                                                text: data.docs[
                                                                        index]
                                                                    ['type'],
                                                                fontSize:
                                                                    isLargeScreen
                                                                        ? 14
                                                                        : 12,
                                                                color:
                                                                    Colors.red),
                                                            subtitle: TextRegular(
                                                                text: data.docs[
                                                                        index]
                                                                    ['name'],
                                                                fontSize:
                                                                    isLargeScreen
                                                                        ? 12
                                                                        : 10,
                                                                color: Colors
                                                                    .grey),
                                                            trailing: SizedBox(
                                                              width: 75,
                                                              child: Row(
                                                                children: [
                                                                  box.read('user') ==
                                                                          'main admin'
                                                                      ? data.docs[index]['status'] !=
                                                                              'Forwarded'
                                                                          ? IconButton(
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => AlertDialog(
                                                                                          title: const Text(
                                                                                            'Confirmation',
                                                                                            style: TextStyle(fontFamily: 'QBold', fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          content: SizedBox(
                                                                                            height: 500,
                                                                                            width: 300,
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Forward to Intelligence:',
                                                                                                  style: TextStyle(fontFamily: 'QRegular'),
                                                                                                ),
                                                                                                StreamBuilder<QuerySnapshot>(
                                                                                                    stream: FirebaseFirestore.instance.collection('Users').where('role', isEqualTo: 'intelligence').snapshots(),
                                                                                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                                                                                                      final new1 = snapshot.requireData;
                                                                                                      return SizedBox(
                                                                                                        height: 200,
                                                                                                        child: ListView.builder(
                                                                                                          itemCount: new1.docs.length,
                                                                                                          itemBuilder: (context, index) {
                                                                                                            return ListTile(
                                                                                                              onTap: () async {
                                                                                                                await FirebaseFirestore.instance.collection('Reports').doc(data.docs[index].id).update({
                                                                                                                  'status': 'Forwarded',
                                                                                                                  'patrol': new1.docs[index]['name'],
                                                                                                                  'patrolid': new1.docs[index].id,
                                                                                                                });
                                                                                                                Navigator.pop(context);
                                                                                                              },
                                                                                                              leading: const Icon(
                                                                                                                Icons.account_circle_outlined,
                                                                                                              ),
                                                                                                              title: TextRegular(text: new1.docs[index]['name'], fontSize: 14, color: Colors.black),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      );
                                                                                                    }),
                                                                                                const Text(
                                                                                                  'Forward to Admin:',
                                                                                                  style: TextStyle(fontFamily: 'QRegular'),
                                                                                                ),
                                                                                                StreamBuilder<QuerySnapshot>(
                                                                                                    stream: FirebaseFirestore.instance.collection('Users').where('role', isEqualTo: 'admin').snapshots(),
                                                                                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                                                                                                      final new1 = snapshot.requireData;
                                                                                                      return SizedBox(
                                                                                                        height: 200,
                                                                                                        child: ListView.builder(
                                                                                                          itemCount: new1.docs.length,
                                                                                                          itemBuilder: (context, index) {
                                                                                                            return ListTile(
                                                                                                              onTap: () async {
                                                                                                                await FirebaseFirestore.instance.collection('Reports').doc(data.docs[index].id).update({
                                                                                                                  'status': 'Forwarded to Admin',
                                                                                                                  'patrol': new1.docs[index]['name'],
                                                                                                                  'patrolid': new1.docs[index].id,
                                                                                                                });
                                                                                                                Navigator.pop(context);
                                                                                                              },
                                                                                                              leading: const Icon(
                                                                                                                Icons.account_circle_outlined,
                                                                                                              ),
                                                                                                              title: TextRegular(text: new1.docs[index]['name'], fontSize: 14, color: Colors.black),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      );
                                                                                                    }),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ));
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.forward,
                                                                                color: Colors.blue,
                                                                              ),
                                                                            )
                                                                          : const SizedBox()
                                                                      : const SizedBox()
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBold(
                                        text: 'Forwarded to\nIntelligence',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: box.read('user') ==
                                                  'intelligence'
                                              ? FirebaseFirestore.instance
                                                  .collection('Reports')
                                                  .where('patrolid',
                                                      isEqualTo: FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid)
                                                  .snapshots()
                                              : FirebaseFirestore.instance
                                                  .collection('Reports')
                                                  .where('trig',
                                                      isEqualTo: true)
                                                  .where('status',
                                                      isEqualTo: 'Forwarded')
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
                                                padding:
                                                    EdgeInsets.only(top: 50),
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
                                              height: 100,
                                              child: ListView.builder(
                                                itemCount: data.docs.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        update(data
                                                            .docs[index].id);
                                                        mapController!.animateCamera(
                                                            CameraUpdate.newCameraPosition(CameraPosition(
                                                                zoom: 14,
                                                                target: LatLng(
                                                                    data.docs[
                                                                            index]
                                                                        ['lat'],
                                                                    data.docs[
                                                                            index]
                                                                        [
                                                                        'long']))));

                                                        setState(() {
                                                          _markers.add(Marker(
                                                              markerId: MarkerId(
                                                                  data.docs[index]
                                                                      ['id']),
                                                              position: LatLng(
                                                                  data.docs[index]
                                                                      ['lat'],
                                                                  data.docs[
                                                                          index]
                                                                      ['long']),
                                                              infoWindow: InfoWindow(
                                                                  title: data.docs[
                                                                          index]
                                                                      ['name'])));
                                                        });
                                                      },
                                                      leading: isLargeScreen
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              Image.network(data.docs[index]['img']),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      TextRegular(
                                                                    text:
                                                                        'View proof',
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : null,
                                                      title: TextBold(
                                                          text: data.docs[index]
                                                              ['type'],
                                                          fontSize:
                                                              isLargeScreen
                                                                  ? 14
                                                                  : 12,
                                                          color: Colors.black),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextRegular(
                                                              text: data.docs[
                                                                      index]
                                                                  ['name'],
                                                              fontSize:
                                                                  isLargeScreen
                                                                      ? 12
                                                                      : 10,
                                                              color:
                                                                  Colors.grey),
                                                          TextRegular(
                                                              text: data.docs[
                                                                      index]
                                                                  ['patrol'],
                                                              fontSize:
                                                                  isLargeScreen
                                                                      ? 12
                                                                      : 10,
                                                              color:
                                                                  Colors.grey),
                                                        ],
                                                      ),
                                                      // trailing: IconButton(
                                                      //     onPressed: () async {
                                                      //       await FirebaseFirestore
                                                      //           .instance
                                                      //           .collection(
                                                      //               'Reports')
                                                      //           .doc(data
                                                      //               .docs[index].id)
                                                      //           .update({
                                                      //         'status': 'Pending'
                                                      //       });
                                                      //     },
                                                      //     icon: const Icon(
                                                      //         Icons.check_box)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  box.read('user') == 'intelligence'
                                      ? const SizedBox()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextBold(
                                              text: 'On the way',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('Reports')
                                                    .where('trig',
                                                        isEqualTo: true)
                                                    .where('status',
                                                        isEqualTo:
                                                            'Forwarded to Admin')
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    print(snapshot.error);
                                                    return const Center(
                                                        child: Text('Error'));
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 50),
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: Colors.black,
                                                      )),
                                                    );
                                                  }

                                                  final data =
                                                      snapshot.requireData;
                                                  return SizedBox(
                                                    width: isLargeScreen
                                                        ? 300
                                                        : 200,
                                                    height: 100,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          data.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                            onTap: () {
                                                              update(data
                                                                  .docs[index]
                                                                  .id);
                                                              mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                                  zoom: 14,
                                                                  target: LatLng(
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'lat'],
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'long']))));

                                                              setState(() {
                                                                _markers.add(Marker(
                                                                    markerId: MarkerId(data
                                                                            .docs[index]
                                                                        ['id']),
                                                                    position: LatLng(
                                                                        data.docs[index]
                                                                            [
                                                                            'lat'],
                                                                        data.docs[index]
                                                                            [
                                                                            'long']),
                                                                    infoWindow:
                                                                        InfoWindow(
                                                                            title:
                                                                                data.docs[index]['name'])));
                                                              });
                                                            },
                                                            leading:
                                                                isLargeScreen
                                                                    ? Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                    content: Image.network(data.docs[index]['img']),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                TextRegular(
                                                                              text: 'View proof',
                                                                              fontSize: 12,
                                                                              color: Colors.blue,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : null,
                                                            title: TextBold(
                                                                text: data.docs[
                                                                        index]
                                                                    ['type'],
                                                                fontSize:
                                                                    isLargeScreen
                                                                        ? 14
                                                                        : 12,
                                                                color: Colors
                                                                    .black),
                                                            subtitle: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextRegular(
                                                                    text: data.docs[
                                                                            index]
                                                                        [
                                                                        'name'],
                                                                    fontSize:
                                                                        isLargeScreen
                                                                            ? 12
                                                                            : 10,
                                                                    color: Colors
                                                                        .black),
                                                                TextRegular(
                                                                    text: data.docs[
                                                                            index]
                                                                        [
                                                                        'patrol'],
                                                                    fontSize:
                                                                        isLargeScreen
                                                                            ? 12
                                                                            : 10,
                                                                    color: Colors
                                                                        .grey),
                                                              ],
                                                            ),
                                                            trailing:
                                                                IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Reports')
                                                                          .doc(data
                                                                              .docs[
                                                                                  index]
                                                                              .id)
                                                                          .update({
                                                                        'status':
                                                                            'Completed'
                                                                      });
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .check_box_outline_blank_outlined)),
                                                            // trailing: IconButton(
                                                            //     onPressed: () async {
                                                            //       await FirebaseFirestore
                                                            //           .instance
                                                            //           .collection(
                                                            //               'Reports')
                                                            //           .doc(data
                                                            //               .docs[index].id)
                                                            //           .update({
                                                            //         'status': 'Pending'
                                                            //       });
                                                            //     },
                                                            //     icon: const Icon(
                                                            //         Icons.check_box)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              .where('trig', isEqualTo: true)
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
                                                padding:
                                                    EdgeInsets.only(top: 50),
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
                                              height: 100,
                                              child: ListView.builder(
                                                itemCount: data.docs.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        update(data
                                                            .docs[index].id);
                                                        mapController!.animateCamera(
                                                            CameraUpdate.newCameraPosition(CameraPosition(
                                                                zoom: 14,
                                                                target: LatLng(
                                                                    data.docs[
                                                                            index]
                                                                        ['lat'],
                                                                    data.docs[
                                                                            index]
                                                                        [
                                                                        'long']))));

                                                        setState(() {
                                                          _markers.add(Marker(
                                                              markerId: MarkerId(
                                                                  data.docs[index]
                                                                      ['id']),
                                                              position: LatLng(
                                                                  data.docs[index]
                                                                      ['lat'],
                                                                  data.docs[
                                                                          index]
                                                                      ['long']),
                                                              infoWindow: InfoWindow(
                                                                  title: data.docs[
                                                                          index]
                                                                      ['name'])));
                                                        });
                                                      },
                                                      leading: isLargeScreen
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                              Image.network(data.docs[index]['img']),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      TextRegular(
                                                                    text:
                                                                        'View proof',
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : null,
                                                      title: TextBold(
                                                          text: data.docs[index]
                                                              ['type'],
                                                          fontSize:
                                                              isLargeScreen
                                                                  ? 14
                                                                  : 12,
                                                          color: Colors.green),
                                                      subtitle: TextRegular(
                                                          text: data.docs[index]
                                                              ['name'],
                                                          fontSize:
                                                              isLargeScreen
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
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'status':
                                                                  'Forwarded to Admin'
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
                                ],
                              ),
                            ),
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
