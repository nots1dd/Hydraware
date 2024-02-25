import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hydraware/components/toggle_button.dart';
import 'package:hydraware/components/animated_btn.dart';
import 'package:hydraware/pages/search_screens/posts/posts_db.dart';
import 'package:intl/intl.dart';

import '../components/list_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  void toggleSearch() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('Search Options',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 26,
                              fontFamily: 'Cera Pro')),
                      Divider(
                        thickness: 0.75,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(height: 5),
                      Text("Search by content",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: "Cera Pro")),
                      const SizedBox(height: 10),
                      Text("Search by person",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: "Cera Pro")),
                      const SizedBox(height: 10),
                      Text("Search by most likes",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: "Cera Pro"))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  final FirebaseDatabase db = FirebaseDatabase();

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ToggleButton(
        dir: '/post',
        icon: Icons.add,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Search Forum',
          style: TextStyle(
              fontFamily: 'Cera Pro',
              color: Theme.of(context).colorScheme.background,
              fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: KeyboardDismissOnTap(
          dismissOnCapturedTaps: true,
          child: IconButton(
            onPressed: () async {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: searchController,
                  onChanged: (value) => setState(() {}),
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withAlpha(100)),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withAlpha(100)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 2.5,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(200)),
                    ),
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                    hintText: 'Search',
                    prefixIcon: AnimatedBtn(
                      controller: controller,
                      asset: 'assets/images/Hydraware_search_animation.json',
                      height: 20,
                      width: 20,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          toggleSearch();
                        },
                        icon: Icon(
                          Icons.filter_alt_outlined,
                          color: Theme.of(context).colorScheme.onBackground,
                          size: 20,
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                SizedBox(
                  height: 750,
                  child: StreamBuilder(
                    stream: db.getPostsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final posts = snapshot.data!.docs;

                      if (snapshot.data == null || posts.isEmpty) {
                        return Center(
                            child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'No posts yet!',
                            style: TextStyle(
                                fontFamily: 'Cera Pro',
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 20),
                          ),
                        ));
                      }
                      List filteredPosts = posts.where((post) {
                        return post['mail'].contains(searchController.text) ||
                            post['message'].contains(searchController.text) ||
                            post['area'].contains(searchController.text);
                      }).toList();
                      return ListView.builder(
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];
                          DateTime time = posts[index]['timestamp'].toDate();
                          String formattedTime =
                              DateFormat('dd/MM/yy  kk:mm').format(time);
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: MyListTile(
                              title: post['mail'],
                              subtitle: post['message'],
                              time: formattedTime,
                              area: post['area'],
                              postId: post.id,
                              likes: List<String>.from(post['Likes'] ?? []),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
