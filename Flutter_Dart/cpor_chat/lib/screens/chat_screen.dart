import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cpor_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {

  static String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;
      if (user != null){
        loggedInUser = user;
        print(loggedInUser != null ? loggedInUser!.email : "Kein User gefunden");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Map<String, dynamic> convertQuerySnapshotToMap(QuerySnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> result = {};

    snapshot.docs.forEach((doc) {
      // Extract the document ID as the key
      String docId = doc.id;

      // Extract the document data as the value
      Map<String, dynamic> docData = doc.data();

      // Add the document ID and data to the result map
      result[docId] = docData;
    });

    return result;
  }

/*  Future<void> getMessages() async {
    final snapshot =  await _firestore.collection("messages").get();
    for(var message in snapshot.docs){
      print(message.data());
    }
  }*/
/*  Future<void> getMessages() async {
    final snapshot =  await _firestore.collection("messages").get();
    for(var message in snapshot.docs){
      print(message.data());
    }
    Map<String, Map<String, dynamic>> messages = {};

    snapshot.docs.forEach((doc) {
      // Extract the document ID as the key
      String docId = doc.id;
      // Extract the document data as the value
      Map<String, dynamic> docData = doc.data();
      // Add the document ID and data to the result map
      messages[docId] = docData;
    });

    for (var message in messages.values){
      print("message: ${message}");
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed:
                      () async {
                        messageTextController.clear();
                        print("text: $messageText, sender:  ${loggedInUser!.email},");
                        //messageText + loggedInUser.email
                        try {

                          await _firestore.collection("messages").add({
                            "date": DateTime.now().toString().substring(0,23),
                            "text": messageText,
                            "sender": loggedInUser.email,
                          });
                        } on FirebaseAuthException catch (e) {
                          print("CustomFirebaseAuthError____"+e.code);
                        }
                      },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection("messages").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final messages = snapshot.data!.docs;
            List<MessageBubble> messageBubbles = [];
            for(var message in messages){
              final messageText = message.data()["text"];
              final messageSender = message.data()["sender"];
              final messageDate = DateTime.parse(message.data()["date"]);
              print("_____message.data()[\"date\"]_____ ${message.data()["date"]}");
              print("_____DateTime.parse(message.data()[\"date\"])_____ $messageDate");
              //var dateTime = message.data()["date"];


              final currentUser = loggedInUser.email;

              final messageBubble = MessageBubble(
                  sender: messageSender,
                  text: messageText,
                  date: messageDate.toString(),
                  isMe: currentUser == messageSender,

              );
              messageBubbles.add(messageBubble);
            }
            messageBubbles.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
            //print("____$messageWidgets");
            return Expanded(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageBubbles,
              ),
            );
          }else{
            return Container();
          }
        },
    );
  }
}

class MessageBubble extends StatelessWidget {

  final String text;
  final String sender;
  final String date;
  final bool isMe;

  const MessageBubble({required this.sender, required this.text, required this.isMe, required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if(!isMe) Text(
            sender,
            style: TextStyle(
              color: Colors.black45
            ),
          ),
          Text(
            date.toString().substring(0, 19),
            style: const TextStyle(
                color: Colors.black38,
                fontSize: 10
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 30.0 : 0),
              topRight: Radius.circular(isMe ? 0 : 30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                  "$text",
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
