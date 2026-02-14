import 'package:flutter/material.dart';
import 'about_page.dart';
import 'login_page.dart';
import 'package:mad_project_test/profile/profile.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('More Options'),
            Text(
              Profile.currentUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AboutPage()),
                );
              },
              child: const Padding(
                padding:  EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 16),
                        Text('About Us', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24,),

            InkWell(
              onTap: () {
                Profile.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Padding(
                padding:  EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 16),
                        Text('Logout', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
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
