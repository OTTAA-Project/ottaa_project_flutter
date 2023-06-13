import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';

import 'package:ottaa_project_flutter/application/providers/chatgpt_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/chatgpt_repository.dart';

import 'chatgpt_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PatientNotifier>(),
  MockSpec<UserNotifier>(),
  MockSpec<ChatGPTRepository>(),
  MockSpec<I18N>(),
])
Future<void> main() async {
  late MockUserNotifier mockUserNotifier;
  late MockPatientNotifier mockPatientNotifier;
  late MockChatGPTRepository mockChatGPTRepository;

  late ChatGPTNotifier chatGPTNotifier;

  late PatientUserModel fakeUser;
  late List<Picto> fakePictos;

  setUpAll(() {
    MockI18N mockI18N = MockI18N();

    GetIt.I.registerSingleton<I18N>(mockI18N);
  });

  setUp(() {
    mockUserNotifier = MockUserNotifier();
    mockPatientNotifier = MockPatientNotifier();
    mockChatGPTRepository = MockChatGPTRepository();
    fakeUser = PatientUserModel(
      id: "0",
      settings: PatientSettings(
        accessibility: AccessibilitySetting.empty(),
        layout: LayoutSetting.empty(),
        payment: Payment.none(),
        tts: TTSSetting.empty(),
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
      groups: {},
      phrases: {},
      pictos: {},
    );
    mockPatientNotifier.state = fakeUser;
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
  test("should return chatGPTProvider", () {
    GetIt.I.registerSingleton<ChatGPTRepository>(mockChatGPTRepository);

    final container = ProviderContainer(
      overrides: [
        userProvider.overrideWith((ref) => mockUserNotifier),
      ],
    );

    final refGptProvider = container.read(chatGPTProvider);

    expect(refGptProvider, isA<ChatGPTNotifier>());
    expect(chatGPTProvider, isA<ChangeNotifierProvider<ChatGPTNotifier>>());
  });
  group("generate phrase", () {
    test('should return a sentence', () async {
      when(mockUserNotifier.user).thenReturn(fakeUser);
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

    test('should return left error', () async {
      when(mockUserNotifier.user).thenReturn(fakeUser);
      when(mockChatGPTRepository.getCompletion(
        age: anyNamed('age'),
        gender: anyNamed('gender'),
        pictograms: anyNamed('pictograms'),
        language: anyNamed('language'),
        maxTokens: anyNamed('maxTokens'),
      )).thenAnswer((realInvocation) async => const Left("OpenAI Exception"));

      final response = await chatGPTNotifier.generatePhrase(fakePictos);
      print(response);
      expect(response, 'OpenAI Exception');
    });
  });

  test("should notify listeners", () {
    int value = 0;

    chatGPTNotifier.addListener(() {
      value++;
    });

    chatGPTNotifier.notify();

    expect(value, 1);
  });
}
