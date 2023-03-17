import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:otto_international_assign/bookmark_page/data/models/Bookmark_model.dart';

import 'package:uuid/uuid.dart' ;


class BookmarkApiHandler{

  static Dio dio = GetIt.I<Dio>();
  static const uuid = Uuid();


  /// Function to add bookmark
  static Future<bool?> addBookmark( String email, String imageUrl) async{

    try{
      String id  = uuid.v1();

      BookmarkModel bookmarkModel = BookmarkModel(
         email: email,
        imageUrl: imageUrl
      );

      await FirebaseFirestore.instance.collection("bookmarks").doc(id).set(bookmarkModel.toJson());
      return true;

    }catch(e){
      throw Exception("Error Occurred $e");
    }
  }


  /// Function to get all bookmarks by email id, we can also use uid instead of email
  static Future<List<BookmarkModel>> getAllBookMarkedImages(String email) async{
    try{
      CollectionReference collectionRef = FirebaseFirestore.instance.collection('bookmarked');

      // Get docs from collection reference
      QuerySnapshot querySnapshot = await collectionRef.where("email", isEqualTo: email).get();

      // Get data from docs and convert map to List
      final List<BookmarkModel> allBookmarks = querySnapshot.docs.map((doc) {
        return BookmarkModel.fromJson(doc.data() as Map<String , dynamic>);
      }).toList();

      return allBookmarks;
    }
    catch(E){
      throw Exception("Error Occurred $E");
    }
  }

}