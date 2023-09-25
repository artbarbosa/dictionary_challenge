// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordModelAdapter extends TypeAdapter<WordModel> {
  @override
  final int typeId = 1;

  @override
  WordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordModel(
      word: fields[0] as String,
      definitions: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      pronunciation: fields[2] as String,
      orderWord: fields[3] as OrderWord?,
    );
  }

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.definitions)
      ..writeByte(2)
      ..write(obj.pronunciation)
      ..writeByte(3)
      ..write(obj.orderWord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderWordModelAdapter extends TypeAdapter<OrderWordModel> {
  @override
  final int typeId = 2;

  @override
  OrderWordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderWordModel(
      next: fields[0] as String,
      current: fields[1] as String,
      previous: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderWordModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.next)
      ..writeByte(1)
      ..write(obj.current)
      ..writeByte(2)
      ..write(obj.previous);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderWordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
