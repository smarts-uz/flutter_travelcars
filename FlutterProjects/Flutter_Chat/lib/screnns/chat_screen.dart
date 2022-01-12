import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
                  value: 'logout',
              ),
              ],
            onChanged: (itemidentifier){
                if(itemidentifier == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
            },

              )
        ],

        title: Text('Enjoychat'),
      ),
      body: StreamBuilder(stream:FirebaseFirestore.
      instance.collection('chats/mVC35kz9i3JEk6UyqIxT/messages')
      .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if(streamSnapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        final document1 = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: document1.length,
            itemBuilder: (ctx, index) =>
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(document1[index]['text']),

                ),
          );
        }
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance
              .collection('chats/mVC35kz9i3JEk6UyqIxT/messages')
              .add({
            'text':'This is my 1st chat app !'
          });
        },
      ),
    );
  }
}
