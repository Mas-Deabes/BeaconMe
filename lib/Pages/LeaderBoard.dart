import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    // Instead of calling getLeaderboardData() in initState,
    // we will set up a stream to listen for changes to the 'users' collection
    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        users = snapshot.docs.map((documentSnapshot) {
          return documentSnapshot.data();
        }).toList();
        mergeSort(users, 0, users.length - 1);
        setState(() {});
      }
    });
  }

  void mergeSort(List<Map<String, dynamic>> array, int start, int end) {
    if (start < end) {
      int mid = (start + end) ~/ 2;
      mergeSort(array, start, mid);
      mergeSort(array, mid + 1, end);
      merge(array, start, mid, end);
    }
  }

  void merge(
      List<Map<String, dynamic>> array, int start, int mid, int end) {
    int leftSize = mid - start + 1;
    int rightSize = end - mid;
    List<Map<String, dynamic>> leftArray =
    List<Map<String, dynamic>>.filled(leftSize, {}, growable: false);
    List<Map<String, dynamic>> rightArray =
    List<Map<String, dynamic>>.filled(rightSize, {}, growable: false);
    for (int i = 0; i < leftSize; i++) {
      leftArray[i] = array[start + i];
    }
    for (int i = 0; i < rightSize; i++) {
      rightArray[i] = array[mid + i + 1];
    }
    int leftIndex = 0;
    int rightIndex = 0;
    int mergedIndex = start;
    while (leftIndex < leftSize && rightIndex < rightSize) {
      if (leftArray[leftIndex]['Nsteps'] >= rightArray[rightIndex]['Nsteps']) {
        array[mergedIndex] = leftArray[leftIndex];
        leftIndex++;
      } else {
        array[mergedIndex] = rightArray[rightIndex];
        rightIndex++;
      }
      mergedIndex++;
    }
    while (leftIndex < leftSize) {
      array[mergedIndex] = leftArray[leftIndex];
      leftIndex++;
      mergedIndex++;
    }
    while (rightIndex < rightSize) {
      array[mergedIndex] = rightArray[rightIndex];
      rightIndex++;
      mergedIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(users[index]['First Name']),
            trailing: Text('${users[index]['Nsteps']} steps'),
          );
        },
      ),
    );
  }
}
