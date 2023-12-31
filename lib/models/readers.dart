import 'package:iara/interfaces/isar_model.dart';
import 'package:iara/models/athlete_management.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

import 'athlete_item.dart';

part 'readers.g.dart';

@JsonSerializable()
@collection
class Readers extends IsarModel {
  Id id;
  DateTime createdAt;
  AthleteManagement athleteManagement;
  String eventCode = '00000';
  String chipStartNumber = '00000';
  String chipEndNumber = '00000';

  Readers({
    this.id = 92831962,
    required this.createdAt,
    required this.athleteManagement,
    this.eventCode = '00000',
    this.chipStartNumber = '00000',
    this.chipEndNumber = '00000',
  });

  factory Readers.fromJson(Map<String, dynamic> json) =>
      _$ReadersFromJson(json);

  Map<String, dynamic> toJson() => _$ReadersToJson(this);

  @override
  int get isarId => id;
}
