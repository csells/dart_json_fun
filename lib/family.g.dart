// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) {
  return Family(
      json['name'] as String,
      (json['people'] as List)
          ?.map((e) =>
              e == null ? null : Person.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FamilyToJson(Family instance) =>
    <String, dynamic>{'name': instance.name, 'people': instance.people};

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(json['name'] as String, json['age'] as int);
}

Map<String, dynamic> _$PersonToJson(Person instance) =>
    <String, dynamic>{'name': instance.name, 'age': instance.age};
