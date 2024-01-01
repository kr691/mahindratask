import 'package:flutter/material.dart';
import 'package:mahindra_finance_task/constants.dart';
import 'package:mahindra_finance_task/models/user_details.dart';
import 'package:mahindra_finance_task/widgets/day_selected_widget.dart';
import 'package:mahindra_finance_task/widgets/week_selected_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  late CalendarFormat _calendarFormat; // Track the calendar format
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay; // Track selected day when in 'Day' mode
  late TabController _tabController;

  List<UserDetails> allData = [];
  @override
  void initState() {
    super.initState();
    allData = [...hrd, ...tech, ...followUp];
    _calendarFormat =
        CalendarFormat.week; // Set the initial format to week view
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  bool isDaySelected = true; // To track the selected option

  @override
  Widget build(BuildContext context) {
    List<String> weekDates = [];
    if (!isDaySelected) {
      // Generate week's dates in the format 'dd MMM' (e.g., '24 Aug')
      for (int i = 0; i < 7; i++) {
        DateTime currentDay = _focusedDay.add(Duration(days: i));
        String formattedDate = DateFormat('dd MMM').format(currentDay);
        weekDates.add(formattedDate);
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          isDaySelected ? 'In App Calendar' : 'My Calendar',
          style: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          color: Colors.black,
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDaySelected = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: isDaySelected ? Colors.blue : Colors.white,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Day",
                          style: TextStyle(
                            color: isDaySelected ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDaySelected = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: isDaySelected ? Colors.white : Colors.blue,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Week",
                          style: TextStyle(
                            color: isDaySelected ? Colors.blue : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) {
              if (isDaySelected) {
                // When in 'Day' mode, allow selection of individual days
                return isDaySelected &&
                    _selectedDay != null &&
                    isSameDay(day, _selectedDay!);
              } else {
                // When in 'Week' mode, select entire week by default
                return isSameWeek(day, _focusedDay);
              }
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (isDaySelected) {
                  _selectedDay = selectedDay;
                } else {
                  _focusedDay = focusedDay;
                }
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Make today's date blue as well
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Change the background color here
              ),
            ),
          ),
          const SizedBox(height: 20),
          isDaySelected
              ? DaySelected(
                  tabController: _tabController,
                  allData: allData,
                  hrd: hrd,
                  tech: tech,
                  followUp: followUp)
              : WeekSelected(
                  tabController: _tabController,
                  allData: allData,
                  hrd: hrd,
                  tech: tech,
                  followUp: followUp,
                  weekDates: weekDates),
        ],
      ),
    );
  }

  bool isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  bool isSameWeek(DateTime dayA, DateTime dayB) {
    final diff = dayA.difference(dayB).inDays;
    return diff >= 0 && diff < 7;
  }
}
