import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/router/router.dart';

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
          _buildListTile(context, '1 Minute', 1),
          _buildListTile(context, '3 Minute', 3),
          _buildListTile(context, '5 Minute', 5),
        ],
      ).toList(),
    );
  }

  Widget _buildListTile(BuildContext context, String title, int recurring) {
    return Column(
      children: [
        // ListTile(
        //   onTap: () {
        //     context.pushRoute(
        //       RecurringNotifyRoute(recurring: recurring),
        //     );
        //   },
        //   title: Text(
        //     title,
        //     style: constants.Styles.robotoDarkS16W700,
        //   ),
        //   tileColor: constants.Colors.greyLight3,
        //   trailing: SvgPicture.asset(
        //     constants.Assets.arrowRight,
        //     color: constants.Colors.purple,
        //   ),
        //   contentPadding: const EdgeInsets.only(left: 16, right: 22),
        // ),
        GestureDetector(
          onTap: () => context.pushRoute(
            RecurringNotifyRoute(recurring: recurring),
          ),
          child: Container(
            height: 56,
            decoration: const BoxDecoration(
              color: constants.Colors.greyLight3,
              border: Border(
                bottom: BorderSide(
                  color: constants.Colors.greyLight,
                  width: 1.0,
                ),
              ),
            ),
            padding: const EdgeInsets.only(left: 16, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: constants.Styles.robotoDarkS16W700,
                ),
                SvgPicture.asset(
                  constants.Assets.arrowRight,
                  color: constants.Colors.purple,
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   height: 1,
        //   color: constants.Colors.greyLight,
        // ),
      ],
    );
  }
}
