import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_tic_tac_xo/game.dart';

class SettingsTicTac extends StatefulWidget {
  const SettingsTicTac({super.key});

  @override
  State<SettingsTicTac> createState() => _SettingsTicTacState();
}

class _SettingsTicTacState extends State<SettingsTicTac> {
  Color borderColor1 = Colors.white;
  Color borderColor2 = Colors.white;
  String currentPlayer='';
  int startgame=0;
  @override
  void initState() {
    borderColor1=Colors.white;
    borderColor2=Colors.white;
    currentPlayer='';
    startgame=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: RichText(
            text: const TextSpan(
              text: 'Tic-Tac- ',
              style: TextStyle(color: Colors.black, fontSize: 60),
              children: <TextSpan>[
                TextSpan(
                    text: 'X',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                TextSpan(text: 'O', style: TextStyle(color: Colors.red)),
              ],
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(
            // ignore: unnecessary_const
            child: const Text(
              'Choose Your Side',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor1,
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    startgame=1;
                      setState(() {
                        currentPlayer='X';
                         borderColor1=Colors.red;
                       borderColor2=Colors.white;
                      });
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.red,
                  iconSize: 140,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor2,
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    startgame=1;
                  setState(() {
                    currentPlayer='O';
                     borderColor2=Colors.blue;
                       borderColor1=Colors.white;
                  });
                        
                  },
                  icon: const Icon(Icons.circle_outlined),
                  color: Colors.blue,
                  iconSize: 140,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ElevatedButton(
                  onPressed: () {
                   if(startgame==1)
                   {
                    startgame=0;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameHome(currentPlayer: currentPlayer),));
                   }
                   else
                   {
                    showWinnerDialog(context);
                   }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  child: const Text(
                    'Start Game',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );

    
  }
  void showWinnerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Alert!'),
          content: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Please choose Your Side!',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const SettingsTicTac()), (route) => false);
                
              },
              child: const Text('Go Back'),
            ),
          ],
        );
      },
    );
  }
}
