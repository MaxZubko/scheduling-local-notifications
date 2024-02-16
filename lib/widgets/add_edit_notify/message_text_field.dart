import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class MessageTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() onChanged;
  const MessageTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Message',
          style: constants.Styles.robotoDarkS14W500,
        ),
        const SizedBox(height: 6),
        _bigTextField(context),
      ],
    );
  }

  Widget _bigTextField(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              _isFocused ? constants.Colors.purple : constants.Colors.greyLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLines: 10,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: 'Enter message',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: constants.Styles.robotoGreyS16W400,
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) => widget.onChanged(),
      ),
    );
  }
}
