import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toku/screens/film_detail.dart';

import 'package:toku/style/style.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController? searchController = TextEditingController();
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var searchName = "";
  bool isDescending = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 50,
            child: Image.asset(
              "assets/images/toku_logo.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 40,
            decoration: BoxDecoration(
                color: black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchName = value;
                });
              },
              controller: searchController,
              // style: text14_6navy,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 18,
                  color: black,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 15,
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isDescending = !isDescending;
                  }),
                  child: const FaIcon(
                    FontAwesomeIcons.sort,
                    size: 18,
                    color: black,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
                stream: db
                    .collection("buku")
                    .where("name", isGreaterThanOrEqualTo: searchName)
                    .where("name", isLessThanOrEqualTo: "$searchName\uf7ff")
                    .orderBy("name", descending: isDescending)
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
                  var data = snapshot.data!.docs;
                  return GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 230.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      // return Text(data[index]['name']);
                      return InkWell(
                        onLongPress: () async {
                          db.collection("buku").doc(data[index].id).delete();
                          db.collection("userData").doc(uid).collection("favBuku").doc(data[index].id).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Barang berhasil dihapus'),
                              duration: Duration(milliseconds: 300),
                            ),
                          );
                        },
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FilmDetail(
                              id: data[index].id,
                              image: data[index]['image'],
                              name: data[index]['name'],
                              creator: data[index]['creator'],
                              page: data[index]['page'],
                              year: data[index]['year'],
                              isbn: data[index]['isbn'],
                              weight: data[index]['weight'],
                              upload: data[index]['upload'],
                              description: data[index]['description'],
                            );
                          }));
                        },
                        child: Container(
                          height: 150,
                          width: mediaQuery.size.width / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['image']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
