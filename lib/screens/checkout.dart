import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toku/data/data.dart';
import 'package:toku/screens/film_detail.dart';
import 'package:toku/style/style.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;
    List<CheckoutData> checkout = [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Checkout sekarang dek",
              style: GoogleFonts.raleway(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: black.withOpacity(0.8)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: db
                      .collection("userData")
                      .doc(uid)
                      .collection("favBuku")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    // var id = snapshot.data!.id;
                    var data = snapshot.data!.docs;
                    return GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 100.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        // return Text(data[index]['name']);
                        return InkWell(
                          onTap: () async {
                            await db
                                .collection("userData")
                                .doc(uid)
                                .collection("favBuku")
                                .doc(data[index]['id'])
                                .set({
                              'isSelected': !data[index]['isSelected'],
                            }, SetOptions(merge: true));

                            // if (checkout[index].isSelected) {
                            //   checkout.add(data[index]['id']);
                            // } else {
                            //   checkout.removeWhere((element) =>
                            //       element.id == checkout[index].id);
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: data[index]['isSelected']
                                  ? Color.fromARGB(255, 122, 212, 254)
                                  : white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.1), // Warna bayangan
                                  spreadRadius:
                                      0, // Lebar bayangan yang menyebar
                                  blurRadius: 5,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Image.network(
                                      data[index]['image'],
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]['name'],
                                      style: GoogleFonts.raleway(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: black.withOpacity(0.8)),
                                    ),
                                    Text(
                                      data[index]['creator'],
                                      style: GoogleFonts.raleway(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: black.withOpacity(0.6)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Terimakasih'),
              duration: Duration(milliseconds: 300),
            ),
          );
          var querySnapshot = await db
              .collection("userData")
              .doc(uid)
              .collection("favBuku")
              .where("isSelected", isEqualTo: true)
              .get();

          for (var doc in querySnapshot.docs) {
            await doc.reference.delete();
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20, top: 10, right: 20, left: 20),
          width: mediaQuery.size.width,
          height: 50,
          decoration: BoxDecoration(
              color: orange, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              "Checkout",
              style: GoogleFonts.raleway(
                  fontSize: 14.0, fontWeight: FontWeight.w700, color: white),
            ),
          ),
        ),
      ),
    );
  }
}
