import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/service/firebase_database_service.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseService _firebaseDatabaseService = Get.find<FirebaseDatabaseService>();

  Future<List<Pict>> fetchPictos() async {
    return _firebaseDatabaseService.fetchPictos();
  }

  Future<List<Grupos>> fetchGrupos()async{
    return _firebaseDatabaseService.fetchGrupos();
  }
}
