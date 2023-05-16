import 'package:flutter/material.dart';
import 'package:flutter_base/timezone_pub/date_extension.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class TimeZoneSample extends StatelessWidget {
  TimeZoneSample({super.key});

  // タスク作成場所で設定した期限
  final taskCreationLocationDeadLine = DateTime(2023, 5, 16, 20, 30);

  // タスクを作成した場所
  static const taskCreationLocation = 'America/Los_Angeles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日のタスク'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('タスク作成場所：$taskCreationLocation'),
            Text('期限：${taskCreationLocationDeadLine.toFormattedString()}'),
            Expanded(
              child: ListView(
                children: [
                  TaskItem(
                    userName: '山田太郎',
                    taskName: 'アプリアイコンの設定',
                    taskDeadline: taskCreationLocationDeadLine
                        .toTZDateTime(taskCreationLocation),
                    // ユーザーのタイムゾーンを'Asia/Tokyo'とします。
                    location: 'Asia/Tokyo',
                  ),
                  TaskItem(
                    userName: 'アレクサンドル',
                    taskName: 'スプラッシュアイコンの設定',
                    taskDeadline: taskCreationLocationDeadLine
                        .toTZDateTime(taskCreationLocation),
                    // ユーザーのタイムゾーンを'Asia/Vladivostok'とします。
                    location: 'Asia/Vladivostok',
                  ),
                  TaskItem(
                    userName: 'マキシム',
                    taskName: 'チュートリアル画面の作成',
                    taskDeadline: taskCreationLocationDeadLine
                        .toTZDateTime(taskCreationLocation),
                    // ユーザーのタイムゾーンを'Europe/Moscow'とします。
                    location: 'Europe/Moscow',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.userName,
    required this.taskName,
    required this.taskDeadline,
    required this.location,
  });

  final String userName;
  final String taskName;
  final TZDateTime taskDeadline;
  final String location;

  @override
  Widget build(BuildContext context) {
    final userTimeZone = tz.getLocation(location);

    // タスクの期限をユーザーのタイムゾーンに変換。
    final localDeadline = tz.TZDateTime.from(taskDeadline, userTimeZone);

    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('担当者：$userName'),
            Text('タスク名：$taskName'),
          ],
        ),
        subtitle: DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          child: Row(
            children: [
              Text('期限: ${localDeadline.toFormattedString()}'),
              const SizedBox(width: 16),
              Text('場所：$location'),
            ],
          ),
        ),
      ),
    );
  }
}
