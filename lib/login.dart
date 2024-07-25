import 'package:flutter/material.dart';
import 'package:ilive/home.dart';
import 'package:ilive/regsiter.dart'; // Corrected the import path
import 'package:ilive/widgets/round_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./assets/img2.jpg'), fit: BoxFit.cover)),
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white54, Colors.black87])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Login',
              ),
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
                    // key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 2, 2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 5, 5)),
                              ),
                              hintText: 'Email',
                              helperText: 'info@gmail.com',
                              suffix: Icon(Icons.alternate_email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // controller: _passwordController,

                          keyboardType: TextInputType.text,

                          obscureText: true,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 2, 2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 5, 5)),
                              ),
                              hintText: 'Password',
                              helperText: '[a-z][0-9]',
                              suffix: Icon(Icons.lock)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                      title: "Login",
                      // loading: loading,

                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   signIn();
                        // }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  const InkWell(
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Register())); // Removed 'const' keyword
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
          )));
}
