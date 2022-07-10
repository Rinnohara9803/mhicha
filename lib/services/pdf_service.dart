import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path;
import 'dart:io';

class PdfService {
  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final dir = await path.getApplicationDocumentsDirectory();
    var filePath = '${dir.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    print('here');
  }
}
