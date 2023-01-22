import 'package:co_chef_mobile/Models/Order.dart';
import 'package:co_chef_mobile/Screens/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen(order: widget.order)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(
                widget.order.getIcon(),
                size: 35.0,
              ),
              title: Text(
                widget.order.getstate(),
                style: TextStyle(fontSize: 25.0),
                textDirection: TextDirection.rtl,
              ),
              subtitle: Text(
                widget.order.payment.toString(),
                style: TextStyle(fontSize: 20.0),
                // textDirection: TextDirection.rtl,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(widget.order.date!, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                  onPressed: null,
                  // style: ButtonStyle(),
                ),
                const SizedBox(width: 8),
                TextButton(
                    child: Text(widget.order.address!.name!, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                    onPressed: null),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
