class Event {
  final int? id; // Add this line to make id optional
  final String name;
  final DateTime date;

  Event({this.id, required this.name, required this.date}); // Modify the constructor

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map if it's not null
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'], // Extract id from the map
      name: map['name'],
      date: DateTime.parse(map['date']),
    );
  }
}
