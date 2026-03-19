import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

// This screen handles both Login and Sign Up functionality
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
  // Controllers to capture user input from text fields
class _AuthScreenState extends State<AuthScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main container with gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF241a7f), Color(0xFF141220)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        // Center content vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
// App logo/icon
            const Icon(Icons.hub_outlined, size: 80, color: Colors.white),
            const SizedBox(height: 20),
// Dynamic title based on login/signup mode
            Text(_isSignUp ? "Join Unify" : "Welcome Back",
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
// Email input field
            TextField(controller: _email, decoration: _inputStyle("Email", Icons.email)),
            const SizedBox(height: 16),
// Password input field (hidden text)
            TextField(controller: _pass, obscureText: true, decoration: _inputStyle("Password", Icons.lock)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
// Calls Firebase service for authentication 
                onPressed: () => _isSignUp
                    ? FirebaseService().signUp(_email.text, _pass.text)
                    : FirebaseService().login(_email.text, _pass.text),
                child: Text(_isSignUp ? "Sign Up" : "Login", style: const TextStyle(color: Color(0xFF241a7f))),
              ),
            ),
// Toggle between Login and Sign Up modes  
            TextButton(onPressed: () => setState(() => _isSignUp = !_isSignUp),
                child: Text(_isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up",
                    style: const TextStyle(color: Colors.white70))),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String hint, IconData icon) => InputDecoration(
    hintText: hint, hintStyle: const TextStyle(color: Colors.white54),
    prefixIcon: Icon(icon, color: Colors.white54),
    filled: true, fillColor: Colors.white.withOpacity(0.1),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  );
}