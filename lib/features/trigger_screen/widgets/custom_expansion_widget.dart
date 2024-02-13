import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/features/trigger_screen/trigger.dart';

import '../../../models/models.dart';

class CustomExpansionWidget extends StatefulWidget {
  final TriggerModel item;
  final int trigger;
  const CustomExpansionWidget({
    super.key,
    required this.item,
    required this.trigger,
  });

  @override
  State<CustomExpansionWidget> createState() => _CustomExpansionWidgetState();
}

class _CustomExpansionWidgetState extends State<CustomExpansionWidget> {
  bool _isExpanded = false;
  late TriggerModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          SvgPicture.asset(
            _isExpanded
                ? constants.Assets.arrowTop
                : constants.Assets.arrowBottom,
            color: constants.Colors.purple,
          ),
          const SizedBox(width: 15),
          Text(
            item.title,
            style: constants.Styles.robotoDarkS16W700,
          ),
        ],
      ),
      trailing: const CustomCheckboxWidget(),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: item.partsOfDayList.isNotEmpty
          ? [
              for (int i = 0; i < item.partsOfDayList.length; i++) ...[
                item.partsOfDayList[i].isExpansion
                    ? _partsOfDayCard(
                        partsOfDayItem: item.partsOfDayList[i],
                        index: i,
                        lastIndex: item.partsOfDayList.length - 1,
                      )
                    : _nonExpansionItem(
                        title: item.partsOfDayList[i].title,
                        textStyle: constants.Styles.robotoDarkS16W400,
                        index: i,
                        lastIndex: item.partsOfDayList.length - 1,
                      ),
              ],
            ]
          : [],
    );
  }

  Widget _partsOfDayCard({
    required PartsOfDayModel partsOfDayItem,
    required int index,
    required int lastIndex,
  }) {
    final helper = GetIt.I<TriggerListHelper>();
    final isFirstTrigger = widget.trigger == 1;

    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                partsOfDayItem.isOpen = !partsOfDayItem.isOpen;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18.5),
              child: SizedBox(
                height: partsOfDayItem.title.length > 20 ? 100 : 56,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      helper.getHierarchyIconPath(
                          index: index, lastIndex: lastIndex),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  partsOfDayItem.isOpen
                                      ? constants.Assets.arrowTop
                                      : constants.Assets.arrowBottom,
                                  color: constants.Colors.purple,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    partsOfDayItem.title,
                                    style: constants.Styles.robotoDarkS16W700,
                                    maxLines: 4,
                                  ),
                                ),
                                isFirstTrigger
                                    ? const SizedBox()
                                    : const Expanded(child: SizedBox()),
                                const CustomCheckboxWidget(),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Container(
                              height: 1,
                              color: constants.Colors.greyLight,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (partsOfDayItem.isOpen && partsOfDayItem.tasksList.isNotEmpty) ...[
            for (var i = 0; i < partsOfDayItem.tasksList.length; i++) ...[
              _nonExpansionItem(
                title: partsOfDayItem.tasksList[i].title,
                textStyle: constants.Styles.robotoDarkS16W400,
                index: i,
                lastIndex: partsOfDayItem.tasksList.length - 1,
                isTask: true,
                isFirstTrigger: isFirstTrigger,
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _nonExpansionItem({
    required String title,
    required TextStyle textStyle,
    required int index,
    required int lastIndex,
    bool isTask = false,
    bool isFirstTrigger = false,
  }) {
    final helper = GetIt.I<TriggerListHelper>();

    return Container(
      height: title.length > 20 ? 100 : 56,
      color: constants.Colors.white,
      padding: const EdgeInsets.only(left: 18.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isTask
              ? Padding(
                  padding: const EdgeInsets.only(left: 3, right: 18),
                  child: SvgPicture.asset(
                    constants.Assets.hierarchyLineIcon,
                  ),
                )
              : const SizedBox(),
          SvgPicture.asset(
            helper.getHierarchyIconPath(index: index, lastIndex: lastIndex),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: textStyle,
                        ),
                      ),
                      isFirstTrigger
                          ? const SizedBox()
                          : const Expanded(child: SizedBox()),
                      const CustomCheckboxWidget(),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                // element bottom border
                index != lastIndex
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 1,
                          color: constants.Colors.greyLight,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
