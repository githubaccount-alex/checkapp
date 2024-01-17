import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/paths.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      showAppbar: true,
      appbarTitle: "Error",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 60,
              color: Colors.pink[400],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
