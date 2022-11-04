import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';

abstract class GroupsRepository {
  Future<List<Grupos>> getAllGroups();

  Future<void> uploadGroups(List<Grupos> data, String type, String language);
  Future<void> updateGroups(Grupos data, String type, String language, int index);

  Future<List<Grupos>> getGroups(BasicSearch search);
}
