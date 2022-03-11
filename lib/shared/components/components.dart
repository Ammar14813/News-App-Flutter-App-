import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/modules/web_view_news/web_view_news.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 25.0,
  required Function onPress,
  required String text,
}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function?  onTap,
  bool isPassword = false,
  required String validate,
  required String label,
  required IconData prefix,
  IconButton? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (value) {
        if (value == null || value.isEmpty){
          onSubmit??(value);
        }else{
          onSubmit??(value);
        }
      },
      onChanged: (value) {
        if (value == null || value.isEmpty){
          onChange!(value);
        }else{
          onChange!(value);
        }
      },
      onTap: (){
        onTap!();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$validate';
        }else{
          return null ;
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );



// buildArticleItem use for creating an article items like (image and newsTitle and newsPublication)
Widget buildArticleItem(article , context) => InkWell(
  onTap: (){
    navigateTo(context ,WebViewNews(article['url']) );
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: article['urlToImage'] == null ? NetworkImage(
                  'https://www.lmeter.com/img/noimage.png')
                  : NetworkImage('${article['urlToImage']}') ,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

// myDivider use for the divider line that separate the list Items
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

// articleBuilder use for creating list of Items of article that waiting the coming data
Widget articleBuilder(list , context , {bool isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (BuildContext context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index) => buildArticleItem(list[index] , context),
    separatorBuilder: (context , index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (BuildContext context) => isSearch ? Container() : Center(
      child: CircularProgressIndicator()
  ),

);

// method navigateTo
void navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);