import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/theme/color.dart';
import 'package:tic_tac_toe_game/utils/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  // lats declare a new game component

  Game game = Game();
  // lates init the game board

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBorad();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's ${lastValue} turn".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/ 3,
                padding: EdgeInsets.all(16.00),
                mainAxisSpacing: 8.00,
                crossAxisSpacing: 8.00,
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            // when we click we need to new value and refresh the page there for
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreboard, 3);
                                if (gameOver) {
                                  result = "$lastValue is the Winner";
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!";
                                  gameOver = true;
                                }
                                if (lastValue == "X")
                                  lastValue = "O";
                                else
                                  lastValue = "X";
                              });
                            }
                            if (game.board![index] == "") {
                              setState(() {
                              game.board![index] = lastValue;
                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                            }
                            
                          },
                    child: Container(
                      width: Game.blocsize,
                      height: Game.blocsize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.00),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              color: game.board![index] == "X"
                                  ? Colors.blue
                                  : Colors.pink,
                              fontSize: 64.00),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              result,
              style: new TextStyle(color: Colors.white, fontSize:40),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
            
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBorad();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              label: Text("Repect the Game"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff001456)),

              ),
              
            ),

          ]),
    );
  }
}
