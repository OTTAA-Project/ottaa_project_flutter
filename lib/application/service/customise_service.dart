import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class CustomiseService implements CustomiseRepository {
  final ServerRepository _serverRepository;

  CustomiseService(this._serverRepository);

  Future<EitherVoid> setShortcutsForUser(
          {required Map<String, dynamic> shortcuts,
          required String userId}) async =>
      await _serverRepository.setShortcutsForUser(
          shortcuts: shortcuts, userId: userId);
}
