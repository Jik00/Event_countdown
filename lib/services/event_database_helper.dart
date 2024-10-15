import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event.dart'; // Assuming you have an Event model


class EventDatabaseHelper {
  static final EventDatabaseHelper _instance = EventDatabaseHelper._internal();
  factory EventDatabaseHelper() => _instance;
  static Database? _database;

  EventDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database directory
    String path = join(await getDatabasesPath(), 'events.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the events table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        date TEXT
      )
    ''');
  }

  // Insert a new event
  Future<int> insertEvent(Event event) async {
    Database db = await database;
    return await db.insert('events', event.toMap());
  }

  // Fetch all events
  Future<List<Event>> getEvents() async {
    Database db = await database;
    final List<Map<String, dynamic>> eventMaps = await db.query('events');

    return List.generate(eventMaps.length, (i) {
      return Event(
        id: eventMaps[i]['id'],
        name: eventMaps[i]['name'],
        date: DateTime.parse(eventMaps[i]['date']),
      );
    });
  }

  // Update an event
  Future<int> updateEvent(Event event) async {
    Database db = await database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  // Delete an event
  Future<int> deleteEvent(int id) async {
    Database db = await database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
