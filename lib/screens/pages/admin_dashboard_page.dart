import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../widgets/text_widget.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1025,
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
                child: TextBold(
                  text: 'Malaybalay Police Station',
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 500,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(8.1479, 125.1321),
                zoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ),
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
                padding: const EdgeInsets.only(top: 20, left: 20),
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
                            SizedBox(
                              width: 300,
                              height: 150,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Image.asset(
                                        'assets/images/profile.png',
                                        height: 50,
                                      ),
                                      title: TextBold(
                                          text: 'Incident Type',
                                          fontSize: 14,
                                          color: Colors.black),
                                      subtitle: TextRegular(
                                          text: 'Reporter Name',
                                          fontSize: 12,
                                          color: Colors.grey),
                                      trailing: const Icon(Icons.check_box),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const VerticalDivider(),
                        const SizedBox(
                          width: 20,
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
                            SizedBox(
                              width: 300,
                              height: 150,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Image.asset(
                                        'assets/images/profile.png',
                                        height: 50,
                                      ),
                                      title: TextBold(
                                          text: 'Incident Type',
                                          fontSize: 14,
                                          color: Colors.black),
                                      subtitle: TextRegular(
                                          text: 'Reporter Name',
                                          fontSize: 12,
                                          color: Colors.grey),
                                      trailing: const Icon(Icons
                                          .check_box_outline_blank_outlined),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}