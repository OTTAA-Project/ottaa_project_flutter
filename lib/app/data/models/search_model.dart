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
    required this.imagePNGURL,
    required this.name,
    required this.wordTYPE,
    required this.CreationDate,
    required this.ModificationDate,
    required this.thumbnailURL,
  });

  String imagePNGURL;
  String name;
  String wordTYPE;
  DateTime CreationDate;
  DateTime ModificationDate;
  String thumbnailURL;

  factory Symbol.fromJson(Map<String, dynamic> json) => _$SymbolFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolToJson(this);
}
