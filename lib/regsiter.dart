import 'package:flutter/material.dart';
import 'package:ilive/login.dart';
import 'package:ilive/widgets/round_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _selectedGender;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./assets/img.jpg'), fit: BoxFit.cover)),
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white60, Colors.black87])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Register',
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
                          controller: _userNameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 2, 2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 5, 5)),
                              ),
                              hintText: 'UserName',
                              suffix: Icon(Icons.person)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter UserName';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailController,
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
                          controller: _passwordController,
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
                  Container(
                    width: 500, // Set the desired width here
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedGender,
                      isExpanded: true,
                      hint: const Text('Select Gender'),
                      items: <String>['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                      title: "Sign Up",
                      // loading: loading,
                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   signIn();
                        // }
                        ;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )));
}
