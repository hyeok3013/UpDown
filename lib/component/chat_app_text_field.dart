import 'package:flutter/material.dart';
import 'package:up_down/theme/colors.dart';

class ChatAppTextField extends StatefulWidget {
  const ChatAppTextField({
    super.key,
    required this.controller,
    required this.onPressed,
  });
  final TextEditingController controller;
  final void Function() onPressed;

  @override
  State<ChatAppTextField> createState() => _ChatAppTextFieldState();
}

class _ChatAppTextFieldState extends State<ChatAppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 4,
      controller: widget.controller,
      onChanged: (value) => setState(() {}),
      // 입력창
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        hintText: '메시지를 입력하세요',
        hintStyle: const TextStyle(color: AppColors.greyColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        // 보내기 버튼
        suffixIcon: Visibility(
          visible: widget.controller.text.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Transform.rotate(
                  angle: -0.5,
                  child: IconButton(
                    onPressed: widget.onPressed,
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 16,
                    ),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.only(bottom: 1),
                      shape: const CircleBorder(),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
