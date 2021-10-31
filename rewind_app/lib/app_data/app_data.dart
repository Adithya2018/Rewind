import 'package:rewind_app/models/user.dart';

class AppData {
  UserData? userdata;
  String? userName;

  AppData({
    UserData? userdata,
    String? userName,
  }) {
    this.userdata = userdata;
    this.userName = userName;
  }

  AppData copy({
    UserData? userdata,
    String? userName,
  }) =>
      AppData(
        userdata: userdata ?? this.userdata,
        userName: userName ?? this.userName,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppData &&
          runtimeType == other.runtimeType &&
          userName == other.userName;

  @override
  int get hashCode => super.hashCode;
}
