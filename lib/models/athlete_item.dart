import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'athlete_item.g.dart';

@JsonSerializable()
@embedded
class AthleteItem {
  String athleteNumber;
  String status;
  String message = '';

  AthleteItem(
      {this.athleteNumber = '00000',
      this.status = 'not_verified',
      this.message = ''});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AthleteItem && athleteNumber == other.athleteNumber;
  }

  @override
  int get hashCode => athleteNumber.hashCode;

  factory AthleteItem.fromJson(Map<String, dynamic> json) =>
      _$AthleteItemFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteItemToJson(this);
}
