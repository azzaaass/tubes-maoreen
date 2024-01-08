import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toku/auth/auth_service.dart';
import 'package:toku/auth/register.dart';
import 'package:toku/screens/home.dart';
import 'package:toku/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 72.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                alignment: Alignment.centerLeft,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xff272727),
                  size: 24.0,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                "Ayo, mari kita mulai!",
                style: GoogleFonts.raleway(
                  color: Color(0xff272727),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                "Silakan masukkan email dan kata sandi Anda untuk melanjutkan.",
                style: GoogleFonts.raleway(
                  color: Color(0xff272727),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "Email",
                style: GoogleFonts.raleway(
                  color: Color(0xff272727),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xffbcbbbf))),
                child: TextField(
                  controller: emailController,
                  style: GoogleFonts.raleway(
                      color: const Color(0xff272727),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Masukkan email",
                    hintStyle: GoogleFonts.raleway(
                        color: const Color(0xffbcbbbf),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                "Kata Sandi",
                style: GoogleFonts.raleway(
                  color: const Color(0xff272727),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xffbcbbbf))),
                child: TextField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  style: GoogleFonts.raleway(
                      color: const Color(0xff272727),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Masukkan kata sandi",
                    hintStyle: GoogleFonts.raleway(
                        color: const Color(0xffbcbbbf),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 56.0,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: orange, width: 1.0)),
                  onPressed: () async {
                    final message = await AuthService().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (message == 'Login Success') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message ?? 'An error occurred'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Masuk",
                    style: GoogleFonts.raleway(
                        color: orange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                  child: Text(
                    "Daftar",
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 56.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
