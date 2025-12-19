import 'package:flutter/material.dart';
import 'package:tasks/todo_detatil_page.dart';
import 'models/todo_entity.dart';
import 'widgets/no_todo_view.dart';
import 'widgets/todo_view.dart';
import 'sheets/add_todo_sheet.dart';

class HomePage extends StatefulWidget { // 1-2 초기 화면 이름 HomePage
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDoEntity> todos = [];
  final String appBarTitle = "성중's Tasks"; // 3-1 타이틀에 수강생 이름 넣기

  Future<void> addTodo() async {
    final todo = await showAddToDoSheet(context);
    if (todo == null) return;
    setState(() => todos.add(todo));
  }

  void toggleDone(int index) { // 5-1 Icon(circle & check_circle): 버튼 눌리면 Done 상태 변경
    final t = todos[index];
    setState(() => todos[index] = t.copyWith(isDone: !t.isDone));
  }

  void toggleFavorite(int index) { // 5-1 Icon(star & star_border): Favorite 상태 변경
    final t = todos[index];
    setState(() => todos[index] = t.copyWith(isFavorite: !t.isFavorite));
  }

  void deleteTodo(int index) {
  setState(() => todos.removeAt(index));
}

  Future<void> openDetail(int index) async {
    final updated = await Navigator.of(context).push<ToDoEntity>(
      MaterialPageRoute(builder: (_) => ToDoDetailPage(todo: todos[index])),
    );
    if (updated == null) return;
    setState(() => todos[index] = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),
      resizeToAvoidBottomInset: false, // 4-4 Scaffold의 resizeToAvoidBottomInset을 사용하여,
// 키보드 노출과 무관하게 FloatingActionButton의 위치가 변하지 않게 만들기
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold // 3-1 앱바 타이틀에 사이즈20, 볼드체 적용하기
            ),
        ),
      ),
      body:
          todos.isEmpty // 5-1 ToDo가 없을 때는 NoToDo
              ? NoToDoView(
                appBarTitle: appBarTitle,
                imageAssetPath: "assets/images/Tasklogo.webp",
              )
              : ListView.builder( // 5-1 ToDo가 있을 때는 ListView로 ToDoView
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ToDoView( 
                    todo: todos[index], // 5-1 ToDoEntity를 인자로 받는 ToDoView 위젯 만들기
                    onToggleDone: () => toggleDone(index), // 5-1 VoidCallback을 인자로 받으세요
                    onToggleFavorite: () => toggleFavorite(index), // 5-1 VoidCallback을 인자로 받으세요
                    onTap: () => openDetail(index), // 5-1 VoidCallback을 인자로 받으세요
                    onDelete: () => deleteTodo(index),
                    // 6-1 뒤로 간 페이지 반영 = pop(_todo)로 업데이트된 todo를 돌려줌 
                    // 6-1 home_page.dart의 openDetail()이 그 값을 받아서 리스트를 업데이트
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        backgroundColor: const Color.fromARGB(255, 255, 17, 0), // 3-3 배경은 원하는 색상(빨간색)
        shape: const CircleBorder(), // 3-3 버튼 모양은 원형
        child: const Icon(Icons.add, color: Colors.white, size: 24),
        // 3-3 아이콘은 흰색, 사이즈 24,
      ),
    );
  }
}
