import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

abstract class PictogramsRepository {
  Future<List<Picto>> getAllPictograms();

  Future<void> uploadPictograms(List<Picto> data, String language);

  Future<void> updatePictogram(Picto pictogram, String language, int index);

  Future<List<Picto>> getPictograms(BasicSearch search);
}
