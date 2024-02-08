import 'package:flutter/material.dart';
import 'package:flutter_application_tic_tac_xo/settings_tic_tac.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key, required this.currentPlayer});
  final String currentPlayer;

  @override
  State<GameHome> createState() => _GameHomeState();
}

List<List<String>> board = [];
String winner = '';
Color playerColor = Colors.white;
String alertImage = '';
int entry = 0, won1 = 0, won2 = 0;
late Icon player1Icon;
late Icon player2Icon;
class _GameHomeState extends State<GameHome> {
  int player = 0;
  String cplayer = '';
  Icon playerIcon = const Icon(Icons.no_luggage_outlined);
  bool gameOver = false;
  @override
  void initState() {
    super.initState();
    initializeGame();
    winner = '';
    alertImage = '';
    cplayer = widget.currentPlayer;
    //playerColor=Colors.white;
    if (cplayer == 'X') {
      
      playerColor = Colors.red;
    } else {
      playerColor = Colors.blue;
    }
    entry = 0;
  }

  void initializeGame() {
    setState(() {
      board = List.generate(3, (i) => List.filled(3, ''));
      alertImage = '';
      winner = '';
      entry = 0;
    });
  }

  bool checkWinner(int row, int col, String cplayer) {
    bool flag = false;

    if (board[0][0] == cplayer &&
        board[1][0] == cplayer &&
        board[2][0] == cplayer) {
      flag = true;
    } else if (board[0][1] == cplayer &&
        board[1][1] == cplayer &&
        board[2][1] == cplayer) {
      flag = true;
    } else if (board[0][2] == cplayer &&
        board[1][2] == cplayer &&
        board[2][2] == cplayer) {
      flag = true;
    } else if (board[0][0] == cplayer &&
        board[0][1] == cplayer &&
        board[0][2] == cplayer) {
      flag = true;
    } else if (board[1][0] == cplayer &&
        board[1][1] == cplayer &&
        board[1][2] == cplayer) {
      flag = true;
    } else if (board[2][0] == cplayer &&
        board[2][1] == cplayer &&
        board[2][2] == cplayer) {
      flag = true;
    } else if (board[0][0] == cplayer &&
        board[1][1] == cplayer &&
        board[2][2] == cplayer) {
      flag = true;
    } else if (board[0][2] == cplayer &&
        board[1][1] == cplayer &&
        board[2][0] == cplayer) {
      flag = true;
    } else {
      if (entry == 9) {
        gameOver = true;
        alertImage = 'assets/draw.jpg';
        showWinnerDialog('Draw game. Please try again');
      }
      flag = false;
    }
    if (flag == true) {
      alertImage = 'assets/win.gif';
      if (cplayer == 'X') {
        won1 = won1 + 1;
      } else {
        won2 = won2 + 1;
      }
    }
    return flag;
  }

  void handleTap(int row, int col) {
    setState(() {
      if (!gameOver) {
        if (cplayer == 'X') {
          board[row][col] = 'X';
          entry++;
          gameOver = checkWinner(row, col, cplayer);
          if (gameOver) {
            gameOver = true;
            winner = 'Player1 is the Winner';
            showWinnerDialog(winner);
          }
          playerColor = Colors.blue;
          cplayer = 'O';
        } else {
          board[row][col] = 'O';
          entry++;
          gameOver = checkWinner(row, col, cplayer);
          if (gameOver) {
            gameOver = true;
            winner = 'Player2 is the Winner';
            showWinnerDialog(winner);
            
          }
          playerColor = Colors.red;
          cplayer = 'X';
        }
      }
    });
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Image(
            image: AssetImage(alertImage),
            height: 200,
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              winner,
              style: const TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const SettingsTicTac()), (route) => false);
                initializeGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
      // ignore: prefer_const_constructors
      body: SafeArea(
        child: Container(
          color: Colors.lime[100],
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Container(
                color: Colors.green[100],
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  title: const Text(
                    'Player 1',
                    style: TextStyle(fontSize: 23, color: Colors.red),
                  ),
                  subtitle: Text('Won X $won1'),
                ),
              ),
              Container(
                color: Colors.amber[100],
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.blur_circular_outlined,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  title: const Text(
                    'Player 2',
                    style: TextStyle(fontSize: 23, color: Colors.red),
                  ),
                  subtitle: Text('Won X $won2'),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .9, crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () => {handleTap(row, col)},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                board[row][col],
                                style:
                                    
                                    TextStyle(fontSize: 100, 
                                    
                                    color: board[row][col]=='X'?Colors.red:Colors.blue),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
