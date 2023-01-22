import 'package:co_chef_mobile/Bloc/RecipeBloc/recipe_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Screens/RecipeIngredientsScreen.dart';
import 'package:co_chef_mobile/Screens/userProfile.dart';
import 'package:co_chef_mobile/Widgets/RecipeCard.dart';
import 'package:co_chef_mobile/Widgets/StoreItem.dart';
import 'package:co_chef_mobile/Widgets/TextListItem.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe? recipe;
  RecipeScreen({Key? key, this.recipe}) : super(key: key);

  static String route = "/RecipeScreen";

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  GlobalKey itemKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeBloc()..add(RecipeGetDetailes(widget.recipe!.id!)),
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading)
            return Scaffold(
              backgroundColor: AppColors.color4,
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          else if (state is RecipeDetailsDone)
            return Scaffold(
              backgroundColor: color4,
              body: ListView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                children: [
                  Image(image: NetworkImage(widget.recipe!.image!)),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Icon(widget.recipe!.isFavorite! ? Icons.favorite : Icons.favorite_border,
                              color: color2, size: 43),
                          onTap: () {
                            if (!widget.recipe!.isFavorite!)
                              BlocProvider.of<RecipeBloc>(context).recipeRepo.addToFavorite(widget.recipe!.id!);
                            else
                              BlocProvider.of<RecipeBloc>(context).recipeRepo.removeFromFavorite(widget.recipe!.id!);
                            widget.recipe!.isFavorite = !widget.recipe!.isFavorite!;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              widget.recipe!.rating.toString(),
                              style: TextStyle(color: AppColors.color3, fontSize: 30.0),
                            ),
                            Icon(
                              Icons.star,
                              color: color2,
                              size: 43,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(widget.recipe!.name!, style: TextStyle(fontSize: 40.0, color: AppColors.color3)),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1),
                  (widget.recipe!.tags!.isNotEmpty)
                      ? Container(
                          height: 65,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.recipe!.tags!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.334,
                                child: StoreItem(text: widget.recipe!.tags![index].name),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextListItem(text: widget.recipe!.price.toString()),
                          SizedBox(height: 17),
                          TextListItem(text: widget.recipe!.calories.toString()),
                          SizedBox(height: 17),
                          TextListItem(
                              text: Duration(milliseconds: widget.recipe!.preparationTime!).inMinutes.toString()),
                          SizedBox(height: 17),
                          TextListItem(text: widget.recipe!.category!),
                          SizedBox(height: 17),
                          TextListItem(text: widget.recipe!.sharesNumber.toString()),
                          SizedBox(height: 17),
                          SizedBox(height: 20, width: 50),
                          TextListItem(text: widget.recipe!.authorName!)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextListItem(text: 'السعر'),
                          TextListItem(text: 'السعرات'),
                          TextListItem(text: 'المدة بالدقائق'),
                          TextListItem(text: 'الصنف'),
                          TextListItem(text: 'عدد الحصص'),
                          GestureDetector(
                              child: TextListItem(text: 'المكونات'),
                              onTap: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                    barrierColor: Colors.black45,
                                    transitionDuration: const Duration(milliseconds: 200),
                                    pageBuilder:
                                        (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                      return RecipeIngredientsScreen(ingredients: widget.recipe!.ingredients!);
                                    });
                              }),
                          GestureDetector(
                              child: TextListItem(text: 'الناشر'),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => UserProfile(id: widget.recipe!.authorId!)));
                              }),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.attach_money, size: 43, color: color2),
                          Icon(Icons.directions_run, size: 43, color: color2),
                          Icon(Icons.access_alarm, size: 43, color: color2),
                          Icon(Icons.category, size: 43, color: color2),
                          Icon(Icons.people_outline, size: 43, color: color2),
                          Icon(Icons.shopping_bag, size: 43, color: color2),
                          Icon(Icons.person, size: 43, color: color2),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: SimpleStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: (widget.recipe!.myRating == null) ? 3 : widget.recipe!.myRating!.toDouble(),
                      size: 32,
                      onRated: (rate) async {
                        BlocProvider.of<RecipeBloc>(context).recipeRepo.addRating(widget.recipe!.id!, rate);
                      },
                      isReadOnly: (widget.recipe!.myRating == null) ? false : true,
                      spacing: 10,
                    ),
                  ),
                  (state.recipeDetails.recomended.recommendedRecipes.isNotEmpty)
                      ? Container(
                          height: 175,
                          child: ListView.builder(
                            itemCount: state.recipeDetails.recomended.recommendedRecipes.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return RecipeCard(recipe: state.recipeDetails.recomended.recommendedRecipes[index]);
                            },
                          ),
                        )
                      : Container(),
                  GestureDetector(
                    onTap: () => {
                      scrollController.position.ensureVisible(itemKey.currentContext!.findRenderObject()!,
                          alignment: 0.01, duration: const Duration(seconds: 1)),
                      setState(() {}),
                    },
                    child: TextListItem(text: 'طريقة التحضير', key: itemKey),
                  ),
                  Divider(height: 2, color: AppColors.color3),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.77,
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Text(widget.recipe!.howToPrepare!,
                            style: TextStyle(fontSize: 20.0, color: AppColors.color3), textDirection: TextDirection.rtl)
                      ],
                    ),
                  ),
                  SizedBox(height: 60)
                ],
              ),
            );

          return Scaffold(backgroundColor: AppColors.color4, body: Center(child: Text('حدث خطأ ما')));
        },
      ),
    );
  }
}
