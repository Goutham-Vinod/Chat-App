import 'package:chat_app/db/db_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctions {
  writeData() async {
    String myDocumentId = 'user id';
    String collectionName = 'messages';

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);

// Define your JSON data
    Map<String, dynamic> jsonData = {
      // message structure below
      'friend Id1': [
        {'content': 'hai', 'time': 500, 'isRecieved': true},
        {'content': 'hlo', 'time': 600, 'isRecieved': false},
        {'content': 'yup', 'time': 700, 'isRecieved': true},
      ],
      'friend Id2': [
        {'content': 'kooi', 'time': 800, 'isRecieved': false},
        {'content': 'hey', 'time': 900, 'isRecieved': true},
        {'content': 'hlo', 'time': 10200, 'isRecieved': false},
      ]
    };
    // Update the entire document with the JSON data
    DocumentReference documentReference = collectionReference.doc(myDocumentId);
    var a = await documentReference.get();
    if (a.exists) {
      documentReference.update(jsonData);
    } else {
      documentReference.set(jsonData);
    }
  }

  readData() async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('messages');

// Get an entire document as JSON data
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc('user id').get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> documentData =
          documentSnapshot.data() as Map<String, dynamic>;
      // print(data);
      // messages.clear();
      // documentData.forEach((key, msgs) {
      //   msgs.forEach((msg) {
      //     Message data = Message(
      //       msg['isRecieved'],
      //       key,
      //       msg['content'],
      //       msg['time'],
      //     );
      //     messages.add(data);
      //     print(messages.length);
      //   });
      // });
    }
  }
}
