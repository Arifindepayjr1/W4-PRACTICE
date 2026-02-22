import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

class StatisticsScreen extends StatelessWidget {
  // final int redTapCount;
  // final int blueTapCount;

  const StatisticsScreen({
    super.key,
    // required this.redTapCount,
    // required this.blueTapCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${_colorService.redTapCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${_colorService.blueTapCount}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorService extends ChangeNotifier {
  int redTapCount = 0;
  int blueTapCount = 0;

  ColorService({this.blueTapCount = 0, this.redTapCount = 0});

  void incrementRedTapCount() {
    redTapCount++;

    notifyListeners();
  }

  void incrementBlueTapCount() {
    blueTapCount++;

    notifyListeners();
  }
}

enum CardType { red, blue }

ColorService _colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // int redTapCount = 0;
  // int blueTapCount = 0;

  /*  void _incrementRedTapCount() {
    setState(() {
      redTapCount++;
    });
  }
  */

  /* void _incrementBlueTapCount() {
    setState(() {
      blueTapCount++;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  // final int redTapCount;
  // final int blueTapCount;
  // final VoidCallback onRedTap;
  // final VoidCallback onBlueTap;

  const ColorTapsScreen({
    super.key,
    // required this.redTapCount,
    // required this.blueTapCount,
    // required this.onRedTap,
    // required this.onBlueTap,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(
            type: CardType.red,
            // tapCount: _colorService.redTapCount,
            // onTap: _colorService.incrementRedTapCount,
          ),
          ColorTap(
            type: CardType.blue,
            // tapCount: _colorService.blueTapCount,
            // onTap: _colorService.incrementBlueTapCount,
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  // final int tapCount;
  // final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    // required this.tapCount,
    // required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;
  CardType get colorType => type == CardType.red ? CardType.red : CardType.blue;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _colorService,
      builder: (_, child) {
        return GestureDetector(
          onTap: () {
            colorType == CardType.red
                ? _colorService.incrementRedTapCount()
                : _colorService.incrementBlueTapCount();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: ${colorType == CardType.red ? _colorService.redTapCount : _colorService.blueTapCount}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
