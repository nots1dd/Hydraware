import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/list_tile.dart';
import 'package:hydraware/pages/search_screens/posts/posts_db.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  final FirebaseDatabase db = FirebaseDatabase();

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> editField() async {
    String newVal = "";
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Edit your username',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Cera Pro')),
              content: TextField(
                autofocus: true,
                onChanged: (value) {
                  newVal = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter new username',
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Cera Pro'),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (newVal.trim().isNotEmpty &&
                          newVal.trim().length < 16) {
                        usersCollection
                            .doc(user.email)
                            .update({'username': newVal});
                        Navigator.pop(context);
                      } else {
                        prompt('Invalid username!');
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Theme.of(context).colorScheme.secondary),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Profile Settings',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontFamily: 'Cera Pro'),
              textAlign: TextAlign.left,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface,
              ),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Center(
                              child: Text('No data found! ${snapshot.error}',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontFamily: 'Cera Pro',
                                      fontSize: 20)));
                        }
                        final userData = snapshot.data;
                        return Column(
                          children: [
                            Container(
                              width: 300,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Name: ${userData!['username']}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontFamily: 'Cera Pro',
                                          fontSize: 20)),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: editField,
                                    icon: Icon(
                                      Icons.edit,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Email: ${userData['email']}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontFamily: 'Cera Pro',
                                    fontSize: 20)),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                  const SizedBox(height: 20),
                  const Center(
                      child: Text(
                    'Your Posts',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 600,
                    child: StreamBuilder(
                      stream: db.getPostsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final posts = snapshot.data!.docs;

                        if (snapshot.data == null || posts.isEmpty) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              'No posts yet!',
                              style: TextStyle(
                                  fontFamily: 'Cera Pro',
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ));
                        }
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            DateTime time = posts[index]['timestamp'].toDate();
                            String formattedTime =
                                DateFormat('dd-MM  kk:mm').format(time);
                            if (post['mail'] != user.email) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: MyListTile(
                                  title: post['mail'],
                                  subtitle: post['message'],
                                  time: formattedTime,
                                  area: post['area'],
                                  postId: post.id,
                                  likes:
                                      List<String>.from(post['Likes'] ?? [])),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
