import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otto_international_assign/bookmark_page/business_logic/bookmark_page_cubit.dart';
import 'package:otto_international_assign/bookmark_page/data/models/Bookmark_model.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';
import 'package:otto_international_assign/photo_view_page/presentation/photo_gallery_index.dart';
import 'package:otto_international_assign/utils/colors.dart';

class MyBookmarkPage extends StatefulWidget {
  const MyBookmarkPage({super.key});

  @override
  State<MyBookmarkPage> createState() => _MyBookmarkPageState();
}

class _MyBookmarkPageState extends State<MyBookmarkPage> {
  final ScrollController _scrollController = ScrollController();
  final List<BookmarkModel> _listOfBookmarks = [];
  final List<ImageModel> _listOfImages = [];

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BookmarkPageCubit>(context).getAllBookmarks();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkPageCubit, BookmarkPageState>(
      listener: (context, state) {
        if (state is BookmarkPageLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(backgroundColor: AppColors.goldColor,content: Text("Loading")));
        } else if (state is BookmarkPageLoaded) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          _listOfBookmarks.addAll(state.listOfBookMarks ?? []);
          BlocProvider.of<BookmarkPageCubit>(context).isFetching = false;

          _listOfImages.addAll(_listOfBookmarks.map((e) => ImageModel(
              urlOfImages: Urls(
                  small: e.imageUrl
              )
          )).toList());

        } else if (state is BookmarkPageError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          BlocProvider.of<BookmarkPageCubit>(context).isFetching = false;
        }
        return;
      },
      builder: (context, state) {
        if (state is BookmarkPageInitial ||
            state is BookmarkPageLoading && _listOfBookmarks.isEmpty) {
          return const CircularProgressIndicator(
            color: AppColors.goldColor,
          );
        } else if (state is BookmarkPageError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        if(state is BookmarkPageLoaded &&  _listOfBookmarks.isEmpty ){
          return const Center(
            child: Text("There are no bookmarks available."),
          );
        }

        return Container(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              controller: _scrollController,
              itemCount: _listOfBookmarks.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0),
              itemBuilder: (BuildContext context, int index) {
                final BookmarkModel bookmark = _listOfBookmarks[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GalleryPhotoViewWrapper(
                          galleryItems: _listOfImages,
                          backgroundDecoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          initialIndex: index,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    );
                  },
                  child: PhysicalModel(
                    color: Colors.black,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "${bookmark.imageUrl}"),
                                fit: BoxFit.fill,
                              ))),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
