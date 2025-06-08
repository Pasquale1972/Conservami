import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/prodotto.dart';
import '../utils/hive_utils.dart';
import 'add_product_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final box = HiveUtils.getProdottiBox();
    return Scaffold(
      appBar: AppBar(
        title: Text('Conservami'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Prodotto> prodotti, _) {
          if (prodotti.isEmpty) {
            return Center(child: Text('Nessun prodotto'));
          }
          return ListView.builder(
            itemCount: prodotti.length,
            itemBuilder: (context, index) {
              final prodotto = prodotti.getAt(index)!;
              return ListTile(
                title: Text(prodotto.nome),
                subtitle: Text(
                  'Scadenza: ${DateFormat('dd/MM/yyyy').format(prodotto.dataScadenza)}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => HiveUtils.eliminaProdotto(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddProductPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

