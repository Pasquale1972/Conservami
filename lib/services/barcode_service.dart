import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeService {
  static Future<String?> scanBarcode() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Annulla", true, ScanMode.BARCODE);
      if (barcode == '-1') return null;
      return barcode;
    } catch (e) {
      return null;
    }
  }
}
