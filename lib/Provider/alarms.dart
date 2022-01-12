import 'package:first_app/modals/alarm_modal.dart';
import 'package:flutter/foundation.dart';

class Alarms extends ChangeNotifier {
  final List<Alarm> _alarmList = [
    Alarm(
        dateTime: DateTime(2021, 1, 1, 1, 20, 5),
        music: 'song1',
        selected: true),
  ];

  void initAlarm() {
    //TODO: Get alarms from memory
  }

  void selectAlarm(int index) {
    _alarmList.every((element) => element.selected = false);
    _alarmList[index].selected = true;
    notifyListeners();
  }

  void addAlarm(
      {required DateTime dateTime,
      required String music,
      required bool isSelected}) {
    _alarmList
        .add(Alarm(dateTime: dateTime, music: music, selected: isSelected));
  }

  List<Alarm> getAlarm() {
    if (_alarmList.isEmpty) throw Exception('NO ALARMS AVAILABLE');
    return _alarmList;
  }
}
