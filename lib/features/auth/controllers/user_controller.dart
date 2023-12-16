import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/models/user_model.dart';

import '../../../common/helper/db_helper.dart';

final userProvider = StateNotifierProvider<UserState, List<UserModel>>((ref) {
 return UserState();
});

class UserState extends StateNotifier<List<UserModel>>{
  UserState():super([]);
  void refresh()async{
    final data=await DBHelper.getUsers();
    state=data.map((e)=>UserModel.fromJson(e)).toList();
  }
}
