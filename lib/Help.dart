//ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Color(0xFFF7F2EF),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
        title: Text(
          "Help Center",
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7F2EF),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                _isButtonDisabled =
                    !(_formKey.currentState?.validate() ?? false);
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Our Customer support service is always available for you. Please contact us here if you have any query.',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w300, fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _issueController,
                  decoration: InputDecoration(
                    labelText: 'Issue',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your issue';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                      // disabledBackgroundColor: Color(0xFFF7F2EF),
                      textStyle: GoogleFonts.nunito(color: Colors.white)),
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          // Handle submit button press
                          // This function will be called when all fields are valid
                        },
                  child: Text('Submit'),
                ),
                SizedBox(
                    height:
                        32), // Add some space at the bottom for better scrolling
              ],
            ),
          ),
        ),
      ),
    );
  }
}
