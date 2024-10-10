//INIT & BUILD
 
// ignore_for_file: avoid_print
 
import 'package:flutter/material.dart';
 
class Example extends StatelessWidget {
  // const Example({super.key});
  Example({super.key}) {
    // print('Element-Konstruktor --> init');
  }
 
  @override
  Widget build(BuildContext context) {
    // print('Element: build()');
    return Column(
      children: [
        Expanded(flex: 2, child: YellowBox()),
        Expanded(flex: 5, child: RedBox()),
      ],
    );
  }
}
 
class YellowBox extends StatelessWidget {
  YellowBox({super.key}) {
    print('YellowBox-Konstruktor --> init');
  }
 
  @override
  Widget build(BuildContext context) {
    print('YellowBox: build(context)');
    return Container(
      color: Colors.yellow,
      child: const Center(
        child: Text(
          """
            -die Konstruktoren aller Widgets, werden alle nacheinander ausgeführt, bevor sie deren Build ausgeführt wird.\n
            -wenn StetState in einem Widget-State aufgerufen wird, wird lediglich die Bildmethode des jeweiligen State-Widgets geladen.\n
          """,
          style: TextStyle(
            fontSize: 10,
          ),
          ),
        ),
    );
  }
}
 
class RedBox extends StatefulWidget {
  // const RedBox({super.key});
  RedBox({super.key}) {
    print('SF-RedBox-Konstruktor --> init');
  }
 
  @override
  State<RedBox> createState() => _RedBoxState();
}
 
class _RedBoxState extends State<RedBox> {
  int number = 0;
  _RedBoxState() {
    print('SF-RedBoxState gets context');
    print('_RedBoxState: the number is $number');
  }
  void _increment() {
    number += 1;
    setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    print('SF-$widget: build()');
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 34, 50, 50),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _increment();
                print('Button pressed: $number');
              },
              child: Text('$number'),
            ),
            Expanded(
              child: BlueBox(),
            ),
            Expanded(
              child: GreenBox(),
            ),
          ],
        ),
      ),
    );
  }
}
 
/* ------- SL-BlueBox ------- */
class BlueBox extends StatelessWidget {
  // const BlueBox({super.key});
  BlueBox({super.key}) {
    print('BlueBox-Konstruktor --> init');
  }
 
  @override
  Widget build(BuildContext context) {
    print('BlueBox: build(context)');
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
      child: Container(color: Colors.blue),
    );
  }
}
 
/* ------- SL-GreenBox ------- */
class GreenBox extends StatelessWidget {
  // const GreenBox({super.key});
  GreenBox({super.key}) {
    print('GreenBox-Konstruktor --> init');
  }
 
  @override
  Widget build(BuildContext context) {
    print('GeenBox: build(context)');
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: PinkBox(),
      ),
    );
  }
}
 
/* ------- SL-BlueBox ------- */
class PinkBox extends StatelessWidget {
  // const PinkBox({super.key});
  PinkBox({super.key}) {
    print('PinkBox-Konstruktor --> init');
  }
 
  @override
  Widget build(BuildContext context) {
    print('PinkBox: build(context) ------------------------------------- END');
    return Container(
      color: Colors.pink,
    );
  }
}