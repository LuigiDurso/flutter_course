import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Center(
        child: Container(
          height: 2,
          margin: const EdgeInsetsDirectional.only(
            start: 60,
            end: 60,
          ),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              color: Colors.grey,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
              )
          ),
        ),
      ),
    );
  }
}
