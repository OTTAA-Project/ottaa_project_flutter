// import 'dart:convert';
// import 'dart:io';
//
// import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
// import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
// import 'package:path_provider/path_provider.dart';
//
// class LocalFileController {
//   static LocalFileController? _instance;
//
//   LocalFileController._internal();
//
//   factory LocalFileController() =>
//       _instance ??= LocalFileController._internal();
//
//   Future<String> get _directoryPath async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   Future<File> get _gruposEnglishFile async {
//     final path = await _directoryPath;
//     return File('$path/en-US_grupo.json');
//   }
//
//   Future<File> get _gruposEspanolFile async {
//     final path = await _directoryPath;
//     return File('$path/es-AR_grupo.json');
//   }
//
//   Future<File> get _gruposFrenchFile async {
//     final path = await _directoryPath;
//     return File('$path/fr-FR_grupo.json');
//   }
//
//   Future<File> get _gruposPortugueseFile async {
//     final path = await _directoryPath;
//     return File('$path/pt-BR_grupo.json');
//   }
//
//   Future<File> get _pictoEnglishFile async {
//     final path = await _directoryPath;
//     return File('$path/en-US.json');
//   }
//
//   Future<File> get _pictoEspanolFile async {
//     final path = await _directoryPath;
//     return File('$path/es-AR.json');
//   }
//
//   Future<File> get _pictoFrenchFile async {
//     final path = await _directoryPath;
//     return File('$path/fr-FR.json');
//   }
//
//   Future<File> get _pictoPortugueseFile async {
//     final path = await _directoryPath;
//     return File('$path/pt-BR.json');
//   }
//
//   Future<void> writeGruposToFile({
//     required String data,
//     required String language,
//   }) async {
//     // final file = await _gruposFile;
//     late File file;
//     switch (language) {
//       case "es-AR":
//         file = await _gruposEspanolFile;
//         break;
//       case "en-US":
//         file = await _gruposEnglishFile;
//         break;
//       case "fr-FR":
//         file = await _gruposFrenchFile;
//         break;
//       case "pt-BR":
//         file = await _gruposPortugueseFile;
//         break;
//       default:
//         file = await _gruposEspanolFile;
//     }
//     await file.writeAsString(data);
//   }
//
//   Future<List<Grupos>> readGruposFromFile({
//     required String language,
//   }) async {
//     // final File file = await _gruposFile;
//     late File file;
//     switch (language) {
//       case "es-AR":
//         file = await _gruposEspanolFile;
//         break;
//       case "en-US":
//         file = await _gruposEnglishFile;
//         break;
//       case "fr-FR":
//         file = await _gruposFrenchFile;
//         break;
//       case "pt-BR":
//         file = await _gruposPortugueseFile;
//         break;
//       default:
//         file = await _gruposEspanolFile;
//     }
//     final response = await file.readAsString();
//     return (jsonDecode(response) as List)
//         .map((e) => Grupos.fromJson(e))
//         .toList();
//   }
//
//   Future<void> writePictoToFile(
//       {required String data, required String language}) async {
//     // final file = await _pictoFile;
//     late File file;
//     switch (language) {
//       case "es-AR":
//         file = await _pictoEspanolFile;
//         break;
//       case "en-US":
//         file = await _pictoEnglishFile;
//         break;
//       case "fr-FR":
//         file = await _pictoFrenchFile;
//         break;
//       case "pt-BR":
//         file = await _pictoPortugueseFile;
//         break;
//       default:
//         file = await _pictoEspanolFile;
//     }
//     await file.writeAsString(data);
//   }
//
//   Future<List<Pict>> readPictoFromFile({required String language}) async {
//     // final file = await _pictoFile;
//     late File file;
//     switch (language) {
//       case "es-AR":
//         file = await _pictoEspanolFile;
//         break;
//       case "en-US":
//         file = await _pictoEnglishFile;
//         break;
//       case "fr-FR":
//         file = await _pictoFrenchFile;
//         break;
//       case "pt-BR":
//         file = await _pictoPortugueseFile;
//         break;
//       default:
//         file = await _pictoEspanolFile;
//     }
//     final response = await file.readAsString();
//     return (jsonDecode(response) as List).map((e) => Pict.fromJson(e)).toList();
//   }
// }
