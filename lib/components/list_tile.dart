import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/delete_btn.dart';
import 'package:hydraware/components/like_btn.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final String area;
  final String postId;
  final List<String> likes;
  const MyListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.time,
      required this.area,
      required this.postId,
      required this.likes});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isVoted = false;

  @override
  void initState() {
    super.initState();
    isVoted = widget.likes.contains(currentUser!.email);
  }

  void toggleLike() {
    setState(() {
      isVoted = !isVoted;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Posts').doc(widget.postId);
    if (isVoted) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
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

  void delPost() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Post',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Cera Pro')),
              content: Text('Are you sure you want to delete this post?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Cera Pro')),
              actions: [
                TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(widget.postId)
                            .delete();
                        Navigator.pop(context);
                        // ignore: unused_catch_clause
                      } on FirebaseException catch (e) {
                        prompt('An error occured');
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Delete',
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: ListTile(
              title: Column(
                children: [
                  Text(
                    'Time: ${widget.time}',
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.title,
                            style: TextStyle(
                                fontFamily: 'Cera Pro',
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 10)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(widget.area,
                                style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 10))),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  // const SizedBox(height: 30),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20),
                  ),
                ],
              ),
              // trailing: widget.title == currentUser!.email
              //     ? DelBtn(
              //         onTap: delPost,
              //       )
              //     : const SizedBox.shrink(),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      LikeBtn(
                        isVoted: isVoted,
                        onTap: toggleLike,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        widget.likes.length.toString(),
                        style: TextStyle(
                            fontFamily: 'Cera Pro',
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      widget.title == currentUser!.email
                          ? DelBtn(
                              onTap: delPost,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
