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

          final prodottiList = prodotti.values.toList()
            ..sort((a, b) => a.dataScadenza.compareTo(b.dataScadenza));

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final itemBuilder = (BuildContext context, int index) {
                final prodotto = prodottiList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: prodotto.immagineUrl.isNotEmpty
                        ? Image.network(
                            prodotto.immagineUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.fastfood),
                          )
                        : const Icon(Icons.fastfood),
                    title: Text(prodotto.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scadenza: ${DateFormat('dd/MM/yyyy').format(prodotto.dataScadenza)}',
                        ),
                        if (prodotto.nutriScore.isNotEmpty)
                          Text('Nutri-Score: ${prodotto.nutriScore.toUpperCase()}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => prodotto.delete(),
                    ),
                  ),
                );
              };

              if (isWide) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: prodottiList.length,
                  itemBuilder: itemBuilder,
                );
              } else {
                return ListView.builder(
                  itemCount: prodottiList.length,
                  itemBuilder: itemBuilder,
                );
              }
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

