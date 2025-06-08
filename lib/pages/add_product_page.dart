import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/prodotto.dart';
import '../services/barcode_service.dart';
import '../services/foodfacts_service.dart';
import '../utils/hive_utils.dart';
import '../utils/notification_utils.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _barcodeController = TextEditingController();
  String _nutriScore = '';
  String _imageUrl = '';
  List<String> _additivi = [];
  List<String> _allergeni = [];
  DateTime? _selectedDate;

  Future<void> _scanBarcode() async {
    final code = await BarcodeService.scanBarcode();
    if (code != null) {
      setState(() {
        _barcodeController.text = code;
      });
      final data = await FoodFactsService.fetchProductData(code);
      if (data != null) {
        setState(() {
          _nomeController.text = data['product_name'] ?? _nomeController.text;
          _nutriScore = data['nutriscore_grade'] ?? '';
          _imageUrl = data['image_front_small_url'] ?? '';
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aggiungi Prodotto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome Prodotto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: 'Codice a barre',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: _scanBarcode,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci o scansiona il barcode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Seleziona data di scadenza'
                        : 'Scadenza: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Scegli Data'),
                  )
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    final prodotto = Prodotto(
                      nome: _nomeController.text,
                      codiceABarre: _barcodeController.text,
                      dataScadenza: _selectedDate!,
                      nutriScore: _nutriScore,
                      additivi: _additivi,
                      allergeni: _allergeni,
                      immagineUrl: _imageUrl,
                    );
                    await HiveUtils.aggiungiProdotto(prodotto);
                    await NotificationUtils.scheduleNotification(
                      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                      title: 'Prodotto in scadenza',
                      body: '${prodotto.nome} scade domani',
                      scheduledDate: prodotto.dataScadenza.subtract(const Duration(days: 1)),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Salva'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

