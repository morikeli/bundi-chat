import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/theme/color.dart';

class NewMessageFAB extends StatelessWidget {
  const NewMessageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * .08,
      ),
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New Message',
        child: Icon(LineIcons.penNib, color: kIconLightColor),
      ),
    );
  }
}
