import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    //context.go(Routes.login.path);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header với Avatar và Tên người dùng
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown, Colors.brown],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.displayName ?? "User Name",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat("Planned", "216"),
                      const SizedBox(width: 20),
                      _buildStat("Completed", "512"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Danh sách các mục
            _buildMenuItem(Icons.checklist, "Today's goals"),
            _buildMenuItem(Icons.directions_run, "Activity"),
            _buildMenuItem(Icons.settings, "Settings"),
            _buildMenuItem(Icons.contact_mail, "Contact us"),
            _buildMenuItem(Icons.help_outline, "Help & Support"),

            // Nút Logout
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _logout(context),
              child: const Text("Log out", style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown, width: 3),
          borderRadius: BorderRadius.circular(12),

        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.brown, size: 30,),
          title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.brown),
          onTap: () {
            // Xử lý khi nhấn vào từng mục
          },
        ),
      ),
    );
  }
}
