import 'dart:io';

import 'package:co_chef_mobile/Bloc/AddMealBloc/addmeal_bloc.dart';
import 'package:co_chef_mobile/Bloc/RecipeCategoriesBloc/recipecategories_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Models/RecipeCategories.dart';
import 'package:co_chef_mobile/Widgets/AppTextField.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

import 'WelcomePage.dart';

class AddMealScreen extends StatefulWidget {
  static String route = "/AddMealScreen";

  @override
  State<StatefulWidget> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController prepareController = new TextEditingController();
  final TextEditingController peopleNumberController = new TextEditingController();
  String imageFile = '';
  int durationInMilliseconds = 0;
  String durationString = 'المدة';
  RecipeCategory category = RecipeCategory(id: -1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddmealBloc(),
      child: BlocBuilder<AddmealBloc, AddmealState>(
        buildWhen: (previousState, state) {
          if (state is AddmealFailed && previousState is! AddmealFailed)
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
          if (state is AddmealLoading)
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          else if (state is AddmealDone)
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          return Scaffold(
            backgroundColor: color4,
            body: ListView(
              children: [
                // Image(image: FileImage()),
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
                            controller: priceController,
                            hintText: 'السعر',
                            textInputType: TextInputType.number,
                          ),
                          Icon(
                            Icons.attach_money,
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
                                                child: ScalingText(
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
                  hintText: 'المكونات',
                  textInputType: TextInputType.multiline,
                ),
                PopUp(
                  child: Text(
                    'تأكيد',
                    style: textStyle,
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  onTap: () {
                    //shadi
                    //     ChefRepo chefRepo = ChefRepo();

                    BlocProvider.of<AddmealBloc>(context).add(Addmeal(
                        nameController.text,
                        priceController.text,
                        peopleNumberController.text,
                        durationInMilliseconds.toString(),
                        prepareController.text,
                        category.id.toString(),
                        imageFile));
                    //  chefRepo.addMeal(nameController.text, priceController.text, peopleNumberController.text, preparationTime, howToPrepare, mealCategoryId, image)
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

                setState(() => imageFile = pickedFile!.path);
              },
              child: Icon(Icons.photo_camera_outlined, size: 35.0),
            ),
          ),
        ),
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
}
