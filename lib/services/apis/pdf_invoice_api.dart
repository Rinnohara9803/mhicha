import 'dart:io';
import 'package:mhicha/models/student.dart';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:open_document/open_document.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate(Student student) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          buildInvoiceLayout(student),
        ],
      ),
    );

    return PdfApi.saveDocument(name: 'student1', pdf: pdf);
  }

  static pw.Widget buildInvoiceLayout(Student student) {
    return pw.Center(
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(student.firstName),
          pw.Text(student.lastName),
          pw.Text(student.age.toString()),
        ],
      ),
    );
  }
}
