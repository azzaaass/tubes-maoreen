import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toku/style/style.dart';

class UserProfileEdit extends StatelessWidget {
  UserProfileEdit({super.key});
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var data;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    final docRef = db.collection("userData").doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        // print(data['username']);
        usernameController.text = data['username'];
        phoneController.text = data['phone'];
        emailController.text = email.toString();
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 20,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Detail akun",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: white)),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: black.withOpacity(0.2),
              ),
              SizedBox(
                height: 50,
                width: mediaQuery.size.width / 1.2,
                child: TextField(
                    controller: usernameController,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                      fontSize: 16,
                      color: black.withOpacity(0.7),
                    )),
                    decoration: input1(text: "Username")),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: mediaQuery.size.width / 1.2,
                child: TextField(
                    controller: phoneController,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                      fontSize: 16,
                      color: black.withOpacity(0.7),
                    )),
                    decoration: input1(text: "Phone")),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: mediaQuery.size.width / 1.2,
                child: TextField(
                    readOnly: true,
                    controller: emailController,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                      fontSize: 16,
                      color: black.withOpacity(0.7),
                    )),
                    decoration: input1(text: "Email")),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  final db = FirebaseFirestore.instance;
                  db.collection("userData").doc(uid).set({
                    "username": usernameController.text,
                    "phone": phoneController.text,
                  }, SetOptions(merge: true));
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: mediaQuery.size.width / 1.2,
                  decoration: BoxDecoration(
                      color: orange, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
