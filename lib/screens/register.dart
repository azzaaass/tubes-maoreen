import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;

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
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xff272727),
                  size: 24.0,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                "Daftar, dan jelajahi lebih banyak!",
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
                "Ciptakan akun pribadi Anda dan nikmati pengalaman terbaik tersama Kami.",
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
                    border: Border.all(color: Color(0xffbcbbbf))),
                child: TextField(
                  style: GoogleFonts.raleway(
                      color: Color(0xff272727),
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
                        color: Color(0xffbcbbbf),
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
                    border: Border.all(color: Color(0xffbcbbbf))),
                child: TextField(
                  obscureText: _isObscure,
                  style: GoogleFonts.raleway(
                      color: Color(0xff272727),
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
                        color: Color(0xffbcbbbf),
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
                    backgroundColor: Color(0xffff6b4a),
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