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

class DayAfterTomorrowList extends ConsumerWidget {
  const DayAfterTomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    // var colors = ref.read(todoStateProvider.notifier).getRandomColor();
    Color color = AppConsts.kYellow;

    String dayafter = ref.read(todoStateProvider.notifier).getDayAfter();
    var tomorrowstask =
        todos.where((element) => element.date!.contains(dayafter));
    return XpansionTile(
        text: DateTime.now()
            .add(const Duration(days: 2))
            .toString()
            .substring(0, 10),
        text2: "Tomorrow's Task are shown here",
        onExpansionchanged: (bool expanded) {
          ref.read(xpansionState0Provider.notifier).setStart(expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionState0Provider)
              ? const Icon(
                  AntDesign.closecircleo,
                  color: AppConsts.kBlueLight,
                )
              : const Icon(
                  AntDesign.circledown,
                  color: AppConsts.kLight,
                ),
        ),
        children: [
          for (final todo in tomorrowstask)
            TodoTile(
              title: todo.title,
              description: todo.desc,
              start: todo.startTime,
              color: color,
              end: todo.endTime,
              marker: "UpComing",
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
