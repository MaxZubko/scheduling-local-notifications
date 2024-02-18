class TriggerModel {
  final String title;
  final bool isExpansion;
  final List<PartsOfDayModel> partsOfDayList;
  bool isOpen;

  TriggerModel({
    required this.title,
    required this.isExpansion,
    required this.partsOfDayList,
    this.isOpen = false,
  });

  static List<TriggerModel> triggerListGeneration({
    required bool isFirstTrigger,
  }) {
    List<TriggerModel> triggerItems = [];

    List<String> categories = [
      'Sport',
      'Work',
      '⏰ Alarm',
      '🎉 Party',
      '🍜 Dinner'
    ];

    List<String> sportMorningActivities = [
      '🚴 Biking',
      '🏃 Running',
    ];
    List<String> sportEveningActivities = [
      isFirstTrigger
          ? '🏓 Some very long names of action with many symbols in two, three, or four lines with text; the limit should be four lines.'
          : '🏓 Ping Pong',
      '🏐 Volleyball',
    ];
    List<String> workActivities = ['🗓️ Meeting', '🖨️ Print document'];

    // Add categories to the triggerItems list
    for (var category in categories) {
      // Determine if this is a category
      bool isExpansion = (category == 'Sport' || category == 'Work');
      List<PartsOfDayModel> partsOfDayList = [];

      if (category == 'Sport') {
        partsOfDayList.add(
          PartsOfDayModel(
            title: isFirstTrigger
                ? 'Some very long names of action with many symbols in two, three, or four lines with text; the limit should be four lines.'
                : 'Morning',
            isExpansion: true,
            tasksList: sportMorningActivities
                .map((activity) => TasksModel(title: activity))
                .toList(),
          ),
        );

        partsOfDayList.add(
          PartsOfDayModel(
            title: 'Evening',
            isExpansion: true,
            tasksList: sportEveningActivities
                .map((activity) => TasksModel(title: activity))
                .toList(),
          ),
        );

        partsOfDayList.add(
          PartsOfDayModel(
            title: '🥊  Boxing',
            isExpansion: false,
            tasksList: [],
          ),
        );

        partsOfDayList.add(
          PartsOfDayModel(
            title: '⚽  Football',
            isExpansion: false,
            tasksList: [],
          ),
        );
      } else if (category == 'Work') {
        partsOfDayList.addAll(
          workActivities
              .map((activity) => PartsOfDayModel(
                    title: activity,
                    isExpansion: false,
                    tasksList: [],
                  ))
              .toList(),
        );
      } else {
        partsOfDayList.add(PartsOfDayModel(
            title: category, isExpansion: false, tasksList: []));
      }

      triggerItems.add(
        TriggerModel(
          title: category,
          isExpansion: isExpansion,
          partsOfDayList: partsOfDayList,
        ),
      );
    }

    return triggerItems;
  }
}

class PartsOfDayModel {
  final String title;
  final bool isExpansion;
  final List<TasksModel> tasksList;
  bool isOpen;

  PartsOfDayModel({
    required this.title,
    required this.isExpansion,
    required this.tasksList,
    this.isOpen = false,
  });
}

class TasksModel {
  final String title;

  TasksModel({
    required this.title,
  });
}
