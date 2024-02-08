import 'package:flutter/material.dart';
import 'package:flutter_application_tic_tac_xo/game.dart';
import 'package:flutter_application_tic_tac_xo/settings_tic_tac.dart';
import 'package:flutter_application_tic_tac_xo/splash_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home:  const SplashScreen(),
     //home: const LoginScreen(),
      routes: {
        'settings': (ctx){
          return const SettingsTicTac();
        },
        // 'gamehome': (ctx){
        //    return const GameHome(currentPlayer: ,);
        //  },
        // 'registration': (ctx){
        //   return const UserRegistration();
        // },
      },
    );
  }
}
