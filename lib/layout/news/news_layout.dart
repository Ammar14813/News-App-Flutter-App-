import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/news/cubit/cubit.dart';
import 'package:flutter_news_app/layout/news/cubit/states.dart';
import 'package:flutter_news_app/modules/search_news/search_news.dart';
import 'package:flutter_news_app/shared/components/components.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state) {},
      builder: (context , state){
        var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App' ,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    NewsCubit.get(context).clearSearch();
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                    onPressed: (){
                      NewsCubit.get(context).changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
      },
    );
  }
}
