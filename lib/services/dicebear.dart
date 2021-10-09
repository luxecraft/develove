import 'package:develove/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum AvatarType {
  miniavs,
  bottts,
}

class DicebearServices {
  static Future<String> getUserAvatar(String seed) async {
    String? svgString =
        await SharedPreferencesService.readFromSharedPreference('avatar');
    if (svgString != null) {
      return svgString;
    } else {
      String newAvatar = await getAvatar(AvatarType.miniavs, seed);
      SharedPreferencesService.writeToSharedPreference('avatar', newAvatar);
      return newAvatar;
    }
  }

  static Future<String> getAvatar(AvatarType avatarType, String seed) async {
    print(seed);
    final res = await http.get(Uri.parse(
        "https://avatars.dicebear.com/api/${avatarType == AvatarType.bottts ? "bottts" : "miniavs"}/$seed.svg"));
    return res.body;
  }
}
