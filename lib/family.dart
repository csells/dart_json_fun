// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
import 'dart:convert';

// TODO:
// -hide all of the public fields, since we want to wrap setters around all of them
// -does the toJson/fromJson naming really matter?
//  it's certainly misleading, since JSON is a string format, not a Map<String, dynamic>.
// -what if the JSON has more than it should? are the extras ignored?
// -what if the JSON has less than it should? are the fields nulled?

// container of a custom collection type
// needs to use the toJson/fromJson directly
class Family {
  String name;
  People people;

  Family(this.name, this.people);
  Family.fromJson(Map<String, dynamic> json) : this(json['name'], People.fromJson(json['people']));
  Map<String, dynamic> toJson() => {'name': name, 'people': people.toJson()};
  String toString() => "$name Family: $people";
}

// custom collection type
// reads and writes itself as a List<dynamic> so that it can appear correctly in the JSON,
// since jsonEncode/jsonDecode map '[...]' <=> List<Dynamic>
class People {
  List<Person> _items;

  People(this._items);
  People.fromJson(List<dynamic> json)
      : this(List<Person>.from(json.map((i) => Person.fromJson(i)).toList()));
  List<dynamic> toJson() => _items.map((i) => i.toJson()).toList();
  String toString() => 'People: ${_items.toString()}';
}

// simple type
// can be simple
class Person {
  String name;
  int age;

  Person(this.name, this.age);
  Person.fromJson(Map<String, dynamic> json) : this(json['name'], json['age']);
  Map<String, dynamic> toJson() => {'name': name, 'age': age};
  String toString() => '$name is $age years old';
}
