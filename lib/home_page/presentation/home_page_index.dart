import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otto_international_assign/home_page/business_logic/home_page_cubit.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';
import 'package:otto_international_assign/photo_view_page/presentation/photo_gallery_index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<ImageModel> _listOfImages = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent ) {
        BlocProvider.of<HomePageCubit>(context)
            .getListOfImages(isPaginating: true);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomePageCubit>(context).getListOfImages();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OTTO International"), backgroundColor: Colors.black),
        body: BlocConsumer<HomePageCubit, HomePageState>(
          listener: (context, state) {
            if (state is HomePageLoading) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Loading")));
            } else if (state is HomePageLoaded) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _listOfImages.addAll(state.listOfImages ?? []);
              BlocProvider.of<HomePageCubit>(context).isFetching = false;
            } else if (state is HomePageError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              BlocProvider.of<HomePageCubit>(context).isFetching = false;
            }
            return;
          },
          builder: (context, state) {
            if (state is HomePageInitial ||
                state is HomePageLoading && _listOfImages.isEmpty) {
              return CircularProgressIndicator();
            } else if (state is HomePageError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            return Container(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: _listOfImages.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0),
                  itemBuilder: (BuildContext context, int index) {
                    final ImageModel image = _listOfImages[index];
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
                                        "${image.urlOfImages!.small}"),
                                    fit: BoxFit.fill,
                                  ))),
                        ),
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
