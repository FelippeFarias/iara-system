 import 'package:iara/models/readers.dart';
import 'package:iara/providers/directories_controller.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../interfaces/isar_model.dart';

abstract class IsarDB {
  static late final IsarCollection<Readers>ReadersDB;
  static late final  Isar _ISAR_BOX;

 static Future<void> init() async {
   final dir = Get.find<DirectoriesController>().APPSUPPORTDIRECTORY!;
    _ISAR_BOX = await Isar.open(
     [ReadersSchema],
     directory: dir,
   );
   ReadersDB = _ISAR_BOX.readers;
 }
 static Future<void> clear() async {
   await _ISAR_BOX.writeTxn(() => _ISAR_BOX.clear());
 }

  static Future<void> putAsync( Function() onPut ) async {
    await _ISAR_BOX.writeTxn(() => onPut());
  }
}