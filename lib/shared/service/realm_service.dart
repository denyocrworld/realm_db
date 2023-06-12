import 'package:realm/realm.dart';
import 'package:realm_db/shared/util/config.dart';

import '../../realm_syncronizer.dart';

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
    print("currentUser: ${AuthService.currentUser}");
    if (AuthService.currentUser == null) return;
    syncronized = false;
    await RealmSyncronizer.syncronize();
    print("syncronized!!!");
    syncronized = true;

    await UserProfileService.instance.initUserProfile();
    return true;
  }
}
