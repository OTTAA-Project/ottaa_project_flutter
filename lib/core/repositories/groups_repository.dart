import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';

abstract class GroupsRepository {
  Future<List<Group>> getAllGroups({bool defaultGroups = false});

  Future<List<Group>> getDefaultGroups();

  Future<void> uploadGroups(List<Group> data, String type, String language);

  Future<void> updateGroups(Group data, String type, String language, int index);

  Future<List<Group>> getGroups(BasicSearch search);
}
