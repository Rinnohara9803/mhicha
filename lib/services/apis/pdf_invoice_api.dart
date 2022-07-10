import 'dart:io';
import 'package:mhicha/services/apis/pdf_api.dart';
import 'package:pdf/widgets.dart';

import '../../models/student.dart';

class PdfInvoiceApi {
  static Future<File> generate(Student student) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildInvoiceLayout(student),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('This is pdf'),
            ],
          ),
        ],
      ),
    );

    return PdfApi.saveDocument(name: 'student1.pdf', pdf: pdf);
  }

  static Widget buildInvoiceLayout(
    Student student,
  ) {
    return Center(
      child: Text(student.firstName),
    );
  }

  static Widget buildTop(student) => Column(
        children: [
          Text(
            student.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
