import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/features/todo/controllers/todo/todo_provider.dart';
import 'package:themanager/features/todo/widgets/todo_tile.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/edit_task.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    // var colors = ref.watch(todoStateProvider.notifier).getRandomColor();
              Color color = AppConsts.kGreen;


    String tomorrow = ref.read(todoStateProvider.notifier).geTomrrow();
    var tomorrowstask =
        todos.where((element) => element.date!.contains(tomorrow));
    return XpansionTile(
        text: "Tomorrow's Task",
        text2: "Tomorrow's Task are shown here",
        onExpansionchanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? Icon(
                  AntDesign.closecircleo,
                  color: AppConsts.kBlueLight,
                )
              : Icon(
                  AntDesign.circledown,
                  color: AppConsts.kLight,
                ),
        ),
        children: [
          for (final todo in tomorrowstask)
            TodoTile(
              title: todo.title,
              marker: 'Upcoming',
              description: todo.desc,
              start: todo.startTime,
              color: color,
              end: todo.endTime,
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id!);
              },
              editWidget: GestureDetector(
                child: Icon(MaterialCommunityIcons.circle_edit_outline),
                onTap: () {
                  titles = todo.title.toString();
                  descs = todo.desc.toString();
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTask(id: todo.id ?? 0)));
                },
              ),
              switcher: SizedBox.shrink(),
            )
        ]);
  }
}
