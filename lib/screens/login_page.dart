import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/register_page.dart';
import 'package:flutter_assignment/screens/upload_files_page.dart';

import '/utilities/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailTextController = TextEditingController();
    var passwordTextController = TextEditingController();

    var screenWidth = MediaQuery.of(context).size.width;
    var sizedBox = SizedBox(height: screenWidth * 0.02);

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 350,
            maxWidth: 500,
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Login to Dashboard account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          textBaseline: TextBaseline.ideographic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                          (Route<dynamic> route) => true,
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              sizedBox,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      validator: (value) =>
                          Validator.validateEmail(email: value),
                      decoration: const InputDecoration(
                        hintText: 'Email*',
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    sizedBox,
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordTextController,
                      validator: (value) =>
                          Validator.validatePassword(password: value),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password*',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      // fixedSize: Size.fromWidth(screenWidth * 0.4),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                    onPressed: () {
                      login(emailTextController.text.trim(),
                          passwordTextController.text);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 1,
                          dismissDirection: DismissDirection.horizontal,
                          content: const Center(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.orange.shade800,
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              sizedBox,
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      'or register with',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      'FB',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      'Google',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'LinkedIn',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(String email, String password) {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const UploadFilesPage(),
    ));
  }
}
