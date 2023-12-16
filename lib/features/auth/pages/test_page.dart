import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';
import 'package:themanager/features/auth/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReuseableText(
                text: code, style: appstyle(30, Colors.white, FontWeight.bold)),
            TextButton(
                onPressed: () {
                  ref
                      .read(codeStateProvider.notifier)
                      .setstart("Hello SHahmeer");
                },
                child: Text("Press me"))
          ],
        ),
      ),
    );
  }
}
