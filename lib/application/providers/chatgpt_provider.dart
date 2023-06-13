import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

class ChatGPTNotifier extends ChangeNotifier {
  final UserNotifier _userNotifier;
  final PatientNotifier _patientNotifier;
  final ChatGPTRepository _chatGPTRepository;

  ChatGPTNotifier(this._userNotifier, this._patientNotifier, this._chatGPTRepository);

  Future<String?> generatePhrase(List<Picto> pictograms) async {
    final user = _patientNotifier.patient ?? _userNotifier.user!.patient;

    int age = (user.settings.data.birthDate.difference(DateTime.now()).inDays / 365).round().abs();

    String gender = user.settings.data.genderPref;

    String pictogramsString = pictograms.map((e) => e.text).join(", ");

    int maxTokens = (pictograms.length * 10).round().clamp(300, 5100);

    final String lang = user.settings.language.language;

    final response = await _chatGPTRepository.getCompletion(
      age: age,
      gender: gender,
      pictograms: pictogramsString,
      maxTokens: maxTokens,
      language: lang.split('_')[0],
    );

    return response.fold(
      (l) => l,
      (r) => r,
    );
  }

  void notify() {
    notifyListeners();
  }
}

final ChangeNotifierProvider<ChatGPTNotifier> chatGPTProvider = ChangeNotifierProvider<ChatGPTNotifier>((ref) {
  final chatGPTRepository = GetIt.I.get<ChatGPTRepository>();

  final userState = ref.watch(userProvider);
  final patientState = ref.watch(patientNotifier.notifier);
  return ChatGPTNotifier(userState, patientState, chatGPTRepository);
});
