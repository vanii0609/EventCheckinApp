class EventModel {
  const EventModel({
    required this.name,
    required this.capacity,
    required this.date,
  });

  final String name;
  final int capacity;
  final DateTime date;
}