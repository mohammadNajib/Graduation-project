import 'package:co_chef_mobile/Bloc/MealBloc/meal_bloc.dart';
import 'package:co_chef_mobile/Widgets/MealCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:progress_indicators/progress_indicators.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> with AutomaticKeepAliveClientMixin {
  GlobalKey itemKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => MealBloc()..add(MealsFetch()),
      child: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealLoading)
            return Scaffold(
              backgroundColor: AppColors.color4,
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          else if (state is MealDone)
            return Scaffold(
              backgroundColor: AppColors.color4,
              body: RefreshIndicator(
                color: AppColors.color2,
                onRefresh: () async {
                  BlocProvider.of<MealBloc>(context).add(MealsFetch());
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 55.0),
                  scrollDirection: Axis.vertical,
                  itemCount: state.meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MealCard(meal: state.meals[index]);
                  },
                ),
              ),
            );

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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
