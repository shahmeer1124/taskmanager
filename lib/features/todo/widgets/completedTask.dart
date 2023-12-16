import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastmonth = ref.read(todoStateProvider.notifier).last30days();
    var completedList = listData
        .where((element) =>
            element.isCompleted == 1 ||lastmonth.contains(element.date!.substring(0,10)) )
        .toList();

    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final data = completedList[index];
          
          // dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
              Color color = AppConsts.kGreyDark;

          return TodoTile(
            editWidget:const SizedBox.shrink(),
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(data.id!);
            },
            title: data.title,
            description: data.desc,
            start: data.startTime,
            end: data.endTime,
            color: color,
            marker: 'Completed',
            switcher: Icon(AntDesign.checkcircle,color: AppConsts.kGreen,),
          );
        });
  }
}
