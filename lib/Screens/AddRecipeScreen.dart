import 'dart:io';

import 'package:co_chef_mobile/Bloc/RecipeBloc/recipe_bloc.dart';
import 'package:co_chef_mobile/Bloc/RecipeCategoriesBloc/recipecategories_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Models/RecipeCategories.dart';
import 'package:co_chef_mobile/Widgets/AppTextField.dart';
import 'package:co_chef_mobile/Widgets/IngredientSelectCard.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:co_chef_mobile/Widgets/fullScreenIngredientsDialog.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'LoginPage.dart';

class AddRecipeScreen extends StatefulWidget {
  AddRecipeScreen({Key? key}) : super(key: key);

  static String route = "/AddRecipeScreen";

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  GlobalKey itemKey = GlobalKey();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController caloriesController = new TextEditingController();
  final TextEditingController prepareController = new TextEditingController();
  final TextEditingController peopleNumberController = new TextEditingController();
  final TextEditingController ingredientsController = new TextEditingController();
  String durationString = 'المدة';
  bool isPublic = true;
  List<IngredientShop> ingredientsAmmount = [];
  int durationInMilliseconds = 0;
  String imageFile = '';
  RecipeCategory category = RecipeCategory(id: -1);
  // PickedFile image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeBloc(),
      child: BlocBuilder<RecipeBloc, RecipeState>(
        buildWhen: (previousState, state) {
          if (state is RecipeAddRecipeFailed && previousState is! RecipeAddRecipeFailed)
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          return true;
        },
        builder: (context, state) {
          if (state is RecipeLoading)
            return Scaffold(
              body: Center(
                child: scalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          else if (state is RecipeAddRecipeDone)
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          return Scaffold(
            backgroundColor: color4,
            body: ListView(
              children: [
                // Image(image: FileImage())
                imageWidget(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppTextField(
                            width: MediaQuery.of(context).size.width * 0.8,
                            controller: nameController,
                            hintText: 'الاسم',
                            textInputType: TextInputType.text,
                          ),
                          Icon(
                            Icons.drive_file_rename_outline,
                            size: 43,
                            color: color2,
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 17,
                      // ),
                      // Row(
                      //   children: [
                      //     AppTextField(
                      //       width: MediaQuery.of(context).size.width * 0.8,
                      //       controller: priceController,
                      //       hintText: 'السعر',
                      //       textInputType: TextInputType.number,
                      //     ),
                      //     Icon(
                      //       Icons.attach_money,
                      //       size: 43,
                      //       color: color2,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 17,
                      // ),
                      // Row(
                      //   children: [
                      //     AppTextField(
                      //       width: MediaQuery.of(context).size.width * 0.8,
                      //       controller: caloriesController,
                      //       hintText: 'السعرات',
                      //       textInputType: TextInputType.number,
                      //     ),
                      //     Icon(
                      //       Icons.directions_run,
                      //       size: 43,
                      //       color: color2,
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        children: [
                          PopUp(
                            child: Text(
                              durationString,
                              style: textStyle,
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.8,
                            onTap: () => duration(context),
                          ),
                          Icon(
                            Icons.access_alarm,
                            size: 43,
                            color: color2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        children: [
                          AppTextField(
                            width: MediaQuery.of(context).size.width * 0.8,
                            controller: peopleNumberController,
                            hintText: 'عدد الأشخاص',
                            textInputType: TextInputType.number,
                          ),
                          Icon(
                            Icons.people_outline,
                            size: 43,
                            color: color2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        children: [
                          PopUp(
                            child: Text(
                              'المكونات',
                              style: textStyle,
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.8,
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(35.0),
                                  // ),

                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.8,
                                          margin: EdgeInsets.only(bottom: 50.0),
                                          child: ListView(
                                            // mainAxisSize: MainAxisSize.min,
                                            // physics: NeverScrollableScrollPhysics(),
                                            children: <Widget>[
                                              // Padding(
                                              //   padding: EdgeInsets.all(10),
                                              //   child: Container(
                                              //     width: 80.0,
                                              //     height: 8.0,
                                              //     decoration: BoxDecoration(
                                              //         color: Colors.grey[400],
                                              //         borderRadius:
                                              //             BorderRadius.all(
                                              //                 Radius.circular(
                                              //                     8.0))),
                                              //   ),
                                              // ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 2, color: AppColors.color4)),
                                                height: MediaQuery.of(context).size.height * 0.50,
                                                child: ListView.builder(
                                                  itemCount: ingredientsAmmount.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return IngredientSelectCard(
                                                        ingredient: ingredientsAmmount[index],
                                                        ingredientList: ingredientsAmmount);
                                                  },
                                                ),
                                              ),
                                              PopUp(
                                                child: Text(
                                                  'إضافة مكون',
                                                  style: textStyle,
                                                ),
                                                height: 50.0,
                                                onTap: () {
                                                  showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      barrierLabel:
                                                          MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                      barrierColor: Colors.black45,
                                                      transitionDuration: const Duration(milliseconds: 200),
                                                      pageBuilder: (BuildContext buildContext, Animation animation,
                                                          Animation secondaryAnimation) {
                                                        return IngredientsDialog(
                                                          ingredeintsList: ingredientsAmmount,
                                                        );
                                                      });
                                                },
                                              ),
                                              PopUp(
                                                child: Text(
                                                  'تأكيد',
                                                  style: textStyle,
                                                ),
                                                height: 50.0,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          Icon(
                            Icons.list,
                            size: 43,
                            color: color2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        children: [
                          PopUp(
                            text: category.id == -1 ? 'أختر صنف' : category.name!,
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.8,
                            onTap: () async {
                              showGeneralDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                  barrierColor: Colors.black45,
                                  transitionDuration: const Duration(milliseconds: 200),
                                  pageBuilder:
                                      (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                    return BlocProvider(
                                      create: (context) => RecipecategoriesBloc()..add(RecipecategoriesFetch()),
                                      child: BlocBuilder<RecipecategoriesBloc, RecipecategoriesState>(
                                        builder: (context, state) {
                                          print('sadsdadsad');
                                          print(state);
                                          if (state is RecipecategoriesDone)
                                            return Scaffold(
                                              appBar: AppBar(
                                                backgroundColor: AppColors.color2,
                                                actions: [],
                                              ),
                                              body: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: double.infinity,
                                                  maxHeight: MediaQuery.of(context).size.height,
                                                  // minHeight: 100,
                                                  minWidth: double.infinity,
                                                ),
                                                height: MediaQuery.of(context).size.height,
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
                                                        category.id = state.categories[index].id;
                                                        category.name = state.categories[index].name;
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
                                            return Container(
                                              constraints: BoxConstraints(
                                                maxWidth: double.infinity,
                                                maxHeight: MediaQuery.of(context).size.height * 0.5,
                                                minHeight: 100,
                                                minWidth: double.infinity,
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              child: Center(
                                                child: scalingText(
                                                  'Co-Chef',
                                                  style: TextStyle(
                                                      color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                                                ),
                                              ),
                                            );
                                          else
                                            return Container(
                                              constraints: BoxConstraints(
                                                maxWidth: double.infinity,
                                                maxHeight: MediaQuery.of(context).size.height * 0.5,
                                                minHeight: 100,
                                                minWidth: double.infinity,
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              child: Center(
                                                child: Text('حدث خطأ ما '),
                                              ),
                                            );
                                        },
                                      ),
                                    );
                                  });

                              // await showDialog(
                              //   context: context,
                              //   useSafeArea: true,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: Center(child: Text('أختر صنف الوجبة')),
                              //     content: BlocProvider(
                              //       create: (context) => RecipecategoriesBloc()
                              //         ..add(RecipecategoriesFetch()),
                              //       child: BlocBuilder<RecipecategoriesBloc,
                              //           RecipecategoriesState>(
                              //         builder: (context, state) {
                              //           print('sadsdadsad');
                              //           print(state);
                              //           if (state is RecipecategoriesDone)
                              //             return Container(
                              //               constraints: BoxConstraints(
                              //                 maxWidth: double.infinity,
                              //                 maxHeight: MediaQuery.of(context)
                              //                         .size
                              //                         .height *
                              //                     0.5,
                              //                 minHeight: 100,
                              //                 minWidth: double.infinity,
                              //               ),
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height *
                              //                   0.3,
                              //               child: GridView.builder(
                              //                 gridDelegate:
                              //                     SliverGridDelegateWithMaxCrossAxisExtent(
                              //                         maxCrossAxisExtent: 100,
                              //                         childAspectRatio: 1.5,
                              //                         crossAxisSpacing: 1,
                              //                         mainAxisSpacing: 5),
                              //                 itemCount:
                              //                     state.categories.length,
                              //                 itemBuilder: (ctx, index) {
                              //                   return ActionChip(
                              //                     label: Text(state
                              //                         .categories[index].name),
                              //                     onPressed: () {
                              //                       category.id = state
                              //                           .categories[index].id;
                              //                       category.name = state
                              //                           .categories[index].name;
                              //                       setState(() {});
                              //                       Navigator.pop(context);
                              //                     },
                              //                     // backgroundColor: Get.theme.primaryColor,
                              //                   );
                              //                 },
                              //               ),
                              //             );
                              //           else if (state
                              //               is RecipecategoriesLoading)
                              //             return Container(
                              //               constraints: BoxConstraints(
                              //                 maxWidth: double.infinity,
                              //                 maxHeight: MediaQuery.of(context)
                              //                         .size
                              //                         .height *
                              //                     0.5,
                              //                 minHeight: 100,
                              //                 minWidth: double.infinity,
                              //               ),
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height *
                              //                   0.3,
                              //               child: Center(
                              //                 child: ScalingText(
                              //                   'Co-Chef',
                              //                   style: TextStyle(
                              //                       color: AppColors.color2,
                              //                       fontSize: 35.0,
                              //                       fontFamily: 'Pacifico'),
                              //                 ),
                              //               ),
                              //             );
                              //           else
                              //             return Container(
                              //               constraints: BoxConstraints(
                              //                 maxWidth: double.infinity,
                              //                 maxHeight: MediaQuery.of(context)
                              //                         .size
                              //                         .height *
                              //                     0.5,
                              //                 minHeight: 100,
                              //                 minWidth: double.infinity,
                              //               ),
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height *
                              //                   0.3,
                              //               child: Center(
                              //                 child: Text('حدث خطأ ما '),
                              //               ),
                              //             );
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          Icon(
                            Icons.category_outlined,
                            size: 43,
                            color: color2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppTextField(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  controller: prepareController,
                  hintText: 'طريقة التحضير',
                  textInputType: TextInputType.multiline,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الوصفة عامة',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    Switch(
                        value: isPublic,
                        activeColor: AppColors.color2,
                        // color
                        onChanged: (value) {
                          setState(() {
                            isPublic = value;
                          });
                        }),
                  ],
                ),
                PopUp(
                  child: Text(
                    'تأكيد',
                    style: textStyle,
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  onTap: () {
                    BlocProvider.of<RecipeBloc>(context).add(RecipeAddRecipe(
                        nameController.text,
                        int.parse(peopleNumberController.text),
                        durationInMilliseconds,
                        prepareController.text,
                        isPublic,
                        category.id,
                        ingredientsAmmount,
                        imageFile));
                  },
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget imageWidget() {
    if (imageFile != '')
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
            child: Image(image: FileImage(File(imageFile)))),
      );
    else {
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
            child: Center(
                child: GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

                      // PickedFile pickedFile =
                      //     await picker.(source: ImageSource.gallery);
                      setState(() {
                        imageFile = pickedFile!.path;
                      });
                    },
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 35.0,
                    )))),
      );
    }
  }

  void duration(BuildContext context) async {
    Duration? resultingDuration = await showDurationPicker(context: context, initialTime: new Duration(minutes: 30));
    setState(() {
      durationInMilliseconds = resultingDuration!.inMilliseconds;
      durationString = resultingDuration.toString().split('.').first.padLeft(8, "0");
    });
  }

  scalingText(String s, {required TextStyle style}) {}
}
