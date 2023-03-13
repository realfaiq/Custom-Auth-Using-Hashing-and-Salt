import 'package:auth_using_hashing/controllers/auth_controllers.dart';
import 'package:auth_using_hashing/utils/snackBar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isVisibleP = true;
  bool isVisibleC = true;
  bool isLoading = false;

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      customSnackBar('Please Enter all the fields');
    } else if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        isLoading = false;
      });
      customSnackBar(
          'Please make sure that password and confirm password matches');
    } else {
      try {
        String res = await AuthControllers().signUpUser(
            fullName: _fullNameController.text,
            email: _emailController.text,
            password: _passwordController.text);
        setState(() {
          isLoading = false;
        });
        if (res != 'Success') {
          customSnackBar(res.toString());
        } else {
          customSnackBar('Signed up Successfully');
        }
      } catch (err) {
        print(err.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'Sign Up to Your Account',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your full Name',
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email',
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: isVisibleP,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Enter your Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleP = !isVisibleP;
                              });
                            },
                            icon: isVisibleP
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: isVisibleC,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Confirm your Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleC = !isVisibleC;
                              });
                            },
                            icon: isVisibleC
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: signUpUser,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Sign Up',
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
                    'Already have an Account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    child: const Text(
                      ' Login',
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
