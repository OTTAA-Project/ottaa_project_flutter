import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

import 'chatgpt_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PatientNotifier>(), MockSpec<UserNotifier>(), MockSpec<ChatGPTRepository>()])
Future<void> main() async {
  late MockUserNotifier mockUserNotifier;
  late MockPatientNotifier mockPatientNotifier;
  late MockChatGPTRepository mockChatGPTRepository;

  late ChatGPTNotifier chatGPTNotifier;

  late BaseUserModel fakeUser;
  late List<Picto> fakePictos;

  setUp(() {
    mockUserNotifier = MockUserNotifier();
    mockPatientNotifier = MockPatientNotifier();
    mockChatGPTRepository = MockChatGPTRepository();
    fakeUser = BaseUserModel(
      id: "0",
      settings: BaseSettingsModel(
        data: UserData(
          avatar: AssetsImage(asset: "test", network: "https://test.com"),
          birthDate: DateTime(2017, 9, 7, 17, 30),
          genderPref: "n/a",
          lastConnection: DateTime(0),
          name: "John",
          lastName: "Doe",
        ),
        language: LanguageSetting.empty(),
      ),
      email: "test@mail.com",
      type: UserType.caregiver,
    );
    mockPatientNotifier.state = PatientUserModel(id: '00', groups: {}, phrases: {}, pictos: {}, settings: fakeUser.settings, email: 'test@test.com');
    mockUserNotifier.setUser(fakeUser);
    fakePictos = [
      Picto(id: 'test1', type: 00, resource: AssetsImage(asset: 'fakeAssets', network: 'fakeNetwork')),
      Picto(id: 'test2', type: 00, resource: AssetsImage(asset: 'fakeAssets', network: 'fakeNetwork')),
      Picto(id: 'test3', type: 00, resource: AssetsImage(asset: 'fakeAssets', network: 'fakeNetwork')),
    ];
    chatGPTNotifier = ChatGPTNotifier(
      mockUserNotifier,
      mockPatientNotifier,
      mockChatGPTRepository,
    );
  });

  test('should return a sentence if the user call for a sentence', () async {
    when(mockUserNotifier.user).thenReturn(fakeUser);
//todo: emir can you look at this
    when(mockChatGPTRepository.getCompletion(
      age: anyNamed('age'),
      gender: anyNamed('gender'),
      pictograms: anyNamed('pictograms'),
      language: anyNamed('language'),
      maxTokens: anyNamed('maxTokens'),
    )).thenAnswer((realInvocation) async => const Right('This is a sentence'));

    final response = await chatGPTNotifier.generatePhrase(fakePictos);
    print(response);
    expect(response, 'This is a sentence');
  });
}
