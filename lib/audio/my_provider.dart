import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chart_data/widget_recod.dart';

class AudioModel extends AudioPlayer {
  AudioModel() : super() {
    setAudioSource(ConcatenatingAudioSource(
        children: [AudioSource.asset("assert/music/Seasons - roljui.mp3")]));
    // backgroundHandler = AudioServiceBackgroundHandler();
  }
}

class AudioProvider extends ChangeNotifier {
  final AudioModel _audioModel = AudioModel();

  //final AudioPlayer _backgroundPlayer = AudioPlayer();
  List<WeightRecord> _records = [];

  List<WeightRecord> get records => _records;
  // List <Map<String, dynamic>>info2 = [
  //   {'featureName': "young-man.png",},
  //   {'featureName': "woman.png",},
  //   {'featureName': "Chest.jpg",},
  //   {'featureName': "Chests.jpg",},
  //   {'featureName': "Chests.jpg",},
  // ];
  // void toggleFeature(int index) {
  //   info2[index]['isEnabled'] = !info2[index]['isEnabled'];
  //   notifyListeners();
  // }

  List<String> _fontList = [
    "Alger",
    "Bradhitc",
    "Brushsci",
    "Freescpt",
    "Harngton",
    "Itcedscr",
  ];


  String _selectedFont = 'Alger';

  List<String> get fontList => _fontList;

  String get selectedFonts => _selectedFont;

  Future<void> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonStringList = prefs.getStringList('weightRecords');
    if (jsonStringList != null) {
      _records = jsonStringList.map((jsonString) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return WeightRecord(
            date: DateTime.parse(jsonMap['date']), weight: jsonMap['weight']);
      }).toList();
      notifyListeners();
    }
  }

  Future<void> addRecord(WeightRecord record) async {
    _records.add(record);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = _records
        .map((record) => json
            .encode({'date': record.date.toString(), 'weight': record.weight}))
        .toList();
    await prefs.setStringList('weightRecords', jsonStringList);
  }
  Future<void> clearRecords() async {
    _records.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('weightRecords');
  }
  void changeFont(String newFont) {
    _selectedFont = newFont;
    notifyListeners();
  }

  Future<void> setAudioSource(String audioUri) async {
    await _audioModel.setUrl("assert/music/Seasons - roljui.mp3");
    //await _backgroundPlayer.setUrl("");
  }

  Future<void> play() async {
    await _audioModel.play();
    //await _backgroundPlayer.play();
    notifyListeners(); // Notify listeners of state change
  }

  Future<void> pause() async {
    await _audioModel.pause();
    //await _backgroundPlayer.pause();
    notifyListeners(); // Notify listeners of state change
  }
  List<FlSpot> getSpots(List<WeightRecord> records) {
    final List<FlSpot> spots = [FlSpot(0,0)];
    for (int i = 0; i < records.length; i++) {
      final record = records[i];
      spots.add(FlSpot(i.toDouble(), record.weight));
    }
    return spots;
  }
}
// class Info extends ChangeNotifier {
//   List <Map<String, dynamic>>info2 = [
//     {'featureName': "young-man.png",},
//     {'featureName': "woman.png",},
//     {'featureName': "Chest.jpg",},
//     {'featureName': "Chests.jpg",},
//     {'featureName': "Chests.jpg",},
//   ];
//   List <Map<String, dynamic>>info3 = [
//     {'featureName': "young-man.png",},
//     {'featureName': "woman.png",},
//     {'featureName': "Chest.jpg",},
//     {'featureName': "Chests.jpg",},
//     {'featureName': "Chests.jpg",},
//   ];
//
//   void toggleFeature(int index) {
//     info2[index]['isEnabled'] = !info2[index]['isEnabled'];
//     notifyListeners();
//   }
// }