import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:viaductharbour/models/location.dart';

class MediaRepository {

  Future<String> getLocationPhoto(Location location) async {
    var photoDoc = await Firestore.instance.document(location.photoPath).get();
    return await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }
}
