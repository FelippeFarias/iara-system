import '../models/readers.dart';
import 'isar_db.dart';

class ReadersDbHelper {

  Future<void> saveReader(Readers reader) async {
    return await IsarDB.putAsync(() => IsarDB.ReadersDB.put(reader));
  }

  Future<Readers?> getLastReader() async {
    return IsarDB.ReadersDB.get(92831962);
  }

  Future<void> clearHeader() async {
    return await IsarDB.putAsync(() => IsarDB.ReadersDB.clear());
  }
}