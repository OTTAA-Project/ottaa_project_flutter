import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/src/either.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/language/file_language.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';

void main(){
  LocalStorageService localStorageService = LocalStorageService();
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Test Local Storage Service ', () {
  group('Test es-AR', () {
    test('Write Groups ES', () async {
      String result = await rootBundle.loadString('assets/gender_based/grupos/grupos_es_male.json');
      await localStorageService.writeGruposToFile(data: result, language: 'es-AR');
    });
    test('Read Groups ES',() async {
      List esG = await localStorageService.readGruposFromFile(language:'es-AR');
      print( esG);
    });
    test('WritePictograms ES', () async {
      String result = await rootBundle.loadString('assets/gender_based/pictos/pictos_es_male.json');
      await localStorageService.writePictoToFile(data: result, language: 'es-AR');
    });
    test('Read Pictograms ES',() async {
      List esG = await localStorageService.readPictoFromFile(language:'es-AR');
      print( esG);
    });
  });
  group('Test en-US', () {
    test('Write Groups EN', () async {
      String result = await rootBundle.loadString('assets/grupos.json');
      await localStorageService.writeGruposToFile(data: result, language: 'en-US');
    });
    test('Read Groups EN',() async {
      List en = await localStorageService.readGruposFromFile(language:'en-US');
      print( en);
    });
    test('Read Pictos EN', () async {
      String result = await rootBundle.loadString('assets/pictos.json');
      await localStorageService.writePictoToFile(data: result, language: 'en-US');
    });
    test('Read Pictos EN',() async {
      List en = await localStorageService.readPictoFromFile(language:'en-US');
      print( en);
    });
  });
  group('Test fr-FR', () {
    test('Write Groups fr', () async {
      String result = await rootBundle.loadString('assets/languages/grupos_fr.json');
      await localStorageService.writeGruposToFile(data: result, language: 'fr-FR');
    });
    test('Read Groups fr',() async {
      List en = await localStorageService.readGruposFromFile(language:'fr-FR');
      print( en);
    });
    test('Write Pictos fr', () async {
      String result = await rootBundle.loadString('assets/languages/pictos_fr.json');
      await localStorageService.writePictoToFile(data: result, language: 'fr-FR');
    });
    test('Read Pictos fr',() async {
      List en = await localStorageService.readPictoFromFile(language:'fr-FR');
      print( en);
    });
  });
  group('Test pt-BR', () {
    test('Write Groups pt', () async {
      String result = await rootBundle.loadString('assets/languages/grupos_pt.json');
      await localStorageService.writeGruposToFile(data: result, language: 'pt-BR');
    });
    test('Read Groups pt',() async {
      List en = await localStorageService.readGruposFromFile(language:'pt-BR');
      print( en);
    });
    test('Write Pictos pt', () async {
      String result = await rootBundle.loadString('assets/languages/pictos_pt.json');
      await localStorageService.writePictoToFile(data: result, language: 'pt-BR');
    });
    test('Read Pictos pt',() async {
      List en = await localStorageService.readPictoFromFile(language:'pt-BR');
      print( en);
    });
  });
  group('Test default', () {
    test('Write Groups EN', () async {
      String result = await rootBundle.loadString('assets/grupos.json');
      await localStorageService.writeGruposToFile(data: result, language: 'it-IT');
    });
    test('Read Groups EN',() async {
      List en = await localStorageService.readGruposFromFile(language:'it-IT');
      print( en);
    });
    test('Read Pictos EN', () async {
      String result = await rootBundle.loadString('assets/pictos.json');
      await localStorageService.writePictoToFile(data: result, language: 'it-IT');
    });
    test('Read Pictos EN',() async {
      List en = await localStorageService.readPictoFromFile(language:'it-IT');
      print( en);
    });
  });

  });
}