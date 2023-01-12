
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _diceNumber = 0;
  bool _rolling = false;
  bool _showResult = false;

  _rollDice() async {
    setState(() {
      _rolling = true;
    });
    await Future.delayed(const Duration(seconds: 3), () => "");
    setState(() {
      _rolling = false;
      _diceNumber = (1 + (Random().nextDouble() * 6).floor()).toInt();
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _rolling
                ? Lottie.asset('assets/lottie/rollingDice.json',
                    height: 200, width: 200)
                : _diceNumber == 0
                    ? const Text('Start rolling the dice',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ))
                    : Column(
                        children: <Widget>[
                          Image.asset('assets/pictures/dice$_diceNumber.png'),
                          _showResult
                            ? DiceResult(closeCallback:() {
                                setState(() {
                                  _showResult = false;
                                });
                              }, diceNumber:_diceNumber,)
                            : Container()
                        ],
                      ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: _rollDice,
              color: Colors.red,
              child: const Text('Roll'),
            ),
            // _diceNumber != 0
            //     ? Padding(
            //         padding: const EdgeInsets.only(top: 20),
            //         child: MaterialButton(
            //           onPressed: _rollDice,
            //           color: Colors.blue,
            //           child: const Text('Roll Again'),
            //         ),
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }
}

class DiceResult extends StatelessWidget {
  final int _diceNumber;
  final VoidCallback _closeCallback;
  const DiceResult({Key? key, required VoidCallback closeCallback, required int diceNumber})
      : _diceNumber = diceNumber,
        _closeCallback = closeCallback,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('You just rolled a $_diceNumber',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              )
            ),
      actions: <Widget>[
        TextButton(
          onPressed: _closeCallback,
          child: const Text('OK'),
        )
      ],
    );
  }
}