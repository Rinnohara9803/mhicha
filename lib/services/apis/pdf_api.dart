// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart';

// class PdfApi {
//   static Future<File> saveDocument(
//       {required String name, required Document pdf}) async {
//     final bytes = pdf.save();
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$name');

//     // await file.writeAsBytes(bytes);
//     return file;
//   }

//   static Future openFile(File file) async {
//     final url = file.path;
//   }
// }
