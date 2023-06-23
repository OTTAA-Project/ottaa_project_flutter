import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/arsaac_data_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

@Singleton(as: CreatePictoRepository)
class CreatePictoServices implements CreatePictoRepository {
  final ServerRepository _serverRepository;

  CreatePictoServices(this._serverRepository);

  @override
  Future<List<Group>> fetchUserGroups({required String languageCode, required String userId}) async {
    final res = await _serverRepository.fetchUserGroups(languageCode: languageCode, userId: userId);
    if (res.isRight) {
      final json = res.right;
      final List<Group> groups = json.keys.map<Group>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Group.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return groups;
    } else {
      return [];
    }
  }

  @override
  Future<Either<String, List<ArsaacDataModel>>> fetchPhotosFromGlobalSymbols({required String searchText, required String languageCode}) async {
    return await _serverRepository.fetchPhotosFromGlobalSymbols(searchText: searchText, languageCode: languageCode);
  }

  @override
  Future<List<Picto>> fetchUserPictos({required String languageCode, required String userId}) async {
    final res = await _serverRepository.fetchUserPictos(languageCode: languageCode, userId: userId);
    if (res.isRight) {
      final json = res.right;
      final List<Picto> pictos = json.keys.map<Picto>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Picto.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return pictos;
    } else {
      return [];
    }
  }
}
