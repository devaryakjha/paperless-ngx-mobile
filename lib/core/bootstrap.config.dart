// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i31;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:paperless/app/features/auth/data/services/auth_service.dart'
    as _i82;
import 'package:paperless/core/auth/session_manager.dart' as _i991;
import 'package:paperless/core/network/client.dart' as _i421;
import 'package:paperless/core/network/connectivity_checker.dart' as _i330;
import 'package:paperless/core/storage/secure_storage.dart' as _i252;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final chopperModule = _$ChopperModule();
    gh.singleton<_i31.ChopperClient>(() => chopperModule.chopperClient);
    await gh.singletonAsync<_i252.SecureStorage>(
      () => _i252.SecureStorage.init(),
      preResolve: true,
      dispose: (i) => i.close(),
    );
    await gh.singletonAsync<_i991.SessionManager>(
      () => _i991.SessionManager.init(gh<_i252.SecureStorage>()),
      preResolve: true,
    );
    gh.singleton<_i82.AuthService>(
        () => _i82.AuthService.create(gh<_i31.ChopperClient>()));
    gh.singleton<_i330.ConnectivityChecker>(
        () => _i330.ConnectivityCheckerImpl());
    return this;
  }
}

class _$ChopperModule extends _i421.ChopperModule {}
