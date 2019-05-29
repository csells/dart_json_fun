// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
// and some of my own stuff, too

import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

// container of a custom collection type
// needs to use the toJson/fromJson directly
@JsonSerializable()
class Family {
  String _name;
  final People _people;

  String get name => _name;

  set name(String name) => _name = name;

  List<Person> get people => _people;

  set people(List<Person> people) {
    _people.clear();
    _people.addAll(people);
  }

  Family(String name, List<Person> people)
      : _name = name,
        _people = People(people);

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyToJson(this);

  String toString() => "$name Family: $people";
}

// custom collection type
// reads and writes itself as a List<dynamic> so that it can appear correctly in the JSON,
// since jsonEncode/jsonDecode map '[...]' <=> List<Dynamic>
class People extends ListBase<Person> {
  final List<Person> _items;

  People(List<Person> items) : _items = items;

  String toString() => 'People: ${_items.toString()}';

  @override
  int get length => _items.length;

  set length(int value) => _items.length = value;

  @override
  Person operator [](int index) => _items[index];

  @override
  void operator []=(int index, Person value) => _items[index] = value;
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
