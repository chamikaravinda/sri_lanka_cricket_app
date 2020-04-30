import 'package:app/models/fixture.dart';
import 'package:app/models/ticket_booking.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference fixturesCollection = Firestore.instance.collection('upcomingFixtures');
  final CollectionReference ticketBookingCollection = Firestore.instance.collection('ticketBooking');

  /* USER MANAGEMENT */
  //add and update user
  Future updateUserData(String name,String email,String birthDay) async {
    return await userCollection.document(uid).setData({
      'uid':uid,
      'name' :name,
      'email':email,
      'birthDay':birthDay
    });
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
  //get user doc stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  /* FIXTURES MANAGEMENT */
  //Fixtures list from snapshot
  List<Fixture> _fixtureListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Fixture(
        date: doc.data['date'] ?? '',
        flag: doc.data['flag'] ?? '',
        match: doc.data['match'] ?? '',
        time: doc.data['time'] ?? '',
        vs: doc.data['vs '] ?? '',
      );
    }).toList();
  }

  //Latest Fixtures list from snapshot
  List<Fixture> _latestFixtureListFromSnapshot(QuerySnapshot snapshot){
    var len = snapshot.documents.asMap().length;
    if(len<5){
      return snapshot.documents.map((doc){
        return Fixture(
          date: doc.data['date'] ?? '',
          flag: doc.data['flag'] ?? '',
          match: doc.data['match'] ?? '',
          time: doc.data['time'] ?? '',
          vs: doc.data['vs '] ?? '',
        );
      }).toList();
    }
    else{
      return snapshot.documents.map((doc){
        return Fixture(
          date: doc.data['date'] ?? '',
          flag: doc.data['flag'] ?? '',
          match: doc.data['match'] ?? '',
          time: doc.data['time'] ?? '',
          vs: doc.data['vs '] ?? '',
        );
      }).toList().getRange(0, 4);
    }
  }


  //get Fixtures stream
  Stream<List<Fixture>> get fixtures{
    return fixturesCollection.snapshots()
    .map(_fixtureListFromSnapshot);
  }

  //get the Latest Fixtures stream
  Stream<List<Fixture>> get latestFixtures{
    return fixturesCollection.snapshots()
        .map(_latestFixtureListFromSnapshot);
  }

  /* Ticket Booking MANAGEMENT */
  //add and update user
  Future addTicketBooking(String game,String noOfTickets,String cardType,String cardNumber,String csvNumber) async {
    return await ticketBookingCollection.add({
      'uid':uid,
      'game':game,
      'noOfTickets' :noOfTickets,
      'cardType':cardType,
      'cardNumber':cardNumber,
      'csvNumber':csvNumber,
    });
  }

  //get ticket booking snapshot
  Stream<List<TicketBooking>> get userTicketBookings{
    return ticketBookingCollection.where('uid',isEqualTo:uid).snapshots()
        .map(_userTicketBookingsFromSnapshot);
  }

  //get ticket booking from snapshot
  List<TicketBooking> _userTicketBookingsFromSnapshot(QuerySnapshot snapshot){
    print(snapshot);
    return snapshot.documents.map((doc){
      return TicketBooking(
        uid:doc.data['uid'] ?? '',
        game:doc.data['game'] ?? '',
        noOfTickets:doc.data['noOfTickets'] ?? '',
        cardType:doc.data['cardType'] ?? '',
        cardNumber:doc.data['cardNumber'] ?? '',
        csvNumber:doc.data['csvNumber'] ?? '',
      );
    }).toList();
  }


}