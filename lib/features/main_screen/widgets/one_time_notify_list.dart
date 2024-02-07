import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../../../widgets/widgets.dart';

class OneTimeNotifyList extends StatelessWidget {
  const OneTimeNotifyList({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ['21:10', 'test 2', 'test 3', 'test 4'];
    final String iconPath = '';

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              top: 16, bottom: index == list.length - 1 ? 24 : 0),
          child: Container(
            decoration: BoxDecoration(
              color: constants.Colors.greyLight3,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: constants.Colors.purple,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: iconPath.isNotEmpty
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (iconPath.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: constants.Colors.greyDark,
                                ),
                              ),
                            ),
                          ),
                        _notifyInfo(
                          text1: 'Time:',
                          text2: list[index],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          constants.Assets.removeIcon,
                          color: constants.Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                if (iconPath.isNotEmpty) const SizedBox(height: 8),
                _notifyInfo(
                  text1: 'Message:',
                  text2: list[index],
                ),
                const SizedBox(height: 16),
                _cardButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notifyInfo({
    required String text1,
    required String text2,
  }) {
    return Row(
      children: [
        Text(
          text1,
          style: constants.Styles.robotoGreyDarkS14W400,
        ),
        const SizedBox(width: 4),
        Text(
          text2,
          style: constants.Styles.robotoDarkS14W700,
        ),
      ],
    );
  }

  Widget _cardButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CardButton(
              title: 'Select triger 1',
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CardButton(
              title: 'Select triger 2',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
