import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color orange = Color(0xffff6b4a);
const Color white = Color(0xFFffffff);
const Color black = Color(0xFF000000);

InputDecoration input1({required String text}) {
  return InputDecoration(
    label: Text(text),
    labelStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: black.withOpacity(0.5),
    )),
    floatingLabelStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: black.withOpacity(0.5),
    )),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    hintText: "Masukan ${text.toLowerCase()}",
    hintStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: 16,
      color: black.withOpacity(0.3),
    )),
    contentPadding: const EdgeInsets.only(left: 15),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: black.withOpacity(0.5))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: black.withOpacity(0.5))),
  );
}