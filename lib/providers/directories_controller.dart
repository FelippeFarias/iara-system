import 'package:get/get.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

class DirectoriesController extends GetxController{
  String? TEMPDIRECTORY = 'Unknown';
  String? DOWNLOADSDIRECTORY = 'Unknown';
  String? APPSUPPORTDIRECTORY = 'Unknown';
  String? DOCUMENTSDIRECTORY = 'Unknown';
  String? CACHEDIRECTORY = 'Unknown';





  Future<void> initDirectories() async {
    String? tempDirectory;
    String? downloadsDirectory;
    String? appSupportDirectory;
    String? documentsDirectory;
    String? cacheDirectory;

    final PathProviderWindows provider = PathProviderWindows();

    try {
      tempDirectory = await provider.getTemporaryPath();
    } catch (exception) {
      tempDirectory = 'Failed to get temp directory: $exception';
    }
    try {
      downloadsDirectory = await provider.getDownloadsPath();
    } catch (exception) {
      downloadsDirectory = 'Failed to get downloads directory: $exception';
    }

    try {
      documentsDirectory = await provider.getApplicationDocumentsPath();
    } catch (exception) {
      documentsDirectory = 'Failed to get documents directory: $exception';
    }

    try {
      appSupportDirectory = await provider.getApplicationSupportPath();
    } catch (exception) {
      appSupportDirectory = 'Failed to get app support directory: $exception';
    }

    try {
      cacheDirectory = await provider.getApplicationCachePath();
    } catch (exception) {
      cacheDirectory = 'Failed to get cache directory: $exception';
    }

    TEMPDIRECTORY = tempDirectory;
    DOWNLOADSDIRECTORY = downloadsDirectory;
    APPSUPPORTDIRECTORY = appSupportDirectory;
    DOCUMENTSDIRECTORY = documentsDirectory;
    CACHEDIRECTORY = cacheDirectory;
    update();
  }

}
