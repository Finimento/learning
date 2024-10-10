const a = "immer bei der Erstellung müssen const initialisiert werden";
final b = "immer bei der Erstellung außerhalb einer Funktion müssen final initialisiert werden"; // final String b;    <--gibt einen Fehler aus, da 
late String c;
late var d = "Hallo Welt"; // var muss verwendet werden falls man den Datentyp noch nicht kennt, da late nicht von allein inferiert wird.
late final String e;
var f;
dynamic g;

void main(){
  const a = "const muss initialisiert werden";
  final b;
  late String c;
  late var d = "Hallo Welt"; // var muss verwendet werden falls man den Datentyp noch nicht kennt, da late nicht von allein inferiert wird.
  late final String e;
  var f;
  dynamic g;
}

