import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../audio/my_provider.dart';

class MySharePref {
  // final fontProvider = Provider.of<AudioProvider>(context as BuildContext);
  SharedPreferences? pref;

  Future<void> initPref() async {
    pref = pref ?? await SharedPreferences.getInstance();
  }

  set fonts(String? value) => pref?.setString("font", value ?? 'f1');

  String get fonts => pref?.getString("font") ?? '';
}

final sheredPref = MySharePref();
