import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:win32/win32.dart';
abstract class FileUtils {
  static String getBaseDir(){
    return "C:\\SwimTime";
  }

 static String getFullFilePath(String filePath) {
    final buffer = wsalloc(MAX_PATH);
    final length = GetFullPathName(TEXT(filePath), MAX_PATH, buffer, nullptr);

    if (length > 0) {
      final fullPath = buffer.toDartString();
      free(buffer);
      return fullPath;
    } else {
      free(buffer);
      throw WindowsException(GetLastError());
    }
  }
 static Directory? pickFolder() {
    final file = DirectoryPicker()..title = 'Select a directory';
    final result = file.getDirectory();
    return result;
  }
 static File? pickFile() {
    final file = OpenFilePicker()
      ..filterSpecification = {
        'Word Document (*.doc)': '*.doc',
        'Web Page (*.htm; *.html)': '*.htm;*.html',
        'Text Document (*.txt)': '*.txt',
        'All Files': '*.*'
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'doc'
      ..title = 'Select a document';

    return file.getFile();
  }
}