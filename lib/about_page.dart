import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mad_project_test/profile/profile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Helper function to launch email
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailUri);
  }

  // Helper function to launch phone dialer
  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(phoneUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('About Us'),
            Text(
              Profile.currentUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.food_bank_rounded,
                      size: 100, color: Colors.indigo),
                  SizedBox(height: 12),
                  Text(
                    'Grub',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Order food efficiently in a rush and discover new options',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Company Info Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Company Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.business_center_rounded,
                            color: Colors.indigo),
                        SizedBox(width: 8),
                        Text('Grub Pte Ltd', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _launchEmail('fakeemail@grub.sg');
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.email, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text('fakeemail@grub.sg',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _launchPhone('+65 90922171');
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.phone, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text('+65 90922171',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Developer Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.person, size: 30, color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Developer: Garian Chung',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
