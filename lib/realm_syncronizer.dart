import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:realm_db/shared/service/realm_base_service.dart';
import 'package:realm_db/shared/util/config.dart';

class RealmSyncronizer {
  static List<SchemaObject> schemaList = [];
  static Future syncronize() async {
    RealmSyncronizer.schemaList = [
      //@model
      // // UserProfile.schema,
      // // VendorServiceItem.schema,
      // // VendorStaffItem.schema,
      // // VendorGalleryItem.schema,
      // // VendorReviewItem.schema,
      // // Vendor.schema,
      // // Order.schema,
      // // UserFavoriteVendor.schema,
      // // ExampleUser.schema,
      // // Supplier.schema,
      // // Employee.schema,
      // // Project.schema,
      // // Drill.schema,
      //:@model
    ];

    var path = await getTemporaryDirectory();
    var disconnectedMode = true;
    realmInstance = Realm(Configuration.disconnectedSync(
      schemaList,
      // path: "${Directory.current.path}\\local_realm",
      path: "${path.path}\\xxx",
      // AuthService.currentUser!,
      // schemaList,
    ));
    print("syncronize running..");
    if (RealmDBConfig.disconnectedMode == false) {
      for (var subscription in realmInstance.subscriptions) {
        if (subscription.name!.contains("${DateTime.now()}Subscription")) {
          return;
        }
      }
    }

    //@syncronizer
    // // await UserProfileService.instance.syncronize();
    // // await VendorService.instance.syncronize();
    // // await VendorGalleryItemService.instance.syncronize();
    // // await VendorReviewItemService.instance.syncronize();
    // // await VendorServiceItemService.instance.syncronize();
    // // await VendorStaffItemService.instance.syncronize();
    // // await OrderService.instance.syncronize();
    // // await UserFavoriteVendorService.instance.syncronize();
    // // await ExampleUserService.instance.syncronize();
    // // await SupplierService.instance.syncronize();
    // // await EmployeeService.instance.syncronize();
    // // await ProjectService.instance.syncronize();
    // // await DrillService.instance.syncronize();
    //:@syncronizer
  }
}
