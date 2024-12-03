// 최소환승 화면
/* import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatefulWidget {
  @override
  _FlutterAppState createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  bool _isDarkMode = true;
  double _widthFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false, // Optional: Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            SizedBox(width: 10),
            DropdownButton<double>(
              value: _widthFactor,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _widthFactor = value;
                  });
                }
              },
              items: [
                DropdownMenuItem(
                  value: 0.5,
                  child: Text('Size: 50%'),
                ),
                DropdownMenuItem(
                  value: 0.75,
                  child: Text('Size: 75%'),
                ),
                DropdownMenuItem(
                  value: 1.0,
                  child: Text('Size: 100%'),
                ),
              ],
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * _widthFactor,
            child: TransferScreen(),
          ),
        ),
      ),
    );
  }
}

class TransferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppHeader(),
          SizedBox(height: 20),
          TransferOptions(),
          SizedBox(height: 20),
          DurationDisplay(),
          SizedBox(height: 20),
          TransferDetails(),
          SizedBox(height: 20),
          Footer(),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adjust background color based on theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: isDark ? Colors.grey[900] : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeDisplay(),
          StatusIndicator(),
        ],
      ),
    );
  }
}

class TimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '9:41',
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
        fontSize: 17,
        // Removed fontFamily
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder content for StatusIndicator
    return Row(
      children: [
        Icon(Icons.signal_wifi_4_bar, size: 16),
        SizedBox(width: 5),
        Icon(Icons.battery_full, size: 16),
        // Add more status icons as needed
      ],
    );
  }
}

class TransferOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TransferButton(
          label: '최소 거리 순',
          isSelected: false,
        ),
        TransferButton(
          label: '최소 환승 순',
          isSelected: true,
        ),
      ],
    );
  }
}

class TransferButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TransferButton({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: ShapeDecoration(
        color: isSelected ? Color(0xFF397394) : Colors.white,
        shape: RoundedRectangleBorder(
          side: isSelected
              ? BorderSide.none
              : BorderSide(width: 2, color: Color(0xFF397394)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF397394),
          fontSize: 11,
          // Removed fontFamily
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class DurationDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '소요 시간',
          style: TextStyle(
            color: Color(0xFF979797),
            fontSize: 16,
            // Removed fontFamily
          ),
        ),
        SizedBox(height: 5),
        Text(
          '11 분',
          style: TextStyle(
            color: Color(0xFF4B4B4B),
            fontSize: 45,
            // Removed fontFamily
          ),
        ),
      ],
    );
  }
}

class TransferDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransferStep(
          lineColor: Color(0xFF856869),
          lineHeight: 145,
          stationNumber: '1',
          stationName: '101',
          direction: '190 방면 | 빠른 하차 5-2, 10-4',
        ),
        TransferStep(
          lineColor: Color(0xFF128226),
          lineHeight: 145,
          stationNumber: '2',
          stationName: '103',
          direction: '190 방면 | 빠른 하차 5-2, 10-4',
        ),
        TransferStep(
          lineColor: Color(0xFF128226),
          lineHeight: 44,
          stationNumber: '2',
          stationName: '201',
          direction: '내리는 문 오른쪽 | 하차 정보',
        ),
      ],
    );
  }
}

class TransferStep extends StatelessWidget {
  final Color lineColor;
  final double lineHeight;
  final String stationNumber;
  final String stationName;
  final String direction;

  const TransferStep({
    required this.lineColor,
    required this.lineHeight,
    required this.stationNumber,
    required this.stationName,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Line indicator
        Container(
          width: 7,
          height: lineHeight,
          color: lineColor,
        ),
        SizedBox(width: 10),
        // Station info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stationName,
                style: TextStyle(
                  color: Color(0xFF4B4B4B),
                  fontSize: 32,
                  // Removed fontFamily
                ),
              ),
              Text(
                direction,
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 12,
                  // Removed fontFamily
                ),
              ),
              SizedBox(height: 5),
              Text(
                '소요 시간 정보',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 15,
                  // Removed fontFamily
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '스마트 환승철',
      style: TextStyle(
        color: Color(0xFF387394),
        fontSize: 14,
        // Removed fontFamily
        letterSpacing: 5,
      ),
    );
  }
}
 */