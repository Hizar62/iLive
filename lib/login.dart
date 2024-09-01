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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: const Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter E-mail';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
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
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
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
