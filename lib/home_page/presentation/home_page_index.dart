import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otto_international_assign/home_page/business_logic/home_page_cubit.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomePageCubit>(context).getListOfInitialImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.black
        ),

        body: BlocConsumer<HomePageCubit, HomePageState> (
          listener: (context, state){
            if(state is HomePageError){
              ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("An Error Occurred")));
            }
          },
          builder: (context, state){
            if(state is HomePageLoading){
              return CircularProgressIndicator();
            }
            else if(state is HomePageLoaded){
              return Container(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: state.listOfImages?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                      final ImageModel image = state.listOfImages![index];
                      return GestureDetector(
                        onTap: (){

                        },
                        child: PhysicalModel(color: Colors.black,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child:Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${image.urlOfImages!.raw}"
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                )

                            ) ,
                          ),),
                      );
                    },
                  )

              );
            }
            else if(state is HomePageError){
              return Center(
                child: Text(state.errorMessage),
              );
            }

            return const CircularProgressIndicator();

          },
        )
    );
  }


}

