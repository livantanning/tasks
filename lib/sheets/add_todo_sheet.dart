import 'package:flutter/material.dart';
import '../models/todo_entity.dart';

Future<ToDoEntity?> showAddToDoSheet(BuildContext context) {
  return showModalBottomSheet<ToDoEntity>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _AddToDoSheet(),
  );
}

class _AddToDoSheet extends StatefulWidget {
  const _AddToDoSheet();

  @override
  State<_AddToDoSheet> createState() => _AddToDoSheetState();
}

class _AddToDoSheetState extends State<_AddToDoSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _titleFocus = FocusNode();

  bool _showDescription = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState(); // 4-1 BottomSheet 뜰 때 키보드 자동 + title에 focus
    WidgetsBinding.instance.addPostFrameCallback((_) => _titleFocus.requestFocus());
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  void saveToDo() {
    final title = _titleController.text.trim();
    if (title.isEmpty) { // 4-1 단 title 비면 저장 안 됨
      return;
    }

    final desc = _descController.text.trim();
    final todo = ToDoEntity(
      title: title,
      description: desc.isEmpty ? null : desc,
      isFavorite: _isFavorite,
      isDone: false,
    );

    Navigator.of(context).pop(todo); // 저장 시 ToDo 객체 반환하고 닫기 Navigator.pop()
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    final hasTitle = _titleController.text.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: keyboard),
      // 4-1 bottomsheet의 (좌,우 패딩 20, 위 12, 하단 패딩 0 )
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              focusNode: _titleFocus,
              autofocus: true,
              style: const TextStyle(fontSize: 16), // 4-1 텍스트 사이즈 16
              decoration: const InputDecoration(
                hintText: "새 할 일", // 4-1 ToDo title 입력용 + hint “새 할 일”
                border: InputBorder.none,
              ),
              onSubmitted: (_) => saveToDo(), // 4-1 title 입력창에서 엔터=저장(saveToDo)
            ),

            Divider(height: 1, color: Colors.grey.withValues(alpha: 64)),

            Row(
              children: [
                if (!_showDescription) // 4-2 title 밑 Row에 아이콘 2개
                // 4-2 설명 아이콘 누르면 description TextField 보여주기 + 설명 아이콘 숨기기
                  IconButton(
                    icon: const Icon(Icons.short_text_rounded, size: 24), // 4-2 설명 
                    onPressed: () => setState(() => _showDescription = true),
                  ),
                IconButton(
                  icon: Icon(_isFavorite ? Icons.star : Icons.star_border, size: 24), // 4-2 즐겨찾기
                  onPressed: () => setState(() => _isFavorite = !_isFavorite), // bool 값을 이용 하여 즐겨찾기 상태에 따라 내부가 차있거나 라인만 있는 상태 구현
                ),
                const Spacer(),
                TextButton(
                  onPressed: hasTitle ? saveToDo : null, // 저장 버튼: title 있을 때만 활성화(색상 차이)
                  child: Text(
                    "저장",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hasTitle ? null : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            if (_showDescription) // 4-2 설명 아이콘 누르면 description TextField 보여주기 + 설명 아이콘 숨기기
              Row(
                children: [
                  Expanded( // 4-3 줄바꿈 가능 + view 깨지지 않게 expanded로 감싸기
                    child: TextField(
                      controller: _descController,
                      maxLines: null,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: "세부정보 추가",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
