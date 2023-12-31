import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chip_data.g.dart';

@JsonSerializable()
class ChipData {

  String chipCode;
  String athleteId;
  ChipData({   this.chipCode = '',   this.athleteId = ''});

  // JSON serialization
  factory ChipData.fromJson(Map<String, dynamic> json) => _$ChipDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChipDataToJson(this);

  factory ChipData.parseChipData(String chipString) {
    var dataParts = chipString.split(';')[0];
    String eventCode, athleteNumber;

    if (dataParts.length == 16) {
      // Formato: EEEEE000000NNNNN
      eventCode = dataParts.substring(0, 5);
      athleteNumber = dataParts.substring(11, 16);
    } else if (dataParts.length == 24) {
      // Formato: 00000000EEEEE000000NNNNN
      eventCode = dataParts.substring(8, 13);
      athleteNumber = dataParts.substring(18, 23);
    } else {
      throw FormatException("Formato de string de chip inválido");
    }

    return ChipData(chipCode: eventCode, athleteId: athleteNumber);
  }

  bool validateEventCode(  String expectedCode ) {
    return chipCode == expectedCode;
  }

  bool isNumberInRange( String startNumber, String endNumber) {
     int startNum = int.parse(startNumber);
    int endNum = int.parse(endNumber);
    return int.parse(athleteId) >= startNum && int.parse(athleteId) <= endNum;
  }

}
