import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toku/auth/login.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 90.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage("assets/images/Ilustration_onboard.png"),
                      width: 325.0,
                      ),
                  )
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                "Selamat Datang di ToKu",
                style: GoogleFonts.raleway(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff272727),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                "Temukan Pengalaman Belanja Terbaik & Dunia Literasi Modern dalam Satu Aplikasi Unggulan Abad Ini!",
                style: GoogleFonts.raleway(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff272727),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 72.0,
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
                        builder: (context) => const LoginScreen()));
                  },
                  child: Text(
                    "Mulai",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}