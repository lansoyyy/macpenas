import 'package:flutter/material.dart';
import 'package:macpenas/widgets/text_widget.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1025,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextBold(
                  text: 'Welcome to Macpenas!',
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: TextBold(
                        text: 'Emergency Alert',
                        fontSize: 18,
                        color: Colors.black),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRegular(
                          text: 'Please select the type of emergency: ',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextRegular(
                                    text:
                                        'Emergency Alert Sent! Wait for further response',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            );
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: TextRegular(
                              text: 'RAPE', fontSize: 18, color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextRegular(
                                    text:
                                        'Emergency Alert Sent! Wait for further response',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            );
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: TextRegular(
                              text: 'TRAFFIC INCIDENT',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextRegular(
                                    text:
                                        'Emergency Alert Sent! Wait for further response',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            );
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: TextRegular(
                              text: 'ROBBERY',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextRegular(
                                    text:
                                        'Emergency Alert Sent! Wait for further response',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            );
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: TextRegular(
                              text: 'OTHERS',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: TextRegular(
                              text: 'CANCEL',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 125,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.campaign_rounded,
                color: Colors.white,
                size: 68,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextRegular(
            text: 'Press the Red Button to trigger Report',
            fontSize: 18,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
