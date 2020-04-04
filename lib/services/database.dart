import 'package:app/models/brew.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('users');

  Future updateUserData(String name,String email) async {
    return await brewCollection.document(uid).setData({
      'uid':uid,
      'name' :name,
      'email':email
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['stregth'] ?? 0,
        suger: doc.data['sugers'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugers: snapshot.data['sugers'],
      strength: snapshot.data['stregth']
    );
  }

  //get brew stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}