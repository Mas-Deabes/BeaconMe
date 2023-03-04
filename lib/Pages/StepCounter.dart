import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepCounter(),
    );
  }
}

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  int _steps = 0;
  int _previousDirection = 0;
  int _direction = 0;
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      _x = event.x;
      _y = event.y;
      _z = event.z;

      // Calculate the direction of movement using the accelerometer data.
      double magnitude = _x * _x + _y * _y + _z * _z;
      if (magnitude > 10) {
        if (_z < -8) {
          _direction = 1; // Moving forward
        } else if (_z > 8) {
          _direction = -1; // Moving backward
        } else {
          _direction = 0; // Not moving
        }
      }

      // Filter out false positives by checking for changes in direction.
      if (_direction != _previousDirection && _direction != 0) {
        setState(() {
          _steps++;
        });
      }
      _previousDirection = _direction;
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Use the gyroscope to adjust the accelerometer data based on changes in orientation.
      double alpha = 0.8;
      _x = alpha * _x + (1 - alpha) * event.x;
      _y = alpha * _y + (1 - alpha) * event.y;
      _z = alpha * _z + (1 - alpha) * event.z;

      // Calculate the direction of movement using the accelerometer data.
      double magnitude = _x * _x + _y * _y + _z * _z;
      if (magnitude > 10) {
        if (_z < -8) {
          _direction = 1; // Moving forward
        } else if (_z > 8) {
          _direction = -1; // Moving backward
        } else {
          _direction = 0; // Not moving
        }
      }

      // Filter out false positives by checking for changes in direction.
      if (_direction != _previousDirection && _direction != 0) {
        setState(() {
          _steps++;
        });
      }
      _previousDirection = _direction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Steps: $_steps',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
