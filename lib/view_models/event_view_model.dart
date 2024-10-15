import 'dart:async';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_database_helper.dart'; // Make sure to import your database helper

class EventViewModel extends ChangeNotifier {
  final EventDatabaseHelper _databaseHelper = EventDatabaseHelper();
  final List<Event> _events = [];
  Timer? _timer;

  EventViewModel() {
    _startTimer();
    fetchEvents(); // Load events from the database on initialization
  }

  List<Event> get events => List.unmodifiable(_events);

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Fetch events from the database
  Future<void> fetchEvents() async {
    _events.clear(); // Clear current list
    final eventList = await _databaseHelper.getEvents(); // Get events from the database
    _events.addAll(eventList); // Add fetched events to the list
    notifyListeners(); // Notify UI of changes
  }

  // Add a new event to the database
  Future<void> addEvent(String name, DateTime date) async {
    final newEvent = Event(name: name, date: date);
    await _databaseHelper.insertEvent(newEvent); // Save event to the database
    await fetchEvents(); // Refresh the events list
  }

  
// Edit an existing event
Future<void> editEvent(int id, String name, DateTime date) async {
  final updatedEvent = Event(id: id, name: name, date: date); // Pass the id here
  await _databaseHelper.updateEvent(updatedEvent); // Update the event in the database
  await fetchEvents(); // Refresh the events list
}


  // Delete an event by its ID
  Future<void> deleteEvent(int id) async {
    await _databaseHelper.deleteEvent(id); // Delete event from the database
    await fetchEvents(); // Refresh the events list
  }

  String getCountdown(DateTime eventDate) {
    final Duration difference = eventDate.difference(DateTime.now());
    if (difference.isNegative) {
      return 'Event passed';
    }
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);
    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }
}
