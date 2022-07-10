// import 'dart:io';
// import 'package:mhicha/services/apis/pdf_api.dart';
// import 'package:pdf/widgets.dart' as pw;

// class Student {
//   final String firstName;
//   final String lastName;
//   final int age;
//   Student(this.firstName, this.lastName, this.age);
// }

// class PdfInvoiceApi {
//   static Future<File> generate(Student student) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           buildInvoiceLayout(student),
//         ],
//       ),
//     );

//     return PdfApi.saveDocument(name: 'student1', pdf: pdf);
//   }

//   static pw.Widget buildInvoiceLayout(Student student) {
//     return pw.SizedBox(
//       // height: pw.PdfPageFormat.cm * 0.8,
//       width: double.infinity,
//       child: pw.Column(
//         mainAxisAlignment: pw.MainAxisAlignment.center,
//         crossAxisAlignment: pw.CrossAxisAlignment.center,
//         children: [
//           pw.Text(student.firstName),
//           pw.Text(student.lastName),
//           pw.Text(student.age.toString()),
//         ],
//       ),
//     );
//   }
// }
