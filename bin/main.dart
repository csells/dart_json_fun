import 'package:json_fun/family.dart';
import 'dart:convert';

main() {
  var fam1 = Family("Sells", People([Person("John", 25), Person("Tom", 22)]));
  var json = jsonEncode(fam1);
  Family fam2 = Family.fromJson(jsonDecode(json));
  print('fam1= $fam1');
  print('json= $json');
  print('fam2= $fam2');
}
