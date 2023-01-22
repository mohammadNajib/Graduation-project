import 'package:co_chef_mobile/Bloc/OrderHistorybloc/orderhistory_bloc.dart';
import 'package:co_chef_mobile/Models/Order.dart';
import 'package:co_chef_mobile/Repositories/OrderHistoryRepo.dart';
import 'package:co_chef_mobile/Widgets/PopUP.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late int rating;
  TextEditingController controller = TextEditingController();
  OrderHistoryRepo orderHistoryRepo = OrderHistoryRepo();

  @override
  void initState() {
    if (widget.order.notes != null)
      controller.text = widget.order.notes!;
    else
      controller.text = ' ';
    print(widget.order.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            margin: EdgeInsets.only(bottom: 50.0),
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.color4)),
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    itemCount: widget.order.ingredients!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.color4,
                          border: Border.all(
                            color: AppColors.color2,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.order.ingredients![index].image!), fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      widget.order.ingredients![index].name!,
                                      style:
                                          TextStyle(fontSize: 30, color: AppColors.color3, fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ((widget.order.ingredients![index].amount!.value! *
                                                      widget.order.ingredients![index].pivot!.quantity!)
                                                  .toString() +
                                              ' ' +
                                              widget.order.ingredients![index].amount!.unit!),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.color3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  ((widget.order.ingredients![index].price! *
                                              widget.order.ingredients![index].pivot!.quantity!)
                                          .toString()) +
                                      '  ليرة ',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.color3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                PopUp(text: widget.order.getstate(), height: 50.0, onTap: () {}),
                PopUp(text: widget.order.payment.toString(), height: 50.0, onTap: () {}),
                PopUp(text: widget.order.date!, height: 50.0, onTap: () {}),
                PopUp(
                  text: 'التقييم',
                  height: 50.0,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          content: Container(
                        constraints: BoxConstraints(
                          maxWidth: double.infinity,
                          maxHeight: MediaQuery.of(context).size.height,
                          minHeight: 100,
                          minWidth: double.infinity,
                        ),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Center(
                            child: Column(
                          children: [
                            SimpleStarRating(
                              allowHalfRating: false,
                              starCount: 5,
                              rating: (widget.order.rating == null) ? 3 : widget.order.rating!.toDouble(),
                              size: 32,
                              onRated: (rate) async => rating = rate!.toInt(),
                              isReadOnly: ((widget.order.rating == null)) ? false : true,
                              spacing: 10,
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey, borderRadius: new BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                                child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  controller: controller,
                                  enabled: (widget.order.rating == null) ? true : false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'ملاحظات إضافية',
                                      labelStyle: TextStyle(color: AppColors.color2)),
                                ),
                              ),
                            ),
                            (widget.order.rating == null)
                                ? PopUp(
                                    text: 'تقديم',
                                    height: MediaQuery.of(context).size.height * 0.3 * 0.2,
                                    onTap: () async {
                                      await orderHistoryRepo.rateOrder(widget.order.id!, rating, controller.text);
                                      widget.order.rating = rating;
                                      widget.order.notes = controller.text;

                                      Navigator.pop(context);
                                    },
                                  )
                                : Container(),
                          ],
                        )),
                      )),
                    );
                  },
                ),
                PopUp(
                  text: widget.order.address!.name!,
                  height: 50.0,
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            margin: EdgeInsets.only(bottom: 50.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    width: 80.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                  ),
                                ),
                                Text(
                                  widget.order.address!.name!,
                                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.order.address!.city! +
                                      '-' +
                                      widget.order.address!.area! +
                                      '-' +
                                      widget.order.address!.subarea!,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(widget.order.address!.details!, style: TextStyle(fontSize: 18.0)),
                                Text('الطابق ${widget.order.address!.floor}'),
                              ],
                            ),
                          );
                        });
                  },
                ),
                (widget.order.status != 14)
                    ? PopUp(
                        text: 'تأكيد التوصيل',
                        height: 50.0,
                        onTap: () async {
                          await orderHistoryRepo.confirmOrder(widget.order.id!);
                          widget.order.status = 14;
                          widget.order.state = 'delivered';
                          Fluttertoast.showToast(
                              msg: 'تم تأكيد استلام الطلب',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {});
                          BlocProvider.of<OrderhistoryBloc>(context).add(OrderhistoryFetch());
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
