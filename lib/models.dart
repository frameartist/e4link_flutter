class E4Device {
  String id;
  String name;
  bool isAllowed;
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
  bvp; //TODO: add more
}
