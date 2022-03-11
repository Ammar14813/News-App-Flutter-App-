import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/layout/news/cubit/cubit.dart';
import 'package:flutter_news_app/layout/news/cubit/states.dart';
import 'package:flutter_news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){

        var searchList = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  label: 'Search',
                  type: TextInputType.text,
                  prefix: Icons.search,
                  validate: 'search must not be empty',
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  onTap: (){

                  },
                ),
              ),
              Expanded(
                child: articleBuilder(
                    searchList, context , isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
