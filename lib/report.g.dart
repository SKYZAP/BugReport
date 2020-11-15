// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
    json['title'] as String,
    json['body'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
    };
