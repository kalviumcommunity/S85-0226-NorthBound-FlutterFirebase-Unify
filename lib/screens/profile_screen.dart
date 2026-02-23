import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCXaHZSNGxvDB5yoh6v6MsoZ-rQkb8W9NQqsXy74UZ-BVJRyXP_YDKhMnbGKNiMgQohQijyKSBJTJXoWtncLERE1GtjxdGXBFeLOUwbyM2PIauUlNpKq_Tna-p68wDsoQsEwR0PzDMr75AAtf1A5GtE7SQIJgPiG10nJgcvY9RmVraRAmL3y5X7hKf6lQ5sJ3bkG9Rz_7V5vvOeqmPpyNKHCCtaTDwVSDMsdRudZwXgIQw1BcfjwvwBGKwaMR7iYZhPxkw9pg5x74M'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Alex Johnson",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Computer Science Student",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Account Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF241A7F)),
            ),
            const SizedBox(height: 16),
            _buildProfileOption(icon: Icons.school_outlined, title: "My College", subtitle: "Maple Creek University"),
            _buildProfileOption(icon: Icons.email_outlined, title: "Email", subtitle: "alex.j@university.edu"),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => FirebaseService().logout(),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF241A7F),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
