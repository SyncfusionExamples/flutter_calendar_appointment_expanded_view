import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const MyHomePage());

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpandedView(),
    );
  }
}

class ExpandedView extends StatefulWidget {
  const ExpandedView({super.key});

  @override
  State<StatefulWidget> createState() => ExpandedViewState();
}

class ExpandedViewState extends State<ExpandedView> {
  final List<Color> _colorCollection = <Color>[];
  final ScrollController _scrollController = ScrollController();
  DateTime? _currentDate;

  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: SizedBox(
            width: 1000,
            child: SfCalendar(
              view: CalendarView.day,
              dataSource: DataSource(
                List<Appointment>.generate(
                    20,
                    (int index) => Appointment(
                        subject: 'Meeting $index',
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(const Duration(hours: 1)),
                        color: _colorCollection[index % 9],
                        isAllDay: false)),
              ),
              onViewChanged: (viewChangedDetails) {
                if (_currentDate != null &&
                    _currentDate != viewChangedDetails.visibleDates[0]) {
                  _scrollController.jumpTo(0);
                } else {
                  _currentDate = viewChangedDetails.visibleDates[0];
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
