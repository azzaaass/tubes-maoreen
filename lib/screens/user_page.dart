import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toku/auth/splash.dart';
import 'package:toku/screens/buku_add.dart';
import 'package:toku/screens/user_profile_edit.dart';
import 'package:toku/style/style.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User",
                    style: GoogleFonts.raleway(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff272727)),
                  ),
                  StreamBuilder(
                      stream: db.collection("userData").doc(uid).snapshots(),
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        return data?['role'] == "admin"
                            ? InkWell(  
                              onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => BukuAdd(),)),
                              child: const FaIcon(FontAwesomeIcons.cat, size: 20))
                            : const SizedBox();
                      })
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ImageProfile(),
            const SizedBox(
              height: 5,
            ),
            UserProfile(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: black.withOpacity(0.1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Indikasi Baik",
                      style: GoogleFonts.raleway(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff272727)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: mediaQuery.size.width / 2,
                      child: Text(
                        "Progres belajar mencapai ambang yang aman, apasih wkwk",
                        softWrap: true,
                        style: GoogleFonts.raleway(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff272727)),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: orange,
                        width: 6.0,
                      )),
                  child: Center(
                      child: Text(
                    "672",
                    style: GoogleFonts.raleway(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: orange),
                  )),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: black.withOpacity(0.1),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: [
                        Colors.amber,
                        Colors.cyan,
                        Colors.pink,
                      ][index],
                      child: FaIcon(
                        [
                          FontAwesomeIcons.cartShopping,
                          FontAwesomeIcons.creditCard,
                          FontAwesomeIcons.usersLine,
                        ][index],
                        size: 18,
                        color: white,
                      ),
                    ),
                    title: Text(
                      [
                        "Keranjang belanja",
                        "Metode pembayaran",
                        "Teman disekitar",
                      ][index],
                      style: GoogleFonts.raleway(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: black.withOpacity(0.8)),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 18,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ));
              },
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    size: 18,
                    color: black.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sign-out",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.collection("userData").doc(uid).snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data?['username'] ?? '',
                style: GoogleFonts.raleway(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff272727)),
              ),
              Text(
                data?['phone'] ?? '',
                style: GoogleFonts.raleway(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff272727)),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserProfileEdit(),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      email.toString(),
                      style: GoogleFonts.raleway(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff272727)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FaIcon(
                      FontAwesomeIcons.pencil,
                      size: 12,
                      color: black.withOpacity(0.5),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class ImageProfile extends StatefulWidget {
  ImageProfile({super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  File? _image;
  final picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase() async {
    String uid = user?.uid ?? '';
    if (_image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_image/$uid');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
      db.collection("userData").doc(uid).set({
        "image": imageURL,
      }, SetOptions(merge: true));
      print('Image URL: $imageURL');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () async {
        await getImage();
        await uploadImageToFirebase();
      },
      child: StreamBuilder(
          stream: db.collection("userData").doc(uid).snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data;

            // print(data?['username'] ?? '');
            return Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(data?['image'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
