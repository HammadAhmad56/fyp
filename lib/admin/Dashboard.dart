// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Removeuser.dart';
import 'Userdetails.dart';
import 'Usermanagement.dart';
import '../admin/Quotemanagement.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quoteza/admin/Settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() async {
    await _auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove("key"); // email key
    await prefs.remove("key2"); // password key
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<Map<String, int>> fetchUserData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    int adminCount = 0;
    int userCount = 0;

    snapshot.docs.forEach((doc) {
      if (doc['roles']['admin'] == true) {
        adminCount++;
      } else if (doc['roles']['user'] == true) {
        userCount++;
      }
    });

    return {'admin': adminCount, 'user': userCount};
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
          backgroundColor: Color.fromARGB(255, 247, 220, 211),
          automaticallyImplyLeading: true,
          leadingWidth: 30,
          title: Text(
            "Dashboard",
            style: GoogleFonts.nunito(),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          width: 250,
          surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
          backgroundColor: Color.fromARGB(255, 247, 220, 211),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 220, 211),
                ),
                child: Text('Quoteza',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    )),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.format_quote),
                title: Text('Quote Management'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Quotemanagement()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1),
                title: Text('Add OR Remove User'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRemoveuser()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('User Details'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetails()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.supervisor_account),
                title: Text('User Management'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Usermanagement()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settingsscreen()),
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Confirmation"),
                              content: Text("Do you want to Logout??"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    signOut();
                                  },
                                  child: Text(
                                    "Yes",
                                    style:
                                        GoogleFonts.nunito(color: Colors.red),
                                  ),
                                ),
                              ],
                            ));
                  },
                  child: Text('Logout'))
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'User Roles Chart',
                  style: GoogleFonts.nunito(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<Map<String, int>>(
                    future: fetchUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      }
                      Map<String, int> data = snapshot.data!;
                      int adminCount = data['admin']!;
                      int userCount = data['user']!;
                      return PieChart(
                        PieChartData(
                          centerSpaceRadius: 50,
                          sections: [
                            PieChartSectionData(
                              value: adminCount.toDouble(),
                              title: 'Admins: $adminCount',
                              color: Colors.blue,
                              radius: 60,
                              titleStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: userCount.toDouble(),
                              title: 'Users: $userCount',
                              color: Colors.green,
                              radius: 60,
                              titleStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  'Usage Trends Chart',
                  style: GoogleFonts.nunito(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                UsageTrendsChart(), // Add your line chart here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsageTrendsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    List<FlSpot> usageData = [
      FlSpot(0, 3),
      FlSpot(1, 4),
      FlSpot(2, 5),
      FlSpot(3, 3),
      FlSpot(4, 6),
      FlSpot(5, 5),
      FlSpot(6, 7),
    ];

    return AspectRatio(
      aspectRatio: 1.1,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          // titlesData: FlTitlesData(show: true),
          // borderData: FlBorderData(show: true),
          backgroundColor: Colors.amber,
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 8,
          lineBarsData: [
            LineChartBarData(
              shadow: Shadow(),
              spots: usageData,
              isCurved: true,
              color: Colors.white,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
