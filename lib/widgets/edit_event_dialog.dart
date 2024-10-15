import 'package:flutter/material.dart';
import 'package:event/services/local_notification_service.dart';
import '../view_models/event_view_model.dart';

void showEditEventDialog(BuildContext context, EventViewModel eventViewModel, int index, String eventName, DateTime eventDate) {
  String updatedName = eventName;
  DateTime selectedDate = eventDate;

  showDialog(
    context: context,
    builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final isLargeScreen = screenSize.width > 600;

      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Event',
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
                controller: TextEditingController(text: eventName),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: isLargeScreen ? 18 : 14, // Responsive font size
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  updatedName = value;
                },
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.all(16),
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
              if (updatedName.isNotEmpty) {
                eventViewModel.editEvent(eventViewModel.events[index].id!, updatedName, selectedDate); // Pass event ID here
                LocalNotificationService.showBasicNotification();
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.03,
                vertical: screenSize.height * 0.015,
              ),
            ),
            child: Text(
              'Update',
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
