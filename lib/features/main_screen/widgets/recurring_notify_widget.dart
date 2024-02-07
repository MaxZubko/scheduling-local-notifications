import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class RecurringNotifyWidget extends StatelessWidget {
  const RecurringNotifyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: ListTile.divideTiles(
        color: constants.Colors.greyLight,
        context: context,
        tiles: [
          _buildListTile('1 Minute'),
          _buildListTile('3 Minute'),
          _buildListTile('5 Minute'),
        ],
      ).toList(),
    );
  }

  ListTile _buildListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: constants.Styles.robotoDarkS16W700,
      ),
      tileColor: constants.Colors.greyLight3,
      trailing: SvgPicture.asset(
        constants.Assets.arrowRight,
        color: constants.Colors.purple,
      ),
    );
  }
}
