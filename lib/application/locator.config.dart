// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:ottaa_project_flutter/application/common/i18n.dart' as _i3;
import 'package:ottaa_project_flutter/application/service/about_service.dart' as _i41;
import 'package:ottaa_project_flutter/application/service/auth_service.dart' as _i15;
import 'package:ottaa_project_flutter/application/service/customise_service.dart' as _i25;
import 'package:ottaa_project_flutter/application/service/groups_service.dart' as _i43;
import 'package:ottaa_project_flutter/application/service/hive_database.dart' as _i5;
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart' as _i7;
import 'package:ottaa_project_flutter/application/service/mobile_remote_storage_service.dart' as _i34;
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart' as _i45;
import 'package:ottaa_project_flutter/application/service/profile_services.dart' as _i32;
import 'package:ottaa_project_flutter/application/service/report_service.dart' as _i36;
import 'package:ottaa_project_flutter/application/service/sentences_service.dart' as _i38;
import 'package:ottaa_project_flutter/application/service/server_service.dart' as _i9;
import 'package:ottaa_project_flutter/application/service/tts_service.dart' as _i11;
import 'package:ottaa_project_flutter/application/service/web_remote_storage_service.dart' as _i39;
import 'package:ottaa_project_flutter/application/use_cases/create_email_token_impl.dart' as _i17;
import 'package:ottaa_project_flutter/application/use_cases/create_group_impl.dart' as _i19;
import 'package:ottaa_project_flutter/application/use_cases/create_phrase_impl.dart' as _i21;
import 'package:ottaa_project_flutter/application/use_cases/create_picto_impl.dart' as _i23;
import 'package:ottaa_project_flutter/application/use_cases/learn_pictogram_impl.dart' as _i27;
import 'package:ottaa_project_flutter/application/use_cases/predict_pictogram_impl.dart' as _i30;
import 'package:ottaa_project_flutter/application/use_cases/verify_email_token_impl.dart' as _i13;
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart' as _i40;
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart' as _i14;
import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart' as _i24;
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart' as _i42;
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart' as _i4;
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart' as _i6;
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart' as _i44;
import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart' as _i31;
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart' as _i33;
import 'package:ottaa_project_flutter/core/repositories/report_repository.dart' as _i35;
import 'package:ottaa_project_flutter/core/repositories/repositories.dart' as _i28;
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart' as _i37;
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart' as _i8;
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart' as _i10;
import 'package:ottaa_project_flutter/core/use_cases/create_email_token.dart' as _i16;
import 'package:ottaa_project_flutter/core/use_cases/create_group_data.dart' as _i18;
import 'package:ottaa_project_flutter/core/use_cases/create_phrase_data.dart' as _i20;
import 'package:ottaa_project_flutter/core/use_cases/create_picto_data.dart' as _i22;
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart' as _i26;
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart' as _i29;
import 'package:ottaa_project_flutter/core/use_cases/verify_email_token.dart' as _i12;

const String _mobile = 'mobile';
const String _web = 'web';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await gh.singletonAsync<_i3.I18N>(
      () => _i3.I18N.start(),
      preResolve: true,
    );
    await gh.singletonAsync<_i4.LocalDatabaseRepository>(
      () => _i5.HiveDatabase.start(),
      preResolve: true,
    );
    gh.singleton<_i6.LocalStorageRepository>(_i7.LocalStorageService());
    gh.singleton<_i8.ServerRepository>(_i9.ServerService());
    gh.singleton<_i10.TTSRepository>(_i11.TTSService());
    gh.singleton<_i12.VerifyEmailToken>(_i13.VerifyEmailTokenImpl(gh<_i8.ServerRepository>()));
    gh.singleton<_i14.AuthRepository>(_i15.AuthService(
      gh<_i4.LocalDatabaseRepository>(),
      gh<_i8.ServerRepository>(),
    ));
    gh.singleton<_i16.CreateEmailToken>(_i17.CreateEmailTokenImpl(gh<_i8.ServerRepository>()));
    gh.singleton<_i18.CreateGroupData>(_i19.CreateGroupDataImpl(gh<_i8.ServerRepository>()));
    gh.singleton<_i20.CreatePhraseData>(_i21.CreatePhraseDataImpl(gh<_i8.ServerRepository>()));
    gh.singleton<_i22.CreatePictoData>(_i23.CreatePictoDataImpl(gh<_i8.ServerRepository>()));
    gh.singleton<_i24.CustomiseRepository>(_i25.CustomiseService(gh<_i8.ServerRepository>()));
    gh.singleton<_i26.LearnPictogram>(_i27.LearnPictogramImpl(serverRepository: gh<_i28.ServerRepository>()));
    gh.singleton<_i29.PredictPictogram>(_i30.PredictPictogramImpl(serverRepository: gh<_i28.ServerRepository>()));
    gh.singleton<_i31.ProfileRepository>(_i32.ProfileService(gh<_i8.ServerRepository>()));
    gh.singleton<_i33.RemoteStorageRepository>(
      _i34.MobileRemoteStorageService(
        gh<_i14.AuthRepository>(),
        gh<_i8.ServerRepository>(),
        gh<_i3.I18N>(),
      ),
      registerFor: {_mobile},
    );
    gh.singleton<_i35.ReportRepository>(_i36.ReportService(gh<_i8.ServerRepository>()));
    gh.singleton<_i37.SentencesRepository>(_i38.SentencesService(
      gh<_i14.AuthRepository>(),
      gh<_i8.ServerRepository>(),
    ));
    gh.factory<_i39.WebRemoteStorageService>(
      () => _i39.WebRemoteStorageService(
        gh<_i14.AuthRepository>(),
        gh<_i8.ServerRepository>(),
        gh<_i3.I18N>(),
      ),
      registerFor: {_web},
    );
    gh.singleton<_i40.AboutRepository>(_i41.AboutService(
      gh<_i14.AuthRepository>(),
      gh<_i8.ServerRepository>(),
      gh<_i4.LocalDatabaseRepository>(),
    ));
    gh.singleton<_i42.GroupsRepository>(_i43.GroupsService(
      gh<_i14.AuthRepository>(),
      gh<_i33.RemoteStorageRepository>(),
      gh<_i8.ServerRepository>(),
    ));
    gh.singleton<_i44.PictogramsRepository>(_i45.PictogramsService(
      gh<_i14.AuthRepository>(),
      gh<_i8.ServerRepository>(),
      gh<_i33.RemoteStorageRepository>(),
    ));
    return this;
  }
}
