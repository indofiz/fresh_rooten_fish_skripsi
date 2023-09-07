import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController emailController = TextEditingController();
  bool isDisabled = true;

  @override
  void initState() {
    super.initState();
    emailController.text = '';
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    if (emailController.text.isNotEmpty && emailController.text != '') {
      await prefs.setBool('isEmail', true);
      redirect();
    }
  }

  void checkEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isEmail = prefs.getBool('isEmail') ?? false;
    if (isEmail) {
      redirect();
    }
  }

  void redirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    if (email.isNotEmpty && email != '') {
      // print(email);
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                email: email,
              ),
            ),
          )
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Lottie.asset('assets/lottie/splash.json'),
                  ),
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                    child: Text(
                      'Sebelum masuk ke aplikasi, silahkan masukan email anda terlebih dahulu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: black.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    nameForm(),
                    buttonSubmit(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget nameForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      child: TextField(
        controller: emailController,
        onChanged: (e) {
          setState(() {
            if (e.isNotEmpty &&
                e != '' &&
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(e)) {
              isDisabled = false;
            } else {
              isDisabled = true;
            }
          });
        },
        decoration: InputDecoration(
          fillColor: white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: border),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: primary),
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: TextStyle(color: black.withOpacity(0.6), fontSize: 14),
          hintText: 'Masukan email anda',
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: !isDisabled ? primary : primary.withOpacity(0.5),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: !isDisabled
            ? () {
                saveEmail();
              }
            : null,
        child: Text(
          'ENTER',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
