// Log in page working properly 

import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'home_screen.dart';
// LoginScreen handles user authentication (Login)
// It verifies user credentials using Firebase Authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
// Stateful widget to manage login form and UI state
class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF241a7f), Color(0xFF141220)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.hub_outlined, size: 80, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _email,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputStyle("Email", Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!value.contains('@')) {
                        return 'Email must contain @';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pass,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputStyle("Password", Icons.lock),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: _loading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _loading = true);
                                try {
                                  await FirebaseService().login(
                                    _email.text,
                                    _pass.text,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Successful'),
                                    ),
                                  );
                                  _email.clear();
                                  _pass.clear();
                                  // Navigate to HomeScreen after successful login
                                  if (context.mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                                      (route) => false,
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Failed'),
                                    ),
                                  );
                                } finally {
                                  setState(() => _loading = false);
                                }
                              }
                            },
                      child: _loading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Login",
                              style: TextStyle(color: Color(0xFF241a7f)),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String hint, IconData icon) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.white54),
    prefixIcon: Icon(icon, color: Colors.white54),
    filled: true,
    fillColor: Colors.white.withOpacity(0.1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  );
}
