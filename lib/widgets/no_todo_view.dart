import 'package:flutter/material.dart';

class NoToDoView extends StatelessWidget {
  final String appBarTitle;
  final String imageAssetPath;

  const NoToDoView({
    super.key,
    required this.appBarTitle,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Container(
            width: double.infinity, // 과제 예시와 비슷한 형태로 구현 위해 코드 추가
            margin: const EdgeInsets.symmetric(horizontal: 20), // 3-2 마진 20 적용
            padding: const EdgeInsets.symmetric(horizontal: 20), // 3-2 패딩 20 적용
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // 3-2 백그라운드 컬러 및 테두리 라운딩에 circular(12) 적용하기
              color: Colors.white,
              boxShadow: [ // 3-2 과제에서 그림자 기능 추가
                BoxShadow(
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  color: Colors.black.withValues(alpha: 1),
                ),
              ],
            ),
            child: Column( // 3-2 수직으로 배치
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imageAssetPath, // 3-2 Android Studio 사용하여 png->webp 변환
                width: 100, height: 100), // 3-2 이미지 사이즈 가로,세로 100
                const SizedBox(height: 12),
                const Text(
                  "To Do가 없습니다",
                  style: TextStyle(
                    fontSize: 16, // 3-2 텍스트 사이즈 16
                    fontWeight: FontWeight.bold, // 3-2 볼드체 적용
                    color: Color(0xFF444444),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "$appBarTitle\n새 할 일을 추가해보세요.", // 앱아에 적용한 타이틀을 받아 사용
                  textAlign: TextAlign.center, // 3-2 가운데 정렬
                  style: const TextStyle(
                    fontSize: 14, // 3-2 텍스트 사이즈 14
                    height: 1.5, // 높이 1.5
                    color: Color.fromARGB(255, 47, 47, 47),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
