import 'package:flutter/material.dart';
import 'profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  String? usernameError;
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    final user = Profile.currentUser!;
    usernameController = TextEditingController(text: user.name);
    passwordController = TextEditingController(text: user.password);
  }

  @override
  Widget build(BuildContext context) {
    final user = Profile.currentUser!;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person),
                errorText: usernameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              enabled: isEditing,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                errorText: passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(isEditing ? 'Save' : 'Edit'),
              onPressed: () {
                if (isEditing) {
                  setState(() {
                    // Reset errors
                    usernameError = null;
                    emailError = null;

                    bool hasError = false;

                    if (usernameController.text.isEmpty) {
                      usernameError = "Username is required";
                      hasError = true;
                    }

                    if (passwordController.text.isEmpty) {
                      passwordError = "Password is required";
                      hasError = true;
                    }

                    if (!hasError) {
                      user.name = usernameController.text;
                      user.password = passwordController.text;
                      isEditing = false;
                    }
                  });
                } else {
                  setState(() {
                    isEditing = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
