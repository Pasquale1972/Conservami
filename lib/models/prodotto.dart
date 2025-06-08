import 'package:hive/hive.dart';

part 'prodotto.g.dart';

@HiveType(typeId: 0)
class Prodotto extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String codiceABarre;

  @HiveField(2)
  DateTime dataScadenza;

  @HiveField(3)
  String nutriScore;

  @HiveField(4)
  List<String> additivi;

  @HiveField(5)
  List<String> allergeni;

  @HiveField(6)
  String immagineUrl;

  Prodotto({
    required this.nome,
    required this.codiceABarre,
    required this.dataScadenza,
    this.nutriScore = '',
    this.additivi = const [],
    this.allergeni = const [],
    this.immagineUrl = '',
  });
}
