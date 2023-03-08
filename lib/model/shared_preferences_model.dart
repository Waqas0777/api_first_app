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

  //api todos calling status
  void setTodoApiCallStatus(bool value) {
    prefs.setBool("todoApiCallStatus", value);
  }
  bool getTodoApiCallStatus() {
    return prefs.getBool("todoApiCallStatus") ?? false;
  }//end

  //api posts calling status
  void setUserPostsApiCallStatus(bool value) {
    prefs.setBool("postApiCallStatus", value);
  }
  bool getUserPostsApiCallStatus() {
    return prefs.getBool("postApiCallStatus") ?? false;
  }
  //end


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
  void setUser(String user){
    prefs.setString("user", user);
  }
  String getUser(String model){
    return prefs.getString(model)??"";
  }


// Stream<List<PostTableData>> postList(){
//
//   return getIt<AppDatabase>().postTableDao.getAllPostsByEmailAddress;
// }
}