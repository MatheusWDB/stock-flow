import 'package:frontend/models/product.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePDF {
  GeneratePDF({required this.products});

  List<Product> products;

  generatePDFProduct() async {
    final pw.Document doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(),
        header: _buildHeader,
        footer: _buildPrice,
        build: (context) => _buildContent(context),
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      color: PdfColors.amber,
      height: 150,
      child: pw.Padding(
        padding: pw.EdgeInsets.all(16),
        child: pw.Row(
          children: [
            pw.Column(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(16),
                  child: pw.PdfLogo(),
                ),
                pw.Text(
                  'Fatura',
                )
              ],
            ),
            pw.Column(
              children: [
                pw.Text('text'),
                pw.Text('text'),
                pw.Text('text'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildPrice(pw.Context context) {
    return pw.Container(
      height: 130,
      child: pw.Row(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Column(
              children: [
                _buildQrCode(context),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Text('Use QR'),
                ),
              ],
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Column(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Text('text'),
                ),
                pw.Text('text'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildQrCode(pw.Context context) {
    return pw.Container(
        height: 65,
        width: 65,
        child: pw.BarcodeWidget(
            barcode: pw.Barcode.fromType(pw.BarcodeType.QrCode),
            data: 'invoice_id=${products[0].productId}',
            color: PdfColors.blue));
  }

  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
        padding: pw.EdgeInsets.all(16),
        child: _buildContentClient(),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(16),
        child: _contentTable(context),
      ),
    ];
  }

  pw.Widget _buildContentClient() {
    return pw.Row(
      children: [
        pw.Column(
          children: [
            _titleText('Cliente'),
            _titleText('Cliente'),
          ],
        ),
        pw.Column(
          children: [
            _titleText('Número'),
            _titleText('Data'),
          ],
        ),
      ],
    );
  }

  _titleText(String text) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(16),
      child: pw.Text(text),
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const List<String> tableHeaders = [
      'ID',
      'Nome',
      'Quantidade',
      'Preço de Custo',
      'Preço de Venda'
    ];
    return pw.Table.fromTextArray(
      data: List<List<String>>.generate(
          products.length,
          (row) => List<String>.generate(tableHeaders.length,
              (col) => _getValueIndex(products[row], col))),
    );
  }

  String _getValueIndex(Product product, int col) {
    switch (col) {
      case 0:
        return product.productId.toString();
      case 1:
        return product.name;
      case 2:
        return product.stockQuantity.toString();
      case 3:
        return product.costPrice.toString();
      case 4:
        return product.salePrice.toString();
    }
    return '';
  }
}
