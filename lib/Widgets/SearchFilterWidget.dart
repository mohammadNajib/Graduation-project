import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({Key? key, required this.label, required this.controller}) : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(color: AppColors.color4, borderRadius: new BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
          child: TextFormField(
              cursorColor: AppColors.color6,
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none, labelText: label, labelStyle: TextStyle(color: AppColors.color2))),
        ),
      ),
    );
  }
}
