import 'package:flutter/material.dart';
import 'package:pwdmgr/utils/Styles.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class SearchField extends StatelessWidget {
  final TextEditingController search;
  final VoidCallback press;
  final String hintText;

  const SearchField(
      {required this.press, required this.search, required this.hintText});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Container(
          width: SZ.H * 75.0,
          height: SZ.V * 5.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SZ.V * 1.5),
              color: const Color(0xFFE8E8E8)),
          margin: EdgeInsets.symmetric(horizontal: SZ.H * 1.0),
          child: TextField(
            controller: search,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: const Color(0xFF727272)),
              contentPadding: EdgeInsets.all(SZ.H * 4.0),
            ),
          ),
        ),
      ),
      Container(
        height: SZ.V * 5.0,
        width: SZ.V * 5.0,
        margin: EdgeInsets.symmetric(horizontal: SZ.H * 1.0),
        decoration: BoxDecoration(
            color: Style.PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(SZ.V * 1.5)),
        alignment: Alignment(0.0, 0.0),
        child: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: press,
          color: Style.PRIMARY_COLOR,
        ),
      )
    ]);
  }
}
