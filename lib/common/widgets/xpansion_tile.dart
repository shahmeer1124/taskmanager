import 'package:flutter/material.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget {
  final String text;
  final String text2;
  final List<Widget> children;
  final Widget? trailing;
  final void Function(bool)? onExpansionchanged;

  const XpansionTile({super.key, required this.text, required this.text2,this.onExpansionchanged,this.trailing,required this.children});
// ref.read(xpansionStateProvider.notifier).setStart(expanded);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConsts.kBKlight,
          borderRadius: BorderRadius.all(Radius.circular(AppConsts.KRadius))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          trailing: trailing,
          title: BottomTitle(
            
            text: text,
            text2: text2,
          ),
          tilePadding: EdgeInsets.zero,
          children: children,
          onExpansionChanged: onExpansionchanged,
        ),
      ),
    );
  }
}


