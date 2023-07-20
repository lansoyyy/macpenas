import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isLargeScreen = screenWidth >= 600;
    return Container(
      width: isLargeScreen ? 1025 : 350,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            opacity: 150.0,
            image: AssetImage(
              'assets/images/back.jpg',
            ),
            fit: BoxFit.cover),
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
            SizedBox(
              width: isLargeScreen ? 500 : 400,
              child: Text(
                'We are a team of dedicated professionals who are responsible for helping the PNP to maintain Peace and Order here in Malaybalay City. Our mission is to help the Philippine National Police of Malaybalay City to quickly monitor illegal activities',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: isLargeScreen ? 16 : 13,
                    fontFamily: 'QRegular',
                    color: Colors.white),
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
