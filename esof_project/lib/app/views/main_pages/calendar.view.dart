import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/validity.model.dart';
import '../../shared/filter.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime today = DateTime.now();
  DateTime? selectedDay;
  int currentPage = 0;
  List<Validity> allValidities = [];
  List<Validity> displayedValidities = [];
  bool isClicked = false;

  List<Validity> getValiditiesForCurrentPage() {
    int start = currentPage * 5;
    int end = start + 5;

    if (end > displayedValidities.length) {
      end = displayedValidities.length;
    }

    return displayedValidities.sublist(start, end);
  }

  void nextPage() {
    setState(() {
      int maxPage = (displayedValidities.length / 5).ceil() - 1;
      if (currentPage < maxPage) {
        currentPage++;
      }
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadValidities();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Map<DateTime, List<Validity>> validitiesMap = {};

  void loadValidities() async {
    ValidityController validityController = ValidityController();
    await validityController.fetchAllValidities().then((validities) {
      setState(() {
        allValidities = validities;
        validities.forEach((validity) {
          DateTime validityDate =
              DateTime(validity.year, validity.month, validity.day);
          if (validitiesMap[validityDate] == null) {
            validitiesMap[validityDate] = [];
          }
          validitiesMap[validityDate]!.add(validity);
        });
      });
    });

    ValidityFilter filter = ValidityFilter();
    allValidities = filter.sortValiditiesByDateAsc(allValidities);
    displayedValidities = allValidities;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Calendar",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 31,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
                child: TableCalendar(
              calendarStyle: const CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              focusedDay: today,
              firstDay: DateTime.utc(today.year - 2, 1, 1),
              lastDay: DateTime.utc(today.year + 30, 12, 31),
              locale: 'en_US',
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                headerPadding: EdgeInsets.all(0),
                headerMargin: EdgeInsets.all(0),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay.toLocal();
                  displayedValidities = [];
                  validitiesMap.forEach((key, value) {
                    if (isSameDay(this.selectedDay!, key)) {
                      displayedValidities = value;
                    }
                  });
                  if (displayedValidities.isEmpty) {
                    currentPage = 0;
                  }
                  isClicked = true;
                });
              },
              selectedDayPredicate: (day) {
                if (this.selectedDay == null) {
                  return false;
                } else {
                  return isSameDay(this.selectedDay!, day);
                }
              },
              eventLoader: (day) {
                for (DateTime key in validitiesMap.keys) {
                  if (isSameDay(key, day)) {
                    return validitiesMap[key] ?? [];
                  }
                }
                return [];
              },
              availableGestures: AvailableGestures.all,
            )),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: getValiditiesForCurrentPage().length,
                      itemBuilder: (context, index) {
                        Validity validity =
                            getValiditiesForCurrentPage()[index];
                        return ListTile(
                          title: Text(validity.name),
                          subtitle: Text('Quantity: ${validity.quantity}'),
                          trailing: Text(
                              '${validity.day}/${validity.month}/${validity.year}'),
                        );
                      },
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: previousPage,
                          ),
                          Text(
                            '${(displayedValidities.length / 5) == 0 ? currentPage : currentPage + 1} / ${(displayedValidities.length / 5).ceil()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: nextPage,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: isClicked,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                displayedValidities = allValidities;
                                currentPage = 0;
                                isClicked = false;
                              });
                            },
                            tooltip: 'Display all products',
                            icon: const Icon(Icons.filter_alt_off_rounded),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
