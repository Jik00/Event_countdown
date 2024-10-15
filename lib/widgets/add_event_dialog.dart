import 'package:flutter/material.dart';
import '../view_models/event_view_model.dart';

void showAddEventDialog(BuildContext context, EventViewModel eventViewModel) {
  String eventName = '';
  DateTime selectedDate = DateTime.now();

  showDialog(
    context: context,
    builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final isLargeScreen = screenSize.width > 600;

      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Add New Event',
          style: TextStyle(
            color: Colors.black,
            fontSize: isLargeScreen ? 24 : 18, 
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: isLargeScreen ? 18 : 14, 
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  eventName = value;
                },
              ),
              SizedBox(height: screenSize.height * 0.02), 
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03, 
                    vertical: screenSize.height * 0.015,
                  ),
                ),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    selectedDate = picked;
                  }
                },
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isLargeScreen ? 18 : 14, 
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (eventName.isNotEmpty) {
                eventViewModel.addEvent(eventName, selectedDate);
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.all(16)
            ),
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: isLargeScreen ? 18 : 14, 
              ),
            ),
          ),
        ],
      );
    },
  );
}
