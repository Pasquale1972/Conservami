import 'package:hive/hive.dart';
import '../models/prodotto.dart';

class HiveUtils {
  static const String boxProdotti = 'prodottiBox';

  static Future<void> initBoxes() async {
    await Hive.openBox<Prodotto>(boxProdotti);
  }

  static Box<Prodotto> getProdottiBox() {
    return Hive.box<Prodotto>(boxProdotti);
  }

  static Future<void> aggiungiProdotto(Prodotto prodotto) async {
    final box = getProdottiBox();
    await box.add(prodotto);
  }

  static Future<void> eliminaProdotto(int index) async {
    final box = getProdottiBox();
    await box.deleteAt(index);
  }
}
