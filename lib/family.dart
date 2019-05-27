// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
import 'dart:collection';
import 'dart:convert';

// TODO:
// -does the toJson/fromJson naming really matter?
//  it's certainly misleading, since JSON is a string format, not a Map<String, dynamic>.
// -what if the JSON has more than it should? are the extras ignored?
// -what if the JSON has less than it should? are the fields nulled?

// container of a custom collection type
// needs to use the toJson/fromJson directly
class Family {
  String _name;
  People _people;

  String get name => _name;
  set name(String name) => _name = name;

  People get people => _people;
  set people(People people) => _people = people;

  Family(this._name, this._people);
  Family.fromJson(Map<String, dynamic> json) : this(json['name'], People.fromJson(json['people']));
  Map<String, dynamic> toJson() => {'name': name, 'people': people.toJson()};
  String toString() => "$name Family: $people";
}

// custom collection type
// reads and writes itself as a List<dynamic> so that it can appear correctly in the JSON,
// since jsonEncode/jsonDecode map '[...]' <=> List<Dynamic>
class People {
  List<Person> _items;

  void add(Person person) => _items.add(person);
  void remove(Person person) => _items.remove(person);
  Iterable<Person> get items => _items;

  People(this._items);
  People.fromJson(List<dynamic> json)
      : this(List<Person>.from(json.map((i) => Person.fromJson(i)).toList()));
  List<dynamic> toJson() => _items.map((i) => i.toJson()).toList();
  String toString() => 'People: ${_items.toString()}';
}

// simple type
// can be simple
class Person {
  String _name;
  int _age;

  String get name => _name;
  set name(String name) => _name = name;

  int get age => _age;
  set age(int age) => _age = age;

  Person(this._name, this._age);
  Person.fromJson(Map<String, dynamic> json) : this(json['name'], json['age']);
  Map<String, dynamic> toJson() => {'name': name, 'age': age};
  String toString() => '$name is $age years old';
}
