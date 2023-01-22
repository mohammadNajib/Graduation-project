import 'package:co_chef_mobile/Bloc/SearchBloc/search_bloc.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Widgets/UserCard.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController name = TextEditingController();

  List<OtherProfile> users = [];

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
          else if (state is SearchDone) {
            users = state.users!;

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  // height: MediaQuery.of(context).size.width * 0001,
                                  decoration: BoxDecoration(
                                    color: AppColors.color4,
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                                    child: TextFormField(
                                      cursorColor: AppColors.color6,
                                      controller: name,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'اسم',
                                          labelStyle: TextStyle(
                                            color: AppColors.color2,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<SearchBloc>(context).add(SearchName(name.text));
                                },
                                child: Icon(
                                  Icons.search,
                                  color: AppColors.color2,
                                  size: 30.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(profile: state.users![index]);
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
