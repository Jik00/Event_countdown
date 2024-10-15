import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/event_view_model.dart';
import '../widgets/event_app_bar.dart';
import '../widgets/event_list.dart';
import '../widgets/add_event_dialog.dart';
import '../widgets/event_button.dart';
import '../widgets/edit_event_dialog.dart'; 

class EventHomePage extends StatelessWidget {
  const EventHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EventAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<EventViewModel>(
          builder: (context, eventViewModel, child) {
            return Column(
              children: [
                Expanded(
                  child: EventList(
                    eventViewModel: eventViewModel,
                    onEdit: (context, index, name, date) {
                      showEditEventDialog(context, eventViewModel, index, name, date);
                    },
                    onDelete: (index) {
                      eventViewModel.deleteEvent(index);
                    },
                  ),
                ),
                EventButton(
                  onPressed: () {
                    showAddEventDialog(context, eventViewModel);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
