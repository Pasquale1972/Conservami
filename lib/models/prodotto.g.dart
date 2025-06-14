// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prodotto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProdottoAdapter extends TypeAdapter<Prodotto> {
  @override
  final int typeId = 0;

  @override
  Prodotto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prodotto(
      nome: fields[0] as String,
      codiceABarre: fields[1] as String,
      dataScadenza: fields[2] as DateTime,
      nutriScore: fields[3] as String,
      additivi: (fields[4] as List).cast<String>(),
      allergeni: (fields[5] as List).cast<String>(),
      immagineUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Prodotto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.codiceABarre)
      ..writeByte(2)
      ..write(obj.dataScadenza)
      ..writeByte(3)
      ..write(obj.nutriScore)
      ..writeByte(4)
      ..write(obj.additivi)
      ..writeByte(5)
      ..write(obj.allergeni)
      ..writeByte(6)
      ..write(obj.immagineUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdottoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
