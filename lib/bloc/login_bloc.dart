import 'package:biodata/helpers/user_info.dart';

class BiodataBloc {
  static Future biodata() async {
    await UserInfo().biodata();
  }
}
