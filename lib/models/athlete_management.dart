import 'package:iara/database/readers_db_helper.dart';
import 'package:iara/models/readers.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:velocity_x/velocity_x.dart';

import 'athlete_item.dart';

part 'athlete_management.g.dart';

@JsonSerializable()
@embedded
class AthleteManagement {
  List<AthleteItem> athleteList;
  final int totalChipsToVerifyReadOnly;
  int totalChipsToVerify;
  int chipsVerified;

  AthleteManagement(
      {this.athleteList = const <AthleteItem>[],
      this.totalChipsToVerify = 0,
      this.chipsVerified = 0})
      : totalChipsToVerifyReadOnly = totalChipsToVerify;

  void updateCountChipsVerified() {
    totalChipsToVerify = listOnlyNotVerified.length;
    chipsVerified = listOnlyVerified.length;
  }

  void removeAthleteFromList(AthleteItem athlete) {
    int index = athleteList.indexWhere((existingItem) => existingItem.athleteNumber == athlete.athleteNumber);

    if (index != -1) {
      var oldItem = athleteList[index];
      if (oldItem.status == 'not_verified') {
        oldItem.status = 'verified';
        athleteList[index] = oldItem;
        updateCountChipsVerified();
      }
    }

  }

  void updateAthlete(AthleteItem item) {
    athleteList.replaceFirstWhere(
        (item) => item.athleteNumber == item.athleteNumber, item);
  }

  List<AthleteItem> get listOnlyNotVerified =>
      athleteList.where((element) => element.status == 'not_verified').toList();

  List<AthleteItem> get listOnlyVerified =>
      athleteList.where((element) => element.status == 'verified').toList();

  static Set<AthleteItem> generateAthleteList(
      String startNumber, String endNumber) {
    int startNum = int.parse(startNumber);
    int endNum = int.parse(endNumber);
    return {
      for (var i = startNum; i <= endNum; i++)
        AthleteItem(
            athleteNumber: i.toString().padLeft(5, '0'), status: 'not_verified')
    };
  }

  factory AthleteManagement.fromJson(Map<String, dynamic> json) =>
      _$AthleteManagementFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteManagementToJson(this);
}
