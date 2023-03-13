import 'package:auth_using_hashing/controllers/auth_controllers.dart';
import 'package:auth_using_hashing/screens/Home_Screen.dart';
import 'package:auth_using_hashing/screens/SignUp_Screen.dart';
import 'package:auth_using_hashing/utils/snackBar.dart';

import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  // void convert() {
  //   String password = BCrypt.hashpw('pass', BCrypt.gensalt());
  //   final bool BCrypt
  //   print(password);
  // }

  void logInUser() async {
    setState(() {
      isLoading = true;
    });
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      customSnackBar('Please Enter all the fields');
    } else {
      String res = await AuthControllers().logInUser(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        isLoading = false;
      });
      if (res != 'Success') {
        customSnackBar(res.toString());
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Login to Your Account',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your Email',
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: isVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Enter your Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: logInUser,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.white),
                                )),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an Account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              )
            ]),
      ),
    ));
  }
}
