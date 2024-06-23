import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/admin/Add_Removeuser.dart';

class Usermanagement extends StatefulWidget {
  const Usermanagement({super.key});

  @override
  State<Usermanagement> createState() => _UsermanagementState();
}

class _UsermanagementState extends State<Usermanagement> {
  int totalUsers = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getTotalUsers();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management', style: GoogleFonts.nunito()),
      ),
      body: Column(
        children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    'Total Users: $totalUsers',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddRemoveuser()),
                );
              },
              child: Text("ADD/REMOVE USER"))
        ],
      ),
    );
  }
}
