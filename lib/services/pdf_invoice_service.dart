import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceService {
  static Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          );
        },
      ),
    );
    return pdf.save();
  }
}
