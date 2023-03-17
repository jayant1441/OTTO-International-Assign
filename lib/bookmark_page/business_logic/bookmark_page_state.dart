part of 'bookmark_page_cubit.dart';

@immutable
abstract class BookmarkPageState {
  const BookmarkPageState();
}

class BookmarkPageInitial extends BookmarkPageState {
  const BookmarkPageInitial();
}

class BookmarkPageLoading extends BookmarkPageState {
  const BookmarkPageLoading();
}

class BookmarkPageUploading extends BookmarkPageState {
  const BookmarkPageUploading();
}

class BookmarkPageUploaded extends BookmarkPageState {
  final bool? isBookmarkAdded;
  const BookmarkPageUploaded(this.isBookmarkAdded);
}

class BookmarkPageUploadingError extends BookmarkPageState {
  final String errorMessage;
  const BookmarkPageUploadingError(this.errorMessage);
}


class BookmarkPageLoaded extends BookmarkPageState {
  final List<BookmarkModel>? listOfBookMarks;
  const BookmarkPageLoaded(this.listOfBookMarks);
}

class BookmarkPageError extends BookmarkPageState {
  final String errorMessage;
  const BookmarkPageError(this.errorMessage);
}
