import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  SearchModel({
    required this.symbols,
    required this.itemCount,
    required this.page,
    required this.totalItemCount,
    required this.pageCount,
  });

  List<Symbol> symbols;
  int itemCount;
  int page;
  int totalItemCount;
  int pageCount;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}

@JsonSerializable()
class Symbol {
  Symbol({
    required this.imagePngurl,
    required this.name,
    required this.wordType,
    required this.creationDate,
    required this.modificationDate,
    required this.thumbnailUrl,
  });

  String imagePngurl;
  String name;
  String wordType;
  DateTime creationDate;
  DateTime modificationDate;
  String thumbnailUrl;

  factory Symbol.fromJson(Map<String, dynamic> json) => _$SymbolFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolToJson(this);
}
