import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/news/cubit/cubit.dart';
import 'package:flutter_news_app/layout/news/cubit/states.dart';
import 'package:flutter_news_app/shared/components/components.dart';

class BusinessNews extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state) {},
      builder: (context , state) {

        var list = NewsCubit.get(context).business;
        return articleBuilder(list , context);
      },
    );
  }
}
