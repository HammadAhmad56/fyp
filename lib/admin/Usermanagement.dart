import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class Usermanagement extends StatefulWidget {
  const Usermanagement({super.key});

  @override
  State<Usermanagement> createState() => _UsermanagementState();
}

class _UsermanagementState extends State<Usermanagement> {
  int totalUsers = 0;
  bool isLoading = true;
  List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState();
    _getTotalUsers();
    fetchDataFromFirestore();
  }

  Future<void> _getTotalUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        totalUsers = querySnapshot.docs.length;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching total users: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      setState(() {
        spots = docs
            .map((doc) => FlSpot(
                  docs.indexOf(doc).toDouble(),
                  doc['userCount'].toDouble(),
                ))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management', style: GoogleFonts.nunito()),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                'Total Users: $totalUsers',
                style: TextStyle(fontSize: 24),
              ),
      ),
    );
  }
}
