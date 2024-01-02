class EventMeetMannager {
  final dynamic data;
  final String type;
  EventMeetMannager({this.data = '', required this.type });

  @override
  String toString() {
    return 'Event{data: $data, type: $type}';
  }
}