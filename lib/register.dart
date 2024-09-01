import 'package:flutter/material.dart';
import 'package:live/login.dart';
import 'package:live/services/auth_service.dart';
import 'package:live/widgets/round_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>(); // Add this line
  bool loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('./assets/img.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [Colors.white60, Colors.black87],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Register'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 218, 20, 20),
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey, // Associate the key with the form
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter username';
                            }
                            return null;
                          },
                          controller: _userNameController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18.0)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter email';
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18.0)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFedf0f8),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18.0)),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                RoundButton(
                  title: "Sign Up",
                  loading: loading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // Validate form
                      setState(() {
                        loading = true;
                      });
                      await AuthService().signup(
                        // username: _userNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
