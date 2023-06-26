import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/models/arsaac_data_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

abstract class CreatePictoRepository {
  Future<List<Group>> fetchUserGroups({required String languageCode, required String userId});

  Future<List<Picto>> fetchUserPictos({required String languageCode, required String userId});

  Future<Either<String, List<ArsaacDataModel>>> fetchPhotosFromGlobalSymbols({required String searchText, required String languageCode});

  Future<String> uploadOtherImages({required String imagePath, required String directoryPath, required String name, required String userId});
}
