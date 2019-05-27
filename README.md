Playing around with non-trivial JSON serialization/deserialization in Dart.

Specifically, wanted a model where all fields are private so that can do other things on mutation (like notify listeners) but also where it looks reasonable on the wire (specifically not nesting a list into a map).

I'm using [the toJson conventions used by jsonEncode](https://api.dartlang.org/stable/2.3.1/dart-convert/jsonEncode.html), even though I find it confusing (jsonEncode returns a string but it expects the call to toJson to return a Map<String, dynamic> or a List&lt;dynamic&gt;).

Check out [family.dart](https://github.com/csells/dart_json_fun/blob/master/lib/family.dart) for the types and their support for JSON serialization/deserialization:

```
Family:
  name (String)
  people (custom collection)
    items (Iteratable<Person>)
      name (String)
      age (int)
```

It takes a lot of surprisingly picky code to make all of this work properly. Check out the [tests](https://github.com/csells/dart_json_fun/blob/master/test/json_fun_test.dart) if you want to see what cases I'm supporting.

Enjoy!

P.S. I spent hours figuring this stuff out, but most of it is covered nicely in Pooja Bhaumik's [Parsing complex JSON in Flutter](https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51). Recommended!