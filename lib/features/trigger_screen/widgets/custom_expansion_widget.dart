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
  late TriggerModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    // sport, work
    return _expansionCard(
      onOpen: () {
        setState(() {
          item.isOpen = !item.isOpen;
        });
      },
      isOpen: item.isOpen,
      title: item.title,
      isFirstTriggers: true,
      childrenList: _buildChildrenList(item),
    );
  }

  List<Widget> _buildChildrenList(TriggerModel item) {
    return item.partsOfDayList.isNotEmpty
        ? [
            for (int i = 0; i < item.partsOfDayList.length; i++) ...[
              _buildPartOfDay(item.partsOfDayList[i], i),
            ],
          ]
        : [];
  }

  Widget _buildPartOfDay(PartsOfDayModel partOfDay, int index) {
    return partOfDay.isExpansion
        ? _buildExpansionCardForPartOfDay(partOfDay, index)
        : _buildNonExpansionCardForPartOfDay(partOfDay, index);
  }

  // morning, evening
  Widget _buildExpansionCardForPartOfDay(PartsOfDayModel partOfDay, int index) {
    return _expansionCard(
      onOpen: () {
        setState(() {
          partOfDay.isOpen = !partOfDay.isOpen;
        });
      },
      isOpen: partOfDay.isOpen,
      title: partOfDay.title,
      index: index,
      lastIndex: item.partsOfDayList.length - 1,
      childrenList: [
        if (partOfDay.isOpen && partOfDay.tasksList.isNotEmpty) ...[
          for (var i = 0; i < partOfDay.tasksList.length; i++) ...[
            _buildNonExpansionCardForTasks(
              partOfDay,
              partOfDay.tasksList[i],
              i,
            ),
          ],
        ],
      ],
    );
  }

  // boxing, football, meeting, print document
  Widget _buildNonExpansionCardForPartOfDay(
      PartsOfDayModel partOfDay, int index) {
    return _nonExpansionItem(
      title: partOfDay.title,
      textStyle: constants.Styles.robotoDarkS16W400,
      index: index,
      lastIndex: item.partsOfDayList.length - 1,
    );
  }

  // biking, running, ping pong, volleyball
  Widget _buildNonExpansionCardForTasks(
      PartsOfDayModel partOfDay, TasksModel task, int index) {
    return _nonExpansionItem(
      title: task.title,
      textStyle: constants.Styles.robotoDarkS16W400,
      index: index,
      lastIndex: partOfDay.tasksList.length - 1,
      isTask: true,
    );
  }

  Widget _expansionCard({
    required Function() onOpen,
    required bool isOpen,
    required String title,
    required List<Widget> childrenList,
    int? index,
    int? lastIndex,
    bool isFirstTriggers = false,
  }) {
    final helper = GetIt.I<TriggerListHelper>();
    // final isFirstTrigger = widget.trigger == 1;
    final bool isLongTitle = title.length > 20;

    return Column(
      children: [
        InkWell(
          onTap: () {
            onOpen();
          },
          child: Container(
            height: isLongTitle ? 100 : 57,
            decoration: BoxDecoration(
              border: isFirstTriggers && !isOpen
                  ? const Border(
                      bottom: BorderSide(
                        color: constants.Colors.greyLight,
                      ),
                    )
                  : null,
            ),
            padding: EdgeInsets.only(
              left: isFirstTriggers
                  ? 9
                  : isLongTitle
                      ? 20.3
                      : 21,
            ),
            child: Row(
              children: [
                if (index != null && lastIndex != null)
                  SvgPicture.asset(
                    helper.getHierarchyIconPath(
                      index: index,
                      lastIndex: lastIndex,
                      isLongTitle: isLongTitle,
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          crossAxisAlignment: isLongTitle
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: isLongTitle ? 6 : 0),
                              child: SvgPicture.asset(
                                isOpen
                                    ? constants.Assets.arrowTop
                                    : constants.Assets.arrowBottom,
                                color: constants.Colors.purple,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 10,
                              child: Text(
                                title,
                                style: constants.Styles.robotoDarkS16W700,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            isFirstTriggers
                                ? const SizedBox()
                                : const Expanded(child: SizedBox()),
                            const CustomCheckboxWidget(),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      if ((isOpen && isFirstTriggers) || (!isFirstTriggers))
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Container(
                            height: 1,
                            color: constants.Colors.greyLight,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (item.isOpen)
          Column(
            children: childrenList,
          ),
      ],
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
    final bool isLastItem = !isFirstTrigger && index == lastIndex;
    final bool isLongTitle = title.length > 20;

    return Container(
      height: title.length > 20 ? 100 : 57,
      padding: const EdgeInsets.only(left: 21),
      decoration: BoxDecoration(
        color: constants.Colors.white,
        border: isLastItem && !isTask
            ? const Border(
                bottom: BorderSide(
                  color: constants.Colors.greyLight,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isTask
              ? Padding(
                  padding: const EdgeInsets.only(left: 3, right: 23),
                  child: SvgPicture.asset(
                    isLongTitle
                        ? constants.Assets.hierarchyLongLineIcon
                        : constants.Assets.hierarchyLineIcon,
                  ),
                )
              : const SizedBox(),
          SvgPicture.asset(
            helper.getHierarchyIconPath(
              index: index,
              lastIndex: lastIndex,
              isLongTitle: isLongTitle,
            ),
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
                        flex: 10,
                        child: Text(
                          title,
                          style: textStyle,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      isFirstTrigger ? const SizedBox() : const Spacer(),
                      const SizedBox(width: 5),
                      const CustomCheckboxWidget(),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                // element bottom border
                if ((!isLastItem) || (isTask))
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 1,
                      color: constants.Colors.greyLight,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
