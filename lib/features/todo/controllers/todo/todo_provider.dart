import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:themanager/common/helper/db_helper.dart';
import 'package:themanager/common/models/task_model.dart';

import '../../../../common/utils/constants.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  void UpdateItem(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DBHelper.updateItem(
        id, title, desc, isCompleted, date, startTime, endTime);
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DBHelper.deleteitem(id);
    refresh();
  }

  void markAsCompleted(int id, String title, String desc, int isCompleted,
      String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id, title, desc, 1, date, startTime, endTime);
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  String geTomrrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(Duration(days: 30));
    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? iscompleted;
    if (data.isCompleted == 0) {
      iscompleted = false;
    } else {
      iscompleted = true;
    }
    return iscompleted;
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

String getDayAfter() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 2));
    return tomorrow.toString().substring(0, 10);
  }



}
