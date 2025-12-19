import 'package:flutter/material.dart';
import 'models/todo_entity.dart';

class ToDoDetailPage extends StatefulWidget {
  // 1-3 To Do의 상세 내역 화면의 이름은 ToDoDetailPage
  final ToDoEntity todo; // 6-2 ToDoEntity를 받아서 화면 컨텐츠 채우기, ToDoEntity를 받는 부분

  const ToDoDetailPage({super.key, required this.todo});
  // 6-2 ToDoEntity를 받아서 화면 컨텐츠 채우기, ToDoEntity를 받는 부분

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  late ToDoEntity _todo; /// 6-2 ToDoEntity를 받아서 화면 컨텐츠 채우기, 받은 todo를 화면에서 쓸수 있도록 복사 해서 저장

  @override
  void initState() {
    super.initState();
    _todo = widget.todo;
  } /// 6-2 ToDoEntity를 받아서 화면 컨텐츠 채우기, 받은 todo를 화면에서 쓸수 있도록 복사 해서 저장

  void toggleFavorite() { // 6-1 favorite 변경 구현
    setState(() { // 6-1 favorite 변경 구현 : 별 모양 즉시 변경
      _todo = _todo.copyWith(isFavorite: !_todo.isFavorite);
    });
  }

  void goBack() { // 6-1 back button 통해서 뒤로가기 구현, pop(_todo)로 업데이트 된 todo 돌려줌
    Navigator.of(context).pop(_todo); // 변경된 값 반환 
  }

  @override
  Widget build(BuildContext context) {
    final desc = (_todo.description == null || _todo.description!.trim().isEmpty)
        ? "세부정보가 없습니다."
        : _todo.description!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: goBack), // 6-1 AppBar에 leading 사용하기
        title: const Text("To Do Detail"),
        actions: [ // // 6-1 AppBar에 actions 사용하기
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(_todo.isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _todo.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(desc, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
