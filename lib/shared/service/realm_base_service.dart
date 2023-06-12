import 'package:realm/realm.dart';
import 'package:realm_db/shared/service/realm_service.dart';
import 'package:realm_db/shared/util/config.dart';

import '../../realm_syncronizer.dart';

late Realm realmInstance;

class RealmBaseService<T extends RealmObject> {
  Realm get realm => realmInstance;

  syncronize() async {
    print("syncronize running..");
    if (RealmDBConfig.disconnectedMode == false) {
      for (var subscription in realm.subscriptions) {
        if (subscription.name!.contains("${this}Subscription")) {
          return;
        }
      }
    }

    String queryAllName = "${this}Subscription";
    print("$queryAllName is created!");
    if (RealmDBConfig.disconnectedMode == false) {
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(
          realm.all<T>(),
          name: queryAllName,
          update: true,
        );
      });
      await realm.subscriptions.waitForSynchronization();
    }
  }
}

class DB {
  static DB get instance => DB();

  add<T extends RealmObject>(T item) {
    realmInstance.write(() {
      realmInstance.add<T>(item);
    });
  }

  delete<T extends RealmObject>(T item) {
    realmInstance.write(() {
      realmInstance.delete<T>(item);
    });
  }

  deleteAll<T extends RealmObject>() {
    realmInstance.write(() async {
      var results = get();
      for (var item in results) {
        realmInstance.delete(item as RealmObject);
      }
    });
  }

  RealmResults get<T extends RealmObject>({
    String query = "",
    List<Object?> arguments = const [],
  }) {
    var sortQuery = "TRUEPREDICATE SORT(_id ASC)";
    var realmQuery = sortQuery;
    if (query.isNotEmpty) {
      realmQuery = "$query && $sortQuery";
    }
    return realmInstance.query<T>(realmQuery, arguments);
  }

  snapshot<T extends RealmObject>({
    String query = "",
    List<Object?> arguments = const [],
  }) {
    var sortQuery = "TRUEPREDICATE SORT(_id ASC)";
    var realmQuery = sortQuery;
    if (query.isNotEmpty) {
      realmQuery = "$query && $sortQuery";
    }
    return realmInstance.query<T>(realmQuery, arguments).changes;
  }

  update<T extends RealmObject>(
      T target, Function(T current, T item) callback) {
    realmInstance.write(() {
      // var supplierList = realm.all<Supplier>().query(
      //   r"id == $0",
      //   [item.id],
      // );

      // var current = supplierList.first;
      // current.id = item.id;
      // current.supplierName = item.supplierName;
      // current.city = item.city;
      // current.address = item.address;

      // var list = realmInstance.all<T>().query(
      //   r"id == $0",
      //   [(target as dynamic).id],
      // );
      // var current = list.first;
      var current = DB.instance.find<T>((target as dynamic).id);
      callback(current, target);
    });
  }

  find<T extends RealmObject>(ObjectId objectId) {
    var list = realmInstance.all<T>().query(
      r"id == $0",
      [objectId],
    );
    return list.first;
  }

  init() async {
    RealmService.init();
    await RealmSyncronizer.syncronize();
  }
}
