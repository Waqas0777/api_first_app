import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesModel {
  final SharedPreferences prefs;

  SharedPreferencesModel(this.prefs);

  void setLoginStatus(bool value) {
    prefs.setBool("loginStatus", value);
  }

  bool getLoginStatus() {
    return prefs.getBool("loginStatus") ?? false;
  }

  void setLoginEmail(String value) {
    prefs.setString("loginEmail", value);
  }

  void removeEmail() {
    prefs.remove("loginEmail");
  }

  String getLoginEmail() {
    return prefs.getString("loginEmail") ?? "";
  }



  void setLoginId(int id) async {
    await prefs.setInt("userId", id);
  }
  // int getLoginId()  {
  //   return prefs.getInt("loginId") ?? 0;
  //
  // }
  int getLoginId(String key) => prefs.getInt("userId") ?? 0;

  void setUserName(String userName){
    prefs.setString("userName", userName);

  }

  String getUserName() {
    return prefs.getString("userName") ?? "";
  }

// Stream<List<PostTableData>> postList(){
//
//   return getIt<AppDatabase>().postTableDao.getAllPostsByEmailAddress;
// }
}