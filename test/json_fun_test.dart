import 'package:json_fun/family.dart';
import 'package:test/test.dart';
import 'dart:convert';

String dump(String label, Object o) => '${o.runtimeType} $label = $o';

void main() {
  test('Person', () {
    Person john = Person('John', 25);
    expect(dump('john', john), 'Person john = John is 25 years old');

    Map<String, dynamic> map = john.toJson();
    expect(dump('map', map), '_InternalLinkedHashMap<String, dynamic> map = {name: John, age: 25}');

    String json = jsonEncode(map);
    expect(dump('json', json), 'String json = {"name":"John","age":25}');

    Person john2 = Person.fromJson(map);
    expect(dump('john2', john2), 'Person john2 = John is 25 years old');

    dynamic map2 = jsonDecode(json);
    expect(
        dump('map2', map2), '_InternalLinkedHashMap<String, dynamic> map2 = {name: John, age: 25}');

    Person john3 = Person.fromJson(map2);
    expect(dump('john3', john3), 'Person john3 = John is 25 years old');
  });

  test('People', () {
    People boys = People([Person("John", 25), Person("Tom", 23)]);
    expect(dump('boys', boys), 'People boys = People: [John is 25 years old, Tom is 23 years old]');

    List<dynamic> list = boys.toJson();
    expect(dump('list', list),
        'List<Map<String, dynamic>> list = [{name: John, age: 25}, {name: Tom, age: 23}]');

    String json = jsonEncode(list);
    expect(dump('json', json), 'String json = [{"name":"John","age":25},{"name":"Tom","age":23}]');

    People boys2 = People.fromJson(list);
    expect(
        dump('boys2', boys2), 'People boys2 = People: [John is 25 years old, Tom is 23 years old]');

    dynamic map = jsonDecode(json);
    expect(dump('map', map), 'List<dynamic> map = [{name: John, age: 25}, {name: Tom, age: 23}]');

    People boys3 = People.fromJson(map);
    expect(
        dump('boys3', boys3), 'People boys3 = People: [John is 25 years old, Tom is 23 years old]');
  });

  test('Family', () {
    Family fam = Family("Sells", People([Person("John", 25), Person("Tom", 22)]));
    expect(dump("fam", fam),
        'Family fam = Sells Family: People: [John is 25 years old, Tom is 22 years old]');

    Map<String, dynamic> map = fam.toJson();
    expect(dump('map', map),
        '_InternalLinkedHashMap<String, dynamic> map = {name: Sells, people: [{name: John, age: 25}, {name: Tom, age: 22}]}');

    String json = jsonEncode(map);
    expect(dump('json', json),
        'String json = {"name":"Sells","people":[{"name":"John","age":25},{"name":"Tom","age":22}]}');

    Family fam2 = Family.fromJson(map);
    expect(dump('fam2', fam2),
        'Family fam2 = Sells Family: People: [John is 25 years old, Tom is 22 years old]');

    dynamic map2 = jsonDecode(json);
    expect(dump('map2', map2),
        '_InternalLinkedHashMap<String, dynamic> map2 = {name: Sells, people: [{name: John, age: 25}, {name: Tom, age: 22}]}');

    Family fam3 = Family.fromJson(map2);
    expect(dump('fam3', fam3),
        'Family fam3 = Sells Family: People: [John is 25 years old, Tom is 22 years old]');
  });

  test('Person w/ missing fields', () {
    var json = '{"name":"John"}';
    var john = Person.fromJson(jsonDecode(json));
    expect(john.name, 'John');
    expect(john.age, null);
  });

  test('Person w/ extra fields', () {
    var json = '{"name": "John", "age": 25, "eyes": "blue"}';
    var john = Person.fromJson(jsonDecode(json));
    expect(john.name, 'John');
    expect(john.age, 25);
  });

  test('Empty People', () {
    var json1 = '[]';
    var people = People.fromJson(jsonDecode(json1));

    var json2 = jsonEncode(people);
    expect(json2, json1);

    people.add(Person('Tom', 23));
    expect(people.items.first.name, 'Tom');
  });

  test('Family w/ empty People (1)', () {
    var json1 = '{"name": "Sells", "people": []}';
    var fam = Family.fromJson(jsonDecode(json1));

    var json2 = jsonEncode(fam);
    expect(json2, '{"name":"Sells","people":[]}');

    fam.people.add(Person('Tom', 23));
    expect(fam.people.items.first.name, 'Tom');
  });

  test('Family w/ empty People (2)', () {
    var json1 = '{"name": "Sells"}';
    var fam = Family.fromJson(jsonDecode(json1));

    var json2 = jsonEncode(fam);
    expect(json2, '{"name":"Sells","people":[]}');

    fam.people.add(Person('Tom', 23));
    expect(fam.people.items.first.name, 'Tom');
  });
}
