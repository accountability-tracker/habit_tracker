import "package:isar/isar.dart";

part "meta.g.dart";

// NOTE: only one entry should exist
@Collection()
class AppMetaInfo {
  Id id = 0;

  late String appVersion;

  // Is this needed at all?
  // late String isarVersion;

  AppMetaInfo();

  AppMetaInfo.full(String appVersionArg
  // , String isarVersionArg
  ) {
    appVersion = appVersionArg;
    // isarVersion = isarVersionArg;
  }

  String getAppVersion() {
    return appVersion;
  }

//   String getIsarVersion() {
//     return isarVersion;
//   }

// TODO: should have helpers to update app version and isar version stored
//   void setAppVersion(String app_version_arg) {
//
//   }

//   void setIsarVersion(String isar_version_arg) {
//
//   }
}
