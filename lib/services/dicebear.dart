import 'package:develove/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DicebearServices {
  static Future<String> getAvatar(String seed) async {
    String? svgString =
        await SharedPreferencesService.readFromSharedPreference('avatar');
    if (svgString != null) {
      return svgString;
    } else {
      final res = await http
          .get(Uri.parse("https://avatars.dicebear.com/api/miniavs/$seed.svg"));
      await SharedPreferencesService.writeToSharedPreference(
          'avatar', res.body);
      return res.body;
    }
  }
}
