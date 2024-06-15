// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Add_Removeuser.dart';
import 'Userdetails.dart';
import 'Settings.dart';
import 'Usermanagement.dart';
import '../admin/Quotemanagement.dart';
import 'package:quoteza/admin/Quotemanagement.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // zoomDrawerController.toggle!();
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
                  MaterialPageRoute(builder: (context) => Userdetails()),
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
                  MaterialPageRoute(builder: (context) => Settings()),
                );
                // Add navigation logic here if needed
              },
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Logout'))
          ],
        ),
      ),
      body: Center(
        child: Text('Main Content Area'),
      ),
    );
  }
}
