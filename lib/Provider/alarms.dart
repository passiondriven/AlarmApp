class Alarm {
  late final DateTime dateTime;
  late final String music;
  Alarm({
    required this.dateTime,
    required this.music,
  });
}

class Alarms {
  final List<Alarm> _alarmList = [];

  void addAlarm({required DateTime dateTime, required String music}) {
    _alarmList.add(Alarm(dateTime: dateTime, music: music));
  }

  List<Alarm> getAlarm() {
    if (_alarmList.isEmpty) throw Exception('NO ALARMS AVAILABLE');
    return _alarmList;
  }
}
