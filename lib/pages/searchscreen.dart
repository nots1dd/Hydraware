import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hydraware/components/list_tile.dart';
import 'package:hydraware/components/toggle_button.dart';
import 'package:hydraware/components/animated_btn.dart';
import 'package:hydraware/pages/search_screens/posts/posts_db.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseDatabase db = FirebaseDatabase();

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Search Forum',style: TextStyle(fontFamily: 'Cera Pro',color: Colors.white,fontSize: 25),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          const SizedBox(width: 20),
          KeyboardDismissOnTap(
              dismissOnCapturedTaps: true,
              child: IconButton(
                onPressed: () async {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            )
        ],
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
                  // onChanged: (value) => runFilter(value),
                  style: TextStyle(fontFamily: 'Cera Pro', color: Theme.of(context).colorScheme.tertiary),
                  decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),),
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                hintText: 'Search',
                suffixIcon: AnimatedBtn(controller: controller,asset: 'assets/images/Hydraware_search_animation.json',height: 50,width: 50,))
                ),),
             ),
             const SizedBox(height: 10),
              Stack(
                children: [SizedBox(
                height: 600,
                child: StreamBuilder(
                  stream: db.getPostsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final posts = snapshot.data!.docs;
                
                  if (snapshot.data == null || posts.isEmpty) {
                    return const Center(child: Padding(padding: EdgeInsets.all(25),child: Text('No posts yet!',style: TextStyle(fontFamily: 'Cera Pro',color: Colors.white,fontSize: 20),),));
                  }
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        DateTime time = posts[index]['timestamp'].toDate();
                        String formattedTime = DateFormat('dd-MM  kk:mm').format(time);
                        return Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: MyListTile(title: post['mail'],subtitle: post['message'],time: formattedTime,area: post['area'],postId: post.id,likes: List<String>.from(post['Likes'] ?? []),)
                          ,);
                      },
                    );
                  },
                ),),
                Positioned(
                  key: UniqueKey(),
                  bottom: 1,
                  right: 20,
                  child: const ToggleButton(dir: '/post',icon: Icons.add,))
                ],
              ),
          ],
        ),
      ),
    );
  }
}