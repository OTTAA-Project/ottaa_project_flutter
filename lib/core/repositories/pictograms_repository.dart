import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';

abstract class PictogramsRepository {
  Future<List<Pict>> getAllPictograms();

  Future<void> uploadPictograms(
      List<Pict> data, String language,{String? userId});

  Future<void> updatePictogram(Pict pictogram, String language, int index);

  Future<List<Pict>> getPictograms(BasicSearch search);
}
