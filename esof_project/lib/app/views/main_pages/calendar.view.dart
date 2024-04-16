import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/event.model.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  final TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _slectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _slectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _slectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    const name = 'Calendar';

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Event Name"),
                    content: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventController,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (_selectedDay != null) {
                            events[_selectedDay!] = [
                              Event(_eventController.text)
                            ];
                            Navigator.of(context).pop();
                            _slectedEvents.value =
                                _getEventsForDay(_selectedDay!);
                          } else {
                            print('Error: _selectedDay is null');
                          }
                        },
                        child: const Text("Introducer"),
                      )
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        */
      body: Expanded(
        child: Column(
          children: [
            Expanded(child: calendar()),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget calendar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TableCalendar(
            rowHeight: 43,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(_focusedDay.year - 5, 1, 1),
            lastDay: DateTime.utc(_focusedDay.year + 10, 31, 12),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
          ),
        ),
        Text("Dia selection = ${_focusedDay.toString().split(" ")[0]}"),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
              valueListenable: _slectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => print(""),
                          title: Text(value[index].title),
                        ),
                      );
                    });
              }),
        ),
        Transform.rotate(
            angle: -0.785,
            child: const Text(
                'IN PROGRESS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 100 )
            )
        ),
        const SizedBox(height:500),
      ],
    );
  }
}
