//CONTEXT
// ignore_for_file: avoid_print
 
import 'package:flutter/material.dart';
 
//in einem Parent-StatelessWidget liegen untereinander zwei Widgets:
 
//  ein Stateless Widget  --> StatelessBox (grau))
// und ein StatefulWidgets --> StatefulBox (grün))
 
//Beide dieser Widgets beinhalten je einen Button.
 
//Frage1: Wie greife ich den context von einem StatelessWidget an? --> Über seine Build-Methode
//Frage2: Wie greife ich den context von einem StatefulWidget an?  --> Über die Build-Methode seines States
//Frage3: Kann ich aus dem Child-Widget den Parent-Widget über context erkunden?
 
class Example extends StatelessWidget {
  const Example({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('context in SL und SF Widgets'),
              Text(
                'Über den Kontext ist es möglich die Größe des jeweiligen Widgets zu erfahren.',
                style: TextStyle(
                  color: Colors.blue,
                ),
                ),
              SizedBox(
                height: 50,
              ),
              StatelessBox(),
              StatefulBox(),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
 
//** --- StatelessBox --- **//
 
class StatelessBox extends StatelessWidget {
  const StatelessBox({super.key});
//die void Funktion _onPressed,
//erwartet als Argument einen context
//im body sind mehrere print()s:
//Wem gehört der context?
//wie kann ich über context den Namen und die Größe des Widgets erkunden?
// und von welchen Typ ist das Widget.
 
  void _onPressedStateless(BuildContext myContext) {
    //myContext ist ein Parameter,
    //der beim Aufruf der Funktion
    //mit jeweiligem Widget-context ergenzt wird
    print('mein Name ist ${myContext.widget}');
    print('mein Typ ist ${myContext.runtimeType}');
    print('mein ${myContext.size}');
  }
 
  @override
  Widget build(BuildContext context) {
    //Innerhalb der build()-Methode
    //greifen wir zum gerade erzeugten context
    //über seine Eigenschaft "widget",
    //um den Namen des Widgets zu erkunden
    print('ich bin context von ${context.widget}');
    return Container(
      color: Colors.grey,
      width: 160,
      height: 100,
      child: Center(
        child: ElevatedButton(
          //die _onPressed() bekommt context aus der build() Methode als Argument
          onPressed: () => _onPressedStateless(context),
          child: const Text('StatelessBox'),
        ),
      ),
    );
  }
}
 
//** --- StatefulBox --- **//
 
class StatefulBox extends StatefulWidget {
  //SF Widget initiiert
  const StatefulBox({super.key});
 
  @override
  State<StatefulBox> createState() => _StatefulBoxState();
}
 
class _StatefulBoxState extends State<StatefulBox> {
//eben wie im StatelessBox gibt
//die Funktion über context-Anfragen
//verschiedene Informationen über erzeugten Elemente:
//Wem gehört der context?
//(Wie kann ich über context den Namen und die Größe des Widgets erkunden?
// und von welchen Typ ist das Widget.
  void _onPressedStateful(BuildContext myContext) {
    print('mein Name ist ${myContext.widget}');
    print('mein Typ ist ${myContext.runtimeType}');
    print('mein ${myContext.size}');
  }
 
  @override
  //teotetisch können wir in der Methode build()
  //das context-Argument in einem StatefulWidget auslassen
  //Alles wird trotzdem funktionieren, weil
  //das State-Objekt erhält einen context als Eigenschaft,
  //genau wie die Eigenschaft "widget"
  Widget build(_) {
    //wir greifen zur Eigenschaft "widget" des State-Objektes,
    //um den Namen des WIdgets zu erkunden
    print('ich bin context von $widget');
    return Container(
      color: Colors.greenAccent,
      width: 160,
      height: 100,
      child: Center(
        child: ElevatedButton(
          onPressed: () => _onPressedStateful(context),
          child: const Text('StatefulBox'),
        ),
      ),
    );
  }
}