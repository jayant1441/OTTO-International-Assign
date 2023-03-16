import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:otto_international_assign/home_page/data/api/photos_api_handler.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageLoading());

  List<ImageModel>? _listOfImages;

  Future<void> getListOfInitialImages({int pageNumber = 1, isPaginating = false}) async{
    try {
      emit(const HomePageLoading());
      if(isPaginating){
        List<ImageModel> listOfImagesFromAPI = await ImageApiHandler.getListOfImages(pageNumber);
        _listOfImages ??= [];
        _listOfImages!.addAll(listOfImagesFromAPI);
      }
      _listOfImages = await ImageApiHandler.getListOfImages(pageNumber);
      emit(HomePageLoaded(_listOfImages));
    }
    catch(e){
      emit(HomePageError("$e"));
    }
  }

  void resetCubit(){
    emit(const HomePageInitial());
  }

}