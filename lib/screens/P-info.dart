import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

class Pinfo extends StatefulWidget {
  const Pinfo({Key? key}) : super(key: key);

  @override
  State<Pinfo> createState() => _PinfoState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _PinfoState extends State<Pinfo> {
  File? _profileImage;
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _fetchUserData(currentUser.uid);
    } else {
      _clearControllers();
    }
  }

  void _clearControllers() {
    setState(() {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      _imageUrl = null; // Clear profile image URL
    });
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      setState(() {
        _isLoading = true;
      });
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = userData['name'] ?? '';
          emailController.text = userData['email'] ?? '';
          phoneController.text = userData['phone'] ?? '';
          _imageUrl = userData['profileImage']; // Check if profile image URL exists
          _isLoading = false;
        });
      } else {
        print("User document does not exist for UID: $uid");
        _showAlert("User data not found 404");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert", style: GoogleFonts.nunito()),
          content: Text(
            message,
            style: GoogleFonts.nunito(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfileImage(String uid) async {
    if (_profileImage == null) return;

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
      final uploadTask = storageRef.putFile(_profileImage!);

      await uploadTask;
      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'profileImage': downloadUrl, // Save profile image URL to Firestore
      }, SetOptions(merge: true)); // Merge with existing data

      setState(() {
        _imageUrl = downloadUrl; // Update image URL in UI
      });
    } catch (e) {
      print("Error uploading profile image: $e");
      // Handle error here (show snackbar, log error, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to upload profile image'),
        ),
      );
    }
  }

  Future<void> _saveChanges() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final uid = currentUser.uid;

      await _uploadProfileImage(uid);

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Changes saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Error saving changes: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to save changes'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  ImageProvider _getProfileImage() {
    if (_profileImage != null) {
      return FileImage(_profileImage!);
    } else if (_imageUrl != null && _imageUrl!.isNotEmpty) {
      return NetworkImage(_imageUrl!);
    } else {
      return AssetImage('assets/images/profile.png'); // Default image asset
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
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
          "Account Information",
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loader
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _getProfileImage(),
                        child: _profileImage == null &&
                                (_imageUrl == null || _imageUrl!.isEmpty)
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey[700],
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
