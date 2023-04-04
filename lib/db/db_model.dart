// class DbModel {
//   String? userId;
//   String? userName;
//   String? userDp;
//   List<FriendMessage>? friends;
//   // List<Friend>? friends;
// }

class Message {
  Message(
      {required this.isRecieved,
      required this.friendId,
      required this.content,
      required this.time});
  String friendId;
  String content;
  bool isRecieved;
  int time;
}

class FriendDetails {
  FriendDetails(
      {required this.friendId, required this.friendName, this.friendDp});
  String friendId;
  String friendName;
  String? friendDp;
}
