// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
// and some of my own stuff, too

import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

// container of a custom collection type
// needs to use the toJson/fromJson directly
@JsonSerializable()
class Family {
  String _name;
  People _people;

  String get name => _name;

  set name(String name) => _name = name;

  People get people => _people;

  set people(People people) => _people = people;

  Family(String name, People people)
      : _name = name,
        _people = people;

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyToJson(this);

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

  People(List<Person> items) : _items = items;

  People.fromJson(List<dynamic> json)
      : this(json == null
            ? List<Person>()
            : List<Person>.from(json.map((i) => Person.fromJson(i)).toList()));

  List<dynamic> toJson() =>
      _items == null ? null : _items.map((i) => i.toJson()).toList();

  String toString() => 'People: ${_items.toString()}';
}

// simple type
// can be simple

@JsonSerializable()
class Person {
  String _name;
  int _age;

  String get name => _name;

  set name(String name) => _name = name;

  int get age => _age;

  set age(int age) => _age = age;

  Person(String name, int age)
      : _name = name,
        _age = age;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  String toString() => '$name is $age years old';
}
