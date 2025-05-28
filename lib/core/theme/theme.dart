import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.deepPurple,
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.light().textTheme,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
      );

  static ThemeData get darkThemeData => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(221, 31, 31, 31),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 103, 78, 0),
          brightness: Brightness.dark,
          
        ),

        // filledButtonTheme: FilledButtonThemeData(
        //   style: FilledButton.styleFrom(
        //     backgroundColor: const Color.fromARGB(255, 164, 133, 59),
            
        // )),
        
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.dark().textTheme,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
      );
}


final themeModeProvider = StateProvider<ThemeMode>(
  (ref) {
    return ThemeMode.system;
  },
);
