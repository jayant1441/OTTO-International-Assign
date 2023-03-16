import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:otto_international_assign/home_page/data/api/photos_api_handler.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageInitial());

  int currentPage = 1;
  bool isFetching = false;


  Future<void> getListOfImages({isPaginating = false}) async{

    try {
      emit(const HomePageLoading());
      List<ImageModel> listOfImagesFromAPI = await ImageApiHandler.getListOfImages(currentPage);
      emit(HomePageLoaded(listOfImagesFromAPI));
      currentPage++;
    }
    catch(e){
      emit(HomePageError("$e"));
    }
  }

  void resetCubit(){
    emit(const HomePageInitial());
  }

}