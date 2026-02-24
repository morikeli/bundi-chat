import 'package:flutter/material.dart';

import '../../../../core/theme/color.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/imgs/dps/1.jpg'),
            radius: MediaQuery.of(context).size.width * .044,
          ),
          Positioned(
            bottom: 0,
            right: 4.0,
            child: Badge(
              backgroundColor: kUserOnlineBadgeColor,
              smallSize: 8.0,
              largeSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
