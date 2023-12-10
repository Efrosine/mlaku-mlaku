import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mlaku_mlaku/features/data/model/hotel_model.dart';
import 'package:mlaku_mlaku/features/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudService {
  CloudService(this._db, this._prefs);

  final FirebaseFirestore _db;
  final SharedPreferences _prefs;

  Future<DocumentSnapshot> getDocument(String collection, String id) async {
    return await _db.collection(collection).doc(_prefs.getString('uid')).get();
  }

  Future<void> entryDataUser(UserModel data) async {
    await _db.collection('users').doc(_prefs.getString('uid')).set(data.toJson());
  }

  Future<void> addReservation(HotelsModel data) async {
    await _db
        .collection('users')
        .doc(_prefs.getString('uid'))
        .collection('reservation')
        .doc(data.id.toString())
        .set(data.toJson());
  }

   Stream<QuerySnapshot> getAllReservation()  {
    print('get service');
    return  _db
        .collection('users')
        .doc(_prefs.getString('uid'))
        .collection('reservation')
        .snapshots();
  }
}
