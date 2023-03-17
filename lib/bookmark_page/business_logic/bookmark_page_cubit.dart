import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:otto_international_assign/bookmark_page/data/api/bookmark_api_handler.dart';
import 'package:otto_international_assign/bookmark_page/data/models/Bookmark_model.dart';
part 'bookmark_page_state.dart';

class BookmarkPageCubit extends Cubit<BookmarkPageState> {
  BookmarkPageCubit() : super(const BookmarkPageInitial());

  int currentPage = 1;
  bool isFetching = false;


  Future<void> addBookmark(String imageUrl) async{
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      emit( BookmarkPageUploading(imageUrl));
      bool? isBookmarkAdded = await BookmarkApiHandler.addBookmark(email ,imageUrl);
      emit(BookmarkPageUploaded(isBookmarkAdded, imageUrl));
    }
    catch(e){
      emit(BookmarkPageUploadingError("$e"));
    }
  }


  Future<void> getAllBookmarks() async{
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      emit(const BookmarkPageLoading());
      List<BookmarkModel> listOfBookmarks = await BookmarkApiHandler.getAllBookMarkedImages(email);
      emit(BookmarkPageLoaded(listOfBookmarks));
    }
    catch(e){
      emit(BookmarkPageError("$e"));
    }
  }



  void resetCubit(){
    emit(const BookmarkPageInitial());
  }

}