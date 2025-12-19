import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

class ToDoView extends StatelessWidget {
  final ToDoEntity todo; // 5-1 ToDoEntity를 인자로 받는 ToDoView 위젯 만들기
  final VoidCallback onToggleDone;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ToDoView({
    super.key,
    required this.todo,
    required this.onToggleDone,
    required this.onToggleFavorite,
    required this.onTap,
    required this.onDelete, // 삭제 기능 추가
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      decoration:
          todo.isDone
              ? TextDecoration.lineThrough
              : null, // 5-1 텍스트(title): Done이면 취소선
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // 5-1 마진 수직 8
      padding: const EdgeInsets.symmetric(horizontal: 16), // 5-1 패딩 수평 16
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // 5-1 라운딩 12
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(
                // // 5-1 Icon(circle & check_circle): 버튼 눌리면 Done 상태 변경
                onPressed: onToggleDone,
                icon: Icon(
                  todo.isDone ? Icons.check_circle : Icons.circle_outlined,
                ),
              ),
              const SizedBox(width: 12), // 5-1 요소 간 간격 12
              Expanded(
                child: Text(
                  todo.title,
                  style: titleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12), // 5-1 요소 간 간격 12
              IconButton(
                // // 5-1 Icon(star & star_border): Favorite 상태 변경
                onPressed: onToggleFavorite,
                icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
              ),
              IconButton( // 삭제 기능 추가
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog( // 삭제 확인 기능 추가
                          title: const Text("삭제할까요?"),
                          content: const Text("삭제한 목록은 복구 되지 않습니다."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("취소"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("삭제",
                                style: TextStyle(
                                color: Colors.redAccent
                                ),
                              ), 
                            ),
                          ],
                        ),
                  );

                  if (ok == true) onDelete();
                },
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent, // 휴지통 색상

              ),
            ],
          ),
        ),
      ),
    );
  }
}
