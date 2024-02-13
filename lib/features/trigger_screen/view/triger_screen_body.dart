import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../../../widgets/widgets.dart';
import '../trigger.dart';

class TriggerScreenBody extends StatefulWidget {
  final int trigger;
  const TriggerScreenBody({
    super.key,
    required this.trigger,
  });

  @override
  State<TriggerScreenBody> createState() => _TriggerScreenBodyState();
}

class _TriggerScreenBodyState extends State<TriggerScreenBody> {
  late List<TriggerModel> triggerList;

  @override
  void initState() {
    super.initState();
    triggerList =
        TriggerModel.triggerListGeneration(isFirstTrigger: widget.trigger == 1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: triggerList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _nonExpansionItem(
                    title: 'All Trigers',
                    textStyle: constants.Styles.robotoDarkS16W700,
                  );
                } else {
                  final dynamicIndex = index - 1;
                  final item = triggerList[dynamicIndex];
                  final bool isExpansion = item.isExpansion;

                  return isExpansion
                      ? CustomExpansionWidget(
                          item: item,
                          trigger: widget.trigger,
                        )
                      : _nonExpansionItem(
                          title: item.title,
                          textStyle: constants.Styles.robotoDarkS16W400,
                        );
                }
              },
            ),
          ),
          Container(
            height: 106,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: constants.Colors.white,
              boxShadow: [
                BoxShadow(
                  color: constants.Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    -3,
                  ),
                ),
              ],
            ),
            child: DefaultButton(
              title: 'Save',
              onPressed: () {
                context.popRoute();
              },
              iconPath: constants.Assets.addIcon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nonExpansionItem({
    required String title,
    required TextStyle textStyle,
  }) {
    return Container(
      height: 56,
      color: constants.Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          const CustomCheckboxWidget(),
        ],
      ),
    );
  }
}
