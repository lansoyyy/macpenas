import 'package:flutter/material.dart';
import 'package:macpenas/widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1025,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  height: 125,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextBold(
                  text: 'Name here',
                  fontSize: 18,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                  text: 'User',
                  fontSize: 14,
                  color: Colors.grey,
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
            Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    text: 'Email',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextRegular(
                    text: 'email here',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextBold(
                    text: 'Address',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextRegular(
                    text: 'Address here',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextBold(
                    text: 'Contact Number',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextRegular(
                    text: 'Contact number here',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
