import 'package:flutter/material.dart';
import 'features_page.dart'; // Import the features_page.dart file

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation
  bool _isAgreed = false; // Track the checkbox state

  void registerUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_isAgreed) {
        // Replace with backend API call
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Created Successfully')),
        );

        // Navigate to the FeaturesPage after the SnackBar is shown
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FeaturesPage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to the terms and conditions')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top image section
          SizedBox(
            height: 200, // Adjust height as needed
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/images/wall.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                ),
              ],
            ),
          ),
          // Form section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey, // Assigning the form key
                  autovalidateMode: AutovalidateMode.onUserInteraction, // Automatically validate as user types
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Create your new account',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        usernameController,
                        Icons.person,
                        'USER NAME',
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        emailController,
                        Icons.email,
                        'EMAIL ID',
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Updated email regex validation
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        passwordController,
                        Icons.lock,
                        'PASSWORD',
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      // Dynamic checkbox for agreeing to terms
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _isAgreed,
                            onChanged: (value) {
                              setState(() {
                                _isAgreed = value!;
                              });
                            },
                          ),
                          const Text(
                            'I agree to the terms and conditions',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _isAgreed ? () => registerUser(context) : null,
                        child: const Text('Proceed'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Modified _buildTextField to include validation function
  Widget _buildTextField(TextEditingController controller, IconData icon, String hintText,
      String? Function(String?) validator, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
        ),
        validator: validator, // Applying the validation function here
      ),
    );
  }
}
