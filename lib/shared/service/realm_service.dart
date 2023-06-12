import 'package:realm/realm.dart';
import 'package:realm_db/shared/util/config.dart';

import '../../realm_syncronizer.dart';
import 'auth_service.dart';

class RealmService {
  static late App app;
  static late AppConfiguration appConfiguration;
  static init() {
    Map realmConfig = {
      "appId": RealmDBConfig.appId,
      "appUrl": RealmDBConfig.appUrl,
      "baseUrl": RealmDBConfig.baseUrl,
      "dataSourceName": RealmDBConfig.dataSourceName,
    };

    String appId = realmConfig["appId"];
    appConfiguration = AppConfiguration(appId);
    app = App(appConfiguration);
  }

  static bool syncronized = false;
  static Future syncronizeAll() async {
    if (AuthService.instance.currentUser == null) return;
    syncronized = false;
    await RealmSyncronizer.syncronize();
    syncronized = true;
    return true;
  }
}
