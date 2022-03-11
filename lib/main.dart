import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/news/cubit/cubit.dart';
import 'package:flutter_news_app/layout/news/cubit/states.dart';
import 'package:flutter_news_app/layout/news/news_layout.dart';
import 'package:flutter_news_app/shared/my_bloc_observer.dart';
import 'package:flutter_news_app/shared/network/local/news_cache_helper/cache_helper.dart';
import 'package:flutter_news_app/shared/network/remote/news_dio_helper/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          DioHelper.init();
          await CacheHelper.init();
          // bool isDark th get the boolean value from cacheHelper class and insert it to MyApp like line below
          late bool? isDark = CacheHelper.getBoolean(key: 'isDark');
          runApp(MyApp(
              isDark == null ? true : isDark,
          ));// =>  now we to initialize the bool isDark and call it by constructor MyApp()


    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {


  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared: isDark)..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit , NewsStates>(
            listener: (context , state){},
            builder: (context , state){

              return MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                      titleTextStyle: TextStyle(
                        color: Colors.black , fontWeight: FontWeight.bold , fontSize: 25,
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      color: Colors.white,
                      elevation: 0.0,
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      actionsIconTheme: IconThemeData(
                        color : Colors.black ,
                      )
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                      titleTextStyle: TextStyle(
                        color: Colors.white , fontWeight: FontWeight.bold , fontSize: 25,
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      color: HexColor('333739'),
                      elevation: 0.0,
                      actionsIconTheme: IconThemeData(
                        color : Colors.white ,
                      )
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20,
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey,
                  ),
                  scaffoldBackgroundColor: HexColor('333739'),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: NewsLayout(),
              );
            },
        ),
      );
  }
}
