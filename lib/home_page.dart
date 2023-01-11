
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int diceNumber = 0;
  @override
  Widget build(BuildContext context) {
    // create a text widget and a button under it
    return Scaffold(
      // get the value of the dice number asynchrnously
      body: diceNumber == 0
          ? startPage()
          : diceNumber == -1
              ? diceRolling()
              : diceResult(diceNumber),
    );
  }

  void updateDiceNumber() {
    // this function will call the diceRolling function and update the diceNumber state 
    setState(() {
      diceNumber = Random().nextInt(6) + 1;
      print(diceNumber);
    });
  }
  
  diceRolling() {
    return  Center(
      child: Column(
        children: [
          Center(
            child: Lottie.asset('assets/rollingDice.json'),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Rolling the dice...',
            style: TextStyle(fontSize: 15),
          ),
        ],
      )
    );
  }

startPage() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Roll the dice',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async{
            setState(() {
              diceNumber = -1;
            });
            Future.delayed(const Duration(seconds: 3), () {
              updateDiceNumber();
            });
          },
          child: const Text('Roll'),
        ),
      ],
    ),
  );
}

diceResult(int diceNumber) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You rolled a $diceNumber',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async{
            
            setState(() {
              diceNumber = -1;
            });
            print(diceNumber);
            Future.delayed(const Duration(seconds: 3), () {
              updateDiceNumber();
            });
          },
          child: const Text('Roll Again'),
        ),
      ],
    ),
  );
}
}



