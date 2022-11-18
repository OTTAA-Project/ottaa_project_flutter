import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';

void main(){
  LocalStorageService localStorageService = LocalStorageService();
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Test Local Storage Service ', () {
  group('Read Groups', () {
    test('es-AR', () async{
      List esG = await localStorageService.readGruposFromFile(language:'es-AR');
      print( esG);

    });
    test('en-Us', () async{
      List enG = await localStorageService.readGruposFromFile(language: 'en-US');
      print( enG);

    });
    test('fr-FR', () async{
      List frG = await localStorageService.readGruposFromFile(language: 'fr-FR');
      print( frG);

    });
    test('pt-BR', () async{
      List ptG = await localStorageService.readGruposFromFile(language: 'pt-BR');
      print( ptG);

    });
    test('failed', () async{
      List failG = await localStorageService.readGruposFromFile(language: 'failed');
      print( failG);

    });
  });
  group('Test Local Storage Service Read Pictograms', () {
    test('Read Pictogram es-AR', () async{
      List esP = await localStorageService.readPictoFromFile(language: 'es-AR');
      print( esP);

    });
    test('Read Pictogram en-Us', () async{
      List enP = await localStorageService.readPictoFromFile(language: 'en-US');
      print( enP);

    });
    test('Read Pictogram fr-FR', () async{
      List frP = await localStorageService.readPictoFromFile(language: 'fr-FR');
      print(frP);

    });
    test('Read Pictogram pt-BR', () async{
      List pt = await localStorageService.readPictoFromFile(language: 'pt-BR');
      print(await pt);
      });
    test('Read Pictogram failed', () async{
      List failedP = await localStorageService.readPictoFromFile(language:'failed');
      print(await failedP);

    });
  });

  });
}