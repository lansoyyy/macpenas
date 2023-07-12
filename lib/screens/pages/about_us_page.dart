import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1025,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          opacity: 150.0,
          image: AssetImage('assets/images/back.jpg'),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'MACPENAS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QBold',
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: 500,
              child: Text(
                'We are a team of dedicated professionals who are responsible for helping the PNP to maintain Peace and Order here in Malaybalay City. Our mission is to help the Philippine National Police of Malaybalay City to quickly monitor illegal activities',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, fontFamily: 'QRegular', color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Us',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QBold',
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Phone: (123) 456-7890',
              style: TextStyle(
                  fontSize: 16, fontFamily: 'QBold', color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: sampleaccount@.example.com',
              style: TextStyle(
                  fontSize: 16, fontFamily: 'QBold', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
