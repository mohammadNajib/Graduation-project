import 'package:co_chef_mobile/Bloc/OrderHistorybloc/orderhistory_bloc.dart';
import 'package:co_chef_mobile/Widgets/OrderCard.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderhistoryBloc()..add(OrderhistoryFetch()),
      child: BlocBuilder<OrderhistoryBloc, OrderhistoryState>(
        builder: (context, state) {
          if (state is OrderhistoryDone) {
            return Scaffold(
                body: RefreshIndicator(
              color: AppColors.color2,
              onRefresh: () async {
                BlocProvider.of<OrderhistoryBloc>(context).add(OrderhistoryFetch());
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(order: state.orders[index]);
                  },
                ),
              ),
            ));
          } else if (state is OrderHistoryLoading)
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          else if (state is OrderhistoryFailed) {
            return Scaffold(
              body: Center(
                child: Text('حدث خطأ ما '),
              ),
            );
          } else
            return Scaffold();
        },
      ),
    );
  }
}
