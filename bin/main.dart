// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
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

  Family({String name = null, People people = null}) {
    _name = name;
    _people = people;
  }

  Family.fromJson(Map<String, dynamic> json)
      : this(name: json['name'], people: People.fromJson(json['people']));
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

  Person({String name = null, int age = 0}) {
    _name = name;
    _age = age;
  }

  Person.fromJson(Map<String, dynamic> json) : this(name: json['name'], age: json['age']);
  Map<String, dynamic> toJson() => {'name': name, 'age': age};
  String toString() => '$name is $age years old';
}

void dump(String label, Object o, {String expect = null}) {
  var s = '${o.runtimeType} $label = $o';
  if (expect != null && s != expect) 'ERR: $s';
  print(s);
}

main() {
  print('\nPerson test:');
  {
    Person john = Person(name: 'John', age: 25);
    dump('john', john, expect: 'Person john = John is 25 years old');
    Map<String, dynamic> map = john.toJson();
    dump('map', map, expect: '_InternalLinkedHashMap<String, dynamic> map = {name: John, age: 25}');
    String json = jsonEncode(map);
    dump('json', json, expect: 'String json = {"name":"John","age":25}');
    Person john2 = Person.fromJson(map);
    dump('john2', john2, expect: 'Person john2 = John is 25 years old');
    dynamic map2 = jsonDecode(json);
    dump('map2', map2,
        expect: '_InternalLinkedHashMap<String, dynamic> map2 = {name: John, age: 25}');
    Person john3 = Person.fromJson(map2);
    dump('john3', john3, expect: 'Person john2 = John is 25 years old');
  }

  print('\nPeople test:');
  {
    People boys = People([Person(name: "John", age: 25), Person(name: "Tom", age: 23)]);
    dump('boys', boys, expect: 'People boys = People: [John is 25 years old, Tom is 23 years old]');
    List<dynamic> list = boys.toJson();
    dump('list', list,
        expect: 'List<Map<String, dynamic>> list = [{name: John, age: 25}, {name: Tom, age: 23}]');
    String json = jsonEncode(list);
    dump('json', json, expect: 'String json2 = [{"name":"John","age":25},{"name":"Tom","age":23}]');
    People boys2 = People.fromJson(list);
    dump('boys2', boys2, expect: 'People: [John is 25 years old, Tom is 23 years old]');
    dynamic map = jsonDecode(json);
    dump('map', map, expect: '[{name: John, age: 25}, {name: Tom, age: 23}]');
    People bobs3 = People.fromJson(map);
    dump('bobs3', bobs3, expect: 'People: [John is 25 years old, Tom is 23 years old]');
  }

  print('\nFamily test:');
  {
    Family fam = Family(
      name: "Sells",
      people: People(
        [Person(name: "John", age: 25), Person(name: "Tom", age: 22)],
      ),
    );
    dump("fam", fam, expect: 'Sells Family: People: [John is 25 years old, Tom is 22 years old]');
    Map<String, dynamic> map = fam.toJson();
    dump('map', map,
        expect:
            '_InternalLinkedHashMap<String, dynamic> map = {name: Sells, people: [{name: John, age: 25}, {name: Tom, age: 22}]}');
    String json = jsonEncode(map);
    dump('json', json,
        expect: '{"name":"Sells","people":[{"name":"John","age":25},{"name":"Tom","age":22}]}');
    Family fam2 = Family.fromJson(map);
    dump('fam2', fam2, expect: 'Sells Family: People: [John is 25 years old, Tom is 22 years old]');
    dynamic map2 = jsonDecode(json);
    dump('map2', map2,
        expect: '{name: Sells, people: [{name: John, age: 25}, {name: Tom, age: 22}]}');
    Family fam3 = Family.fromJson(map2);
    dump('fam3', fam3, expect: 'Sells Family: People: [John is 25 years old, Tom is 22 years old]');
  }
}
