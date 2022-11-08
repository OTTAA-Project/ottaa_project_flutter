import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';

abstract class GroupsRepository {
  Future<List<Groups>> getAllGroups();

  Future<void> uploadGroups(List<Groups> data, String type, String language);
  Future<void> updateGroups(Groups data, String type, String language, int index);

  Future<List<Groups>> getGroups(BasicSearch search);
}
