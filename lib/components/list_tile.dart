import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/like_btn.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;
  final String area;
  final String postId;
  final List<String> likes;
  const MyListTile({super.key,required this.title,required this.subtitle,required this.time,required this.area,required this.postId,required this.likes});

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

    DocumentReference postRef = FirebaseFirestore.instance.collection('Posts').doc(widget.postId);
    if (isVoted) {
      postRef.update({'Likes': FieldValue.arrayUnion([currentUser!.email])});
    } else {
      postRef.update({'Likes': FieldValue.arrayRemove([currentUser!.email])});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: ListTile(
              title: Row(
                children: [
                  Text(widget.title,style: TextStyle(fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.tertiary,fontSize: 10)),
                  const SizedBox(width: 45),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(widget.area,style: TextStyle(fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.primary,fontSize: 10))),
                ],
              ),
              subtitle: Text(widget.subtitle,style: TextStyle(fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.tertiary,fontSize: 20),),
            )
            ,),
            Row(
              children: [
                const SizedBox(width: 150),
                LikeBtn(isVoted: isVoted, onTap: toggleLike,),
                const SizedBox(width: 10),
                Text(widget.likes.length.toString(),style: TextStyle(fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.tertiary,fontSize: 10),),
                const SizedBox(width: 60),
                Text(widget.time,style: TextStyle(fontFamily: 'Cera Pro',color: Theme.of(context).colorScheme.tertiary,fontSize: 10),),
              ],
            )
        ],
      ),
    );
  }
}