import 'package:frontend/enums/type_enum.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/stock_movement.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePDF {
  GeneratePDF({required this.products, required this.movements});

  final List<Product> products;
  final List<StockMovement> movements;

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  void generatePDFProduct() async {
    final pw.Document doc = pw.Document();

    products.sort((a, b) => a.productId!.compareTo(b.productId!));
    movements.sort((a, b) => a.date!.compareTo(b.date!));

    final List<Product> stockLow =
        products.where((p) => p.stockQuantity <= 5).toList();

    final List<List<Product>> pagingAllProducts =
        paginateItens<Product>(10, null);

    final List<List<Product>> pagingLowStock =
        paginateItens<Product>(10, stockLow);

    final List<List<StockMovement>> pagingMovements =
        paginateItens<StockMovement>(10, null);

    for (List<Product> page in pagingAllProducts) {
      doc.addPage(
        _multiPage(
          (context) => _buildHeader(context, 'Registro de Produtos'),
          null,
          (context) => _buildContent(
              context, 'Todos os Produtos:', 'products', page, null),
        ),
      );
    }
    for (List<Product> page in pagingLowStock) {
      doc.addPage(
        _multiPage(
          (context) => _buildHeader(context, 'Registro de Produtos'),
          null,
          (context) => _buildContent(
              context, 'Produtos com estoque baixo:', 'products', page, null),
        ),
      );
    }
    for (List<StockMovement> page in pagingMovements) {
      doc.addPage(
        _multiPage(
          (context) => _buildHeader(context, 'Registro de Movimentações'),
          null,
          (context) => _buildContent(
              context, 'Todas as movimentações:', 'movements', null, page),
        ),
      );
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  List<List<T>> paginateItens<T>(int pageSize, List<Product>? products) {
    final List<List<T>> paging = [];

    if (T == Product) {
      products ??= this.products;

      for (int i = 0; i < products.length; i += pageSize) {
        paging.add(products.sublist(i,
                i + pageSize > products.length ? products.length : i + pageSize)
            as List<T>);
      }
    }

    if (T == StockMovement) {
      for (int i = 0; i < movements.length; i += pageSize) {
        paging.add(movements.sublist(
            i,
            i + pageSize > movements.length
                ? movements.length
                : i + pageSize) as List<T>);
      }
    }
    return paging;
  }

  pw.MultiPage _multiPage(
    pw.Widget Function(pw.Context context)? header,
    pw.Widget Function(pw.Context context)? footer,
    List<pw.Widget> Function(pw.Context context) build,
  ) {
    return pw.MultiPage(
      pageTheme: const pw.PageTheme(),
      header: header,
      footer: footer,
      build: build,
    );
  }

  pw.Widget _buildHeader(pw.Context context, String title) {
    return pw.Container(
      color: PdfColors.amber,
      height: 100,
      //padding: pw.EdgeInsets.all(8),
      child: pw.Row(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.PdfLogo(),
          ),
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _buildContent(
      pw.Context context,
      String description,
      String productsOrMovements,
      List<Product>? products,
      List<StockMovement>? movements) {
    return [
      pw.Padding(
        padding: const pw.EdgeInsets.all(16),
        child: pw.Row(
          children: [
            pw.Column(
              children: [
                pw.Text(
                  description,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(16),
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Table(
              border: pw.TableBorder.all(),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              columnWidths: {
                0: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(0.5)
                    : const pw.FlexColumnWidth(0.5),
                1: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(1.5)
                    : const pw.FlexColumnWidth(0.9),
                2: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(1.5)
                    : const pw.FlexColumnWidth(0.8),
                3: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(0.5)
                    : const pw.FlexColumnWidth(1),
                4: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(1)
                    : const pw.FlexColumnWidth(1.2),
                5: (productsOrMovements == 'products')
                    ? const pw.FlexColumnWidth(1)
                    : const pw.FlexColumnWidth(0.9),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(
                      'ID',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      (productsOrMovements == 'allProducts' ||
                              productsOrMovements == 'lowStock')
                          ? 'Nome'
                          : 'Produto',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      (productsOrMovements == 'allProducts' ||
                              productsOrMovements == 'lowStock')
                          ? 'Código'
                          : 'Tipo',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      'Qtd.',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      (productsOrMovements == 'allProducts' ||
                              productsOrMovements == 'lowStock')
                          ? 'Preço de Custo'
                          : 'Responsável',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      (productsOrMovements == 'allProducts' ||
                              productsOrMovements == 'lowStock')
                          ? 'Preço de Venda'
                          : 'Data',
                      textAlign: pw.TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            _contentTable(context, productsOrMovements, products, movements),
          ],
        ),
      ),
    ];
  }

  pw.Widget _contentTable(pw.Context context, String productsOrMovements,
      List<Product>? products, List<StockMovement>? movements) {
    return pw.Table(
      border: pw.TableBorder.all(),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      columnWidths: {
        0: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(0.5)
            : const pw.FlexColumnWidth(0.5),
        1: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(1.5)
            : const pw.FlexColumnWidth(0.9),
        2: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(1.5)
            : const pw.FlexColumnWidth(0.8),
        3: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(0.5)
            : const pw.FlexColumnWidth(1),
        4: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(1)
            : const pw.FlexColumnWidth(1.2),
        5: (productsOrMovements == 'products')
            ? const pw.FlexColumnWidth(1)
            : const pw.FlexColumnWidth(0.9),
      },
      children: _buildTableRow(productsOrMovements, products, movements),
    );
  }

  List<pw.TableRow> _buildTableRow(String productsOrMovements,
      List<Product>? products, List<StockMovement>? movements) {
    if (productsOrMovements == 'products') {
      return products!
          .map((p) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      p.productId.toString(),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      p.name,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      p.code,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      p.stockQuantity.toString(),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      currencyFormat.format(p.costPrice),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      currencyFormat.format(p.salePrice),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ))
          .toList();
    }

    return movements!
        .map(
          (m) => pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  m.stockMovementId.toString(),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  this
                      .products
                      .firstWhere((p) => p.productId == m.productId)
                      .name,
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  m.type.displayName,
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  m.type == TypeEnum.IN ? '+${m.quantity}' : '-${m.quantity}',
                  style: pw.TextStyle(
                    color:
                        m.type == TypeEnum.IN ? PdfColors.green : PdfColors.red,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  m.user!.name!,
                  softWrap: true,
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(
                  DateFormat('dd/MM/yy').format(m.date!.toLocal()),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        )
        .toList();
  }
}
