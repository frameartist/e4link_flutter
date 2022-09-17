class E4Device {
  String id;
  String name;
  bool isAllowed;
  Map readings = {};
  E4Device(this.id, this.name, this.isAllowed);
}

class E4Event {
  String id;
  E4EventType dataType;
  double timestamp;
  var value;
  E4Event(this.id, this.dataType, this.timestamp, this.value);
}

enum E4EventType {
  bvp("bvp"),
  tmp("tmp"),
  //TODO: add more
  connected("connected"),
  unknown("unknown");

  const E4EventType(String this.value);
  final String value;
}
