import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<List<Map<String, dynamic>>> _usersFuture;
  String _searchQuery = "";
  String _sortBy = 'Created Date (Descending)';

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  Future<void> addUserDetailsToFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'email': user.email,
      'name': user.displayName ?? 'Unknown',
      'createdDate': user.metadata.creationTime,
    });
  }

  Future<void> registerUser(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await addUserDetailsToFirestore(user);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['uid'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  String formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    DateTime date = timestamp.toDate();
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _usersFuture = fetchUsers();
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.arrow_upward),
                title: new Text('Created Date (Ascending)'),
                onTap: () {
                  setState(() {
                    _sortBy = 'Created Date (Ascending)';
                    Navigator.of(context).pop();
                  });
                },
              ),
              new ListTile(
                leading: new Icon(Icons.arrow_downward),
                title: new Text('Created Date (Descending)'),
                onTap: () {
                  setState(() {
                    _sortBy = 'Created Date (Descending)';
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterUsers(List<Map<String, dynamic>> users) {
    if (_searchQuery.isEmpty) {
      return users;
    } else {
      return users.where((user) {
        return user['name']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user['email']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user['uid']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  List<Map<String, dynamic>> _sortUsersByDate(
      List<Map<String, dynamic>> users) {
    users.sort((a, b) {
      Timestamp? aTimestamp = a['createdDate'];
      Timestamp? bTimestamp = b['createdDate'];
      if (aTimestamp == null && bTimestamp == null) {
        return 0;
      } else if (aTimestamp == null) {
        return 1;
      } else if (bTimestamp == null) {
        return -1;
      } else {
        if (_sortBy == 'Created Date (Descending)') {
          return bTimestamp.compareTo(aTimestamp); // Descending order
        } else {
          return aTimestamp.compareTo(bTimestamp); // Ascending order
        }
      }
    });
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showSortOptions(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshUsers,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _usersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No users found.'));
                    }
                    final users = _filterUsers(snapshot.data!);
                    final sortedUsers = _sortUsersByDate(users);
                    return ListView.builder(
                      itemCount: sortedUsers.length,
                      itemBuilder: (context, index) {
                        final user = sortedUsers[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            leading: CircleAvatar(
                              child: Text(user['name'] != null
                                  ? user['name']![0].toUpperCase()
                                  : 'U'),
                            ),
                            title: Text(
                              user['name'] ?? 'No Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Email: ${user['email'] ?? 'No Email'}'),
                                SelectableText(
                                  'UID: ${user['uid'] ?? 'No UID'}',
                                ),
                                SelectableText(
                                    'Created: ${user['createdDate'] != null ? formatDate(user['createdDate']) : 'Unknown'}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
