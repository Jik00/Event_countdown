import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view_models/event_view_model.dart';
import '../views/event_card.dart';

class EventList extends StatelessWidget {
  final EventViewModel eventViewModel;
  final Function(BuildContext, int, String, DateTime) onEdit;
  final Function(int) onDelete;

  const EventList({
    super.key,
    required this.eventViewModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
  
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    return eventViewModel.events.isEmpty
        ? Center(
            child: SvgPicture.asset(
              'lib/assets/images/Event_pic.svg',
              height: isLargeScreen ? screenSize.height * 0.3 : screenSize.height * 0.2, 
              width: isLargeScreen ? screenSize.width * 0.3 : screenSize.width * 0.2,  
            ),
          )
        : ListView.builder(
            itemCount: eventViewModel.events.length,
            itemBuilder: (context, index) {
              final event = eventViewModel.events[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.001,
              //    horizontal: screenSize.width * 0.05, 
                ),
                child: EventCard(
                  eventName: event.name,
                  eventDate: event.date,
                  countdown: eventViewModel.getCountdown(event.date),
                  onEdit: () => onEdit(context, index, event.name, event.date),
                  onDelete: () => onDelete(event.id!),
                ),
              );
            },
          );
  }
}
