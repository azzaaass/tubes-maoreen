import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toku/style/style.dart';

class FilmDetail extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String creator;
  final String page;
  final String year;
  final String isbn;
  final String weight;
  final String upload;
  final String description;
  FilmDetail(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.creator,
      required this.page,
      required this.year,
      required this.isbn,
      required this.weight,
      required this.upload,
      required this.description});

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  String test = '';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
              stream: db.collection("buku").doc(widget.id).snapshots(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            width: mediaQuery.size.width,
                            child: Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: const FaIcon(
                                    FontAwesomeIcons.angleLeft,
                                    size: 20,
                                  ),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.bagShopping,
                                  size: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  data?['name'] ?? '',
                                  style: GoogleFonts.raleway(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff272727)),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  data?['creator'] ?? '',
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff272727)),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Deskripsi",
                              style: GoogleFonts.raleway(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff272727)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data?['description'] ?? '',
                              style: GoogleFonts.raleway(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
                              softWrap: true,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: black.withOpacity(0.1),
                            ),
                            SizedBox(
                              width: mediaQuery.size.width / 2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Halaman",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                      Text(
                                        data?['page'] ?? '',
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tahun rilis",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                      Text(
                                        data?['year'] ?? '',
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "ISBN",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                      Text(
                                        data?['isbn'] ?? '',
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Berat buku (g)",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                      Text(
                                        data?['weight'] ?? '',
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: black.withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })),
      bottomNavigationBar: InkWell(
        onTap: () async {
          await db
              .collection("userData")
              .doc(uid)
              .collection("favFilm")
              .doc(widget.id)
              .set({
            'id': widget.id,
            'image': widget.image,
            'name': widget.name,
            'creator': widget.creator,
            'page': widget.page,
            'year': widget.year,
            'isbn': widget.isbn,
            'wight': widget.weight,
            'upload': widget.upload,
            'description': widget.description,
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20, top: 10, right: 20, left: 20),
          width: mediaQuery.size.width,
          height: 50,
          decoration: BoxDecoration(
              color: orange, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              "Add to chart",
              style: GoogleFonts.raleway(
                  fontSize: 14.0, fontWeight: FontWeight.w700, color: white),
            ),
          ),
        ),
      ),
    );
  }
}
