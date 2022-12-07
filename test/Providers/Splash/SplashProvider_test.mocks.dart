// Mocks generated by Mockito 5.3.2 from annotations
// in ottaa_project_flutter/test/Providers/Splash/SplashProvider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i5;

import 'package:either_dart/either.dart' as _i2;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart'
    as _i11;
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart'
    as _i3;
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart' as _i10;
import 'package:ottaa_project_flutter/core/enums/user_types.dart' as _i7;
import 'package:ottaa_project_flutter/core/models/user_model.dart' as _i8;
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart'
    as _i6;
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart'
    as _i9;
import 'package:state_notifier/state_notifier.dart' as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SplashProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockSplashProvider extends _i1.Mock implements _i3.SplashProvider {
  MockSplashProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<bool> checkUserAvatar() => (super.noSuchMethod(
        Invocation.method(
          #checkUserAvatar,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> isFirstTime() => (super.noSuchMethod(
        Invocation.method(
          #isFirstTime,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> fetchUserInformation() => (super.noSuchMethod(
        Invocation.method(
          #fetchUserInformation,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AboutRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAboutRepository extends _i1.Mock implements _i6.AboutRepository {
  MockAboutRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> getEmail() => (super.noSuchMethod(
        Invocation.method(
          #getEmail,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<String> getAppVersion() => (super.noSuchMethod(
        Invocation.method(
          #getAppVersion,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<String> getDeviceName() => (super.noSuchMethod(
        Invocation.method(
          #getDeviceName,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<_i7.UserType> getUserType() => (super.noSuchMethod(
        Invocation.method(
          #getUserType,
          [],
        ),
        returnValue: _i4.Future<_i7.UserType>.value(_i7.UserType.free),
      ) as _i4.Future<_i7.UserType>);
  @override
  _i4.Future<String> getAvailableAppVersion() => (super.noSuchMethod(
        Invocation.method(
          #getAvailableAppVersion,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<void> sendSupportEmail() => (super.noSuchMethod(
        Invocation.method(
          #sendSupportEmail,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> uploadUserInformation() => (super.noSuchMethod(
        Invocation.method(
          #uploadUserInformation,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> uploadProfilePicture(String? photo) => (super.noSuchMethod(
        Invocation.method(
          #uploadProfilePicture,
          [photo],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<String> getProfilePicture() => (super.noSuchMethod(
        Invocation.method(
          #getProfilePicture,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<bool> isCurrentUserAvatarExist() => (super.noSuchMethod(
        Invocation.method(
          #isCurrentUserAvatarExist,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> isFirstTime() => (super.noSuchMethod(
        Invocation.method(
          #isFirstTime,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.Either<String, _i8.UserModel>> getUserInformation() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserInformation,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<String, _i8.UserModel>>.value(
            _FakeEither_0<String, _i8.UserModel>(
          this,
          Invocation.method(
            #getUserInformation,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i8.UserModel>>);
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i9.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isLogged => (super.noSuchMethod(
        Invocation.getter(#isLogged),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<_i2.Either<String, _i8.UserModel>> signIn(_i10.SignInType? type) =>
      (super.noSuchMethod(
        Invocation.method(
          #signIn,
          [type],
        ),
        returnValue: _i4.Future<_i2.Either<String, _i8.UserModel>>.value(
            _FakeEither_0<String, _i8.UserModel>(
          this,
          Invocation.method(
            #signIn,
            [type],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i8.UserModel>>);
  @override
  _i4.Future<_i2.Either<String, bool>> signUp() => (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<String, bool>>.value(
            _FakeEither_0<String, bool>(
          this,
          Invocation.method(
            #signUp,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, bool>>);
  @override
  _i4.Future<_i2.Either<String, _i8.UserModel>> getCurrentUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<String, _i8.UserModel>>.value(
            _FakeEither_0<String, _i8.UserModel>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i8.UserModel>>);
  @override
  _i4.Future<bool> isLoggedIn() => (super.noSuchMethod(
        Invocation.method(
          #isLoggedIn,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<String> runToGetDataFromOtherPlatform({
    required String? email,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #runToGetDataFromOtherPlatform,
          [],
          {
            #email: email,
            #id: id,
          },
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [UserAvatarNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserAvatarNotifier extends _i1.Mock
    implements _i11.UserAvatarNotifier {
  MockUserAvatarNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i12.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);
  @override
  _i4.Stream<int> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<int>.empty(),
      ) as _i4.Stream<int>);
  @override
  int get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: 0,
      ) as int);
  @override
  set state(int? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  int get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: 0,
      ) as int);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void changeAvatar(int? imageId) => super.noSuchMethod(
        Invocation.method(
          #changeAvatar,
          [imageId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  String getAvatar() => (super.noSuchMethod(
        Invocation.method(
          #getAvatar,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  bool updateShouldNotify(
    int? old,
    int? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i12.RemoveListener addListener(
    _i13.Listener<int>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
      ) as _i12.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
