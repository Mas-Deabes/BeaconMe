import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StepTracker());
}

class StepTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Step Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription? _streamSubscription;
  List<double> _accelerometerValues = <double>[];
  int _stepCount = 0;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _startListening();
  }

  void _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _userName = userDoc['First Name'];
      });
    }
  }

  void _startListening() {
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = List<double>.from([event.x, event.y, event.z], growable: true);
        if (_isStep(_accelerometerValues)) {
          _stepCount++;
          _updateStepCount(_stepCount);
        }
      });
    });
  }

  void _stopListening() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  bool _isStep(List<double> values) {
    double sum = values.map((e) => e * e).reduce((a, b) => a + b);
    double magnitude = sqrt(sum);
    return magnitude > 12;
  }

  List<double> _lowPassFilter(List<double> values) {
    const double alpha = 0.1;
    List<double> filteredValues = <double>[];
    for (int i = 0; i < values.length; i++) {
      filteredValues.add(alpha * values[i] + (1 - alpha) * _accelerometerValues[i]);
    }
    return filteredValues;
  }

  void _updateStepCount(int stepCount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final userId = user.uid;
    final documentReference = FirebaseFirestore.instance.collection('users').doc(userId);
    await documentReference.update({'Nsteps': stepCount});
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 60,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Text(
                        'FitnessMe',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '     Welcome Back $_userName',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(children: [
                        Column(children: [
                          Text('Steps Made : $_stepCount'),
                          SizedBox(height: 70),
                          Text('Calories Burnt : '),
                          SizedBox(height: 70),
                          Text('Distance Travelled :'),
                          SizedBox(height: 20),
                          Text('Metres : '),
                          SizedBox(height: 20),
                          Text('Miles :'),
                        ],),
                      ],),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
