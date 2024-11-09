import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Map<String, String>>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchStudentCourses();
  }

  Future<void> _fetchStudentCourses() async {
    final response = await http.get(Uri.parse(
        'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        _events = _mapCoursesToCalendar(
            data, "HAN MIN THAW -"); // Pass student_id = 10
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Map<DateTime, List<Map<String, String>>> _mapCoursesToCalendar(
      List<dynamic> data, String studentName) {
    final Map<DateTime, List<Map<String, String>>> events = {};

    final studentData = data.firstWhere(
        (student) => student['name'] == studentName,
        orElse: () => null);

    if (studentData != null) {
      for (var course in studentData['courses']) {
        for (var schedule in course['schedules']) {
          DateTime courseDate =
              _getNextOccurrence(schedule['day'], DateTime.now());
          String courseName = "${course['course_name']} \n (${course['type']})";
          String courseInfo =
              "${course['section_no']} \nClassroom: ${schedule['classroom']}\n${schedule['start_time']} - ${schedule['end_time']} \n\n ${course['instructor']}";
          String courseColor = "${course['course_color']}";

          for (int i = 0; i < 5; i++) {
            DateTime occurrence = courseDate.add(Duration(days: 7 * i));
            DateTime normalizedOccurrence =
                DateTime(occurrence.year, occurrence.month, occurrence.day);
            events[normalizedOccurrence] = events[normalizedOccurrence] ?? [];
            events[normalizedOccurrence]!.add({
              'name': courseName,
              'info': courseInfo,
              'color': courseColor,
            });
          }
        }
      }
    } else {
      print("Student with ID $studentName not found");
    }

    return events;
  }

  DateTime _getNextOccurrence(String day, DateTime reference) {
    final dayOfWeekMap = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    if (!dayOfWeekMap.containsKey(day)) {
      print("Day '$day' not found in dayOfWeekMap");
      return reference; // Return the reference date if the day is not found
    }

    int dayOfWeek = dayOfWeekMap[day]!;
    int daysToAdd = (dayOfWeek - reference.weekday) % 7;
    return reference
        .add(Duration(days: daysToAdd >= 0 ? daysToAdd : daysToAdd + 7));
  }

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    List<Map<String, String>> eventsForDay = _events[normalizedDay] ?? [];
    return eventsForDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Schedule",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF1E7549),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            eventLoader: (day) => _getEventsForDay(day),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0x8070CC9E),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFF70CC9E),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
              itemBuilder: (context, index) {
                final event =
                    _getEventsForDay(_selectedDay ?? _focusedDay)[index];
                final colorCode = event['color']!;

                Color cardColor;
                try {
                  cardColor = Color(int.parse("0xFF$colorCode"));
                } catch (e) {
                  cardColor = Colors.red; // Fallback color
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    color: cardColor,
                    child: ListTile(
                      title: Text(
                        event['name']!,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        event['info']!,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
