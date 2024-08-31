import 'package:flutter/material.dart';
// import 'package:ilive/home.dart';
import 'package:live/register.dart';
import 'package:live/services/auth_service.dart';
import 'package:live/widgets/round_button.dart'; // Corrected the import path

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Added GlobalKey for the form

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('./assets/img2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.white54, Colors.black87],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Login'),
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
                    key: _formKey, // Added key to the form
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 2, 2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 5, 5),
                              ),
                            ),
                            hintText: 'Email',
                            helperText: 'info@gmail.com',
                            suffix: Icon(Icons.alternate_email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            // Add email validation logic here if needed
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 2, 2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 5, 5),
                              ),
                            ),
                            hintText: 'Password',
                            helperText: '[a-z][0-9]',
                            suffix: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            // Add password validation logic here if needed
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  RoundButton(
                    title: "Login",
                    loading: loading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        await AuthService().signin(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context,
                        );
                        setState(() {
                          loading = false;
                        });
                        print('clicked');
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const InkWell(
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "New User? Create Account",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
