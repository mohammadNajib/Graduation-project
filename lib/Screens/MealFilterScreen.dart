import 'package:co_chef_mobile/Bloc/RecipeCategoriesBloc/recipecategories_bloc.dart';
import 'package:co_chef_mobile/Bloc/SearchBloc/search_bloc.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Widgets/MealCard.dart';
import 'package:co_chef_mobile/Widgets/SearchFilterWidget.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class MealFilterScreen extends StatefulWidget {
  const MealFilterScreen({Key? key}) : super(key: key);

  @override
  _MealFilterScreenState createState() => _MealFilterScreenState();
}

class _MealFilterScreenState extends State<MealFilterScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController minCalories = TextEditingController();
  TextEditingController maxCalories = TextEditingController();
  TextEditingController price = TextEditingController();
  String category = 'الصنف';
  late String preparationTime;
  int rating = -1;
  int durationInMilliseconds = 0;
  String durationString = 'مدة التحضير';

  List<Meal> meals = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading)
            return Scaffold(
                backgroundColor: AppColors.color4,
                body: Center(
                    child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                )));
          if (state is SearchDone) {
            meals = state.data ?? [];
            return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: FloatingActionButton(
                  backgroundColor: AppColors.color2,
                  child: Icon(
                    Icons.search,
                    color: AppColors.color4,
                  ),
                  onPressed: () {
                    BlocProvider.of<SearchBloc>(context).add(SearchMeals(price.text, minCalories.text, maxCalories.text,
                        preparationTime, rating.toString(), category == 'الصنف' ? 'null' : category));
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SearchFilterWidget(label: 'عدد السعرات الأدنى', controller: minCalories),
                                SearchFilterWidget(label: 'عدد السعرات الأعلى', controller: maxCalories),
                                SearchFilterWidget(label: 'السعر', controller: price),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: AppColors.color4,
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: Center(child: Text('أختر صنف الوجبة')),
                                          content: BlocProvider(
                                            create: (context) => RecipecategoriesBloc()..add(RecipecategoriesFetch()),
                                            child: BlocBuilder<RecipecategoriesBloc, RecipecategoriesState>(
                                              builder: (context, state) {
                                                if (state is RecipecategoriesDone)
                                                  return Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: double.infinity,
                                                      maxHeight: MediaQuery.of(context).size.height,
                                                      minHeight: 100,
                                                      minWidth: double.infinity,
                                                    ),
                                                    height: MediaQuery.of(context).size.height * 0.3,
                                                    child: Center(
                                                      child: GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent: 100,
                                                            childAspectRatio: 1.5,
                                                            crossAxisSpacing: 1,
                                                            mainAxisSpacing: 5),
                                                        itemCount: state.categories.length,
                                                        itemBuilder: (ctx, index) {
                                                          return ActionChip(
                                                            label: Text(state.categories[index].name!),
                                                            onPressed: () {
                                                              category = state.categories[index].name!;
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            },
                                                            // backgroundColor: Get.theme.primaryColor,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                else if (state is RecipecategoriesLoading)
                                                  return Center(
                                                    child: ScalingText(
                                                      'Co-Chef',
                                                      style: TextStyle(
                                                          color: AppColors.color2,
                                                          fontSize: 35.0,
                                                          fontFamily: 'Pacifico'),
                                                    ),
                                                  );
                                                else
                                                  return Center(
                                                    child: Text('حدث خطأ ما '),
                                                  );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                                        child: Center(
                                            child: Text(
                                          category,
                                          style: TextStyle(color: AppColors.color2, fontSize: 15.0),
                                        ))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: AppColors.color4,
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                            // title: Center(child: Text('أختر صنف الوجبة')),
                                            content: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: double.infinity,
                                            maxHeight: MediaQuery.of(context).size.height,
                                            minHeight: 100,
                                            minWidth: double.infinity,
                                          ),
                                          height: MediaQuery.of(context).size.height * 0.15,
                                          child: Center(
                                              child: SimpleStarRating(
                                            allowHalfRating: false,
                                            isReadOnly: false,
                                            starCount: 5,
                                            rating: (rating == -1) ? 0 : rating.toDouble(),
                                            size: 32,
                                            onRated: (rate) async {
                                              rating = rate!.toInt();
                                              setState(() {});
                                            },
                                            spacing: 10,
                                          )),
                                        )),
                                      );
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                                        child: Center(
                                            child: Text(
                                          (rating == -1) ? 'التقييم' : rating.toString(),
                                          style: TextStyle(color: AppColors.color2, fontSize: 15.0),
                                        ))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: AppColors.color4,
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      duration(context);
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                                        child: Center(
                                            child: Text(
                                          durationString,
                                          style: TextStyle(color: AppColors.color2, fontSize: 15.0),
                                        ))),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.62,
                      child: ListView.builder(
                        itemCount: meals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MealCard(meal: meals[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return Scaffold(
              backgroundColor: AppColors.color4,
              body: Center(
                child: Text('حدث خطأ ما'),
              ),
            );
        },
      ),
    );
  }

  void duration(BuildContext context) async {
    Duration? resultingDuration = await showDurationPicker(
      context: context,
      initialTime: new Duration(minutes: 30),
    );
    setState(() {
      durationInMilliseconds = resultingDuration!.inMilliseconds;
      durationString = resultingDuration.toString().split('.').first.padLeft(8, "0");
    });
  }

  @override
  bool get wantKeepAlive => true;
}
