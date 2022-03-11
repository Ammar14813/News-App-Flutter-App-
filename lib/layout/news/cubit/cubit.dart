import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/news/cubit/states.dart';
import 'package:flutter_news_app/modules/business_news/business_news.dart';
import 'package:flutter_news_app/modules/science_news/science_news.dart';
import 'package:flutter_news_app/modules/sports_news/sports_news.dart';
import 'package:flutter_news_app/shared/network/local/news_cache_helper/cache_helper.dart';
import 'package:flutter_news_app/shared/network/remote/news_dio_helper/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(
            Icons.business
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports
        ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessNews(),
    SportsNews(),
    ScienceNews(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
   /* if(index == 1)
      getSports();
    if(index == 2)
      getScience();*/
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];


  void getBusiness(){

    emit(NewsGetBusinessLoadingState());

    DioHelper.getDate(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'7463c0b7a7ad4469864753ff4198d5de',
      },
    ).then((value) {
      business = value!.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  void getSports(){

    if(sports.length == 0){
      emit(NewsGetSportsLoadingState());

      DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'7463c0b7a7ad4469864753ff4198d5de',
        },
      ).then((value) {
        sports = value!.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsLoadingState());

    }
  }
  void getScience(){

    if(science.length == 0){
      emit(NewsGetScienceLoadingState());

      DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'7463c0b7a7ad4469864753ff4198d5de',
        },
      ).then((value) {
        science = value!.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else {
      emit(NewsGetScienceLoadingState());

    }


  }
  void getSearch(String value){

    search.clear();

    emit(NewsGetSearchLoadingState());


    DioHelper.getDate(
      url: 'v2//everything',
      query: {
        'q':'$value',
        'apiKey':'7463c0b7a7ad4469864753ff4198d5de',
      },
    ).then((value) {
      search = value!.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }


  bool isDark = false ;

  void changeAppMode({bool? fromShared}){

    if(fromShared != null){
      isDark = fromShared ;
      emit(NewsChangeAppModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.setBoolean(
          key: 'isDark', value: isDark).then((value){
        emit(NewsChangeAppModeState());
      });
    }
  }

  void clearSearch(){
    search.clear();
  }


}