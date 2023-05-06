import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appstyle({required double size,required Color color,required FontWeight fw}){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: fw,
    color: color
  );
}

TextStyle appstyleWithHt({required double size,required Color color,required FontWeight fw,required double ht}){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: fw,
    color: color
    ,height: ht
  );
}