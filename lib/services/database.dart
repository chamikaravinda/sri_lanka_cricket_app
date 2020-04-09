import 'package:app/models/fixtures.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference fixturesCollection = Firestore.instance.collection('upcomingFixtures');

  Future updateUserData(String name,String email,String birthDay) async {
    return await userCollection.document(uid).setData({
      'uid':uid,
      'name' :name,
      'email':email,
      'birthDay':birthDay
    });
  }

  //Fixtures list from snapshot
  List<Fixtures> _fixtureListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Fixtures(
        date: doc.data['date'] ?? '',
        flag: doc.data['flag'] ?? '',
        match: doc.data['match'] ?? '',
        time: doc.data['time'] ?? '',
        vs: doc.data['vs '] ?? '',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      birthDay: snapshot.data['birthDay']
    );
  }

  //get Fixtures stream
  Stream<List<Fixtures>> get fixtures{
    return fixturesCollection.snapshots()
    .map(_fixtureListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}