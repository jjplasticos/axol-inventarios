import 'package:axol_inventarios/utilities/theme.dart';
import 'package:flutter/material.dart';

class DrawerBox extends StatelessWidget {
  final double? width;
  final List<Widget>? children;
  final List<Widget>? actions;
  final Widget? header;
  final Widget? child;

  const DrawerBox(
      {super.key,
      this.width,
      this.children,
      this.header,
      this.actions,
      this.child});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double drawerWidth;
    final List<Widget> drawerContent;
    final List<Widget> drawerActions;
    final Widget drawerHead;
    if (width == null) {
      drawerWidth = screenWidth * 0.5;
    } else if (width! <= 1 && width! > 0) {
      drawerWidth = screenWidth * width!;
    } else {
      drawerWidth = screenWidth * 0.5;
    }
    if (children == null) {
      drawerContent = [];
    } else {
      drawerContent = children!;
    }
    if (header == null) {
      drawerHead = const Text('');
    } else {
      drawerHead = header!;
    }
    if (actions != null) {
      drawerActions = actions!;
    } else {
      drawerActions = [];
    }
    if (child == null) {
      return Row(
        children: [
          const Expanded(child: SizedBox()),
          Container(
            color: ColorPalette.lightBackground,
            width: drawerWidth,
            height: screenHeight,
            child: Column(
              children: [
                drawerHead,
                Expanded(child: ListView(children: drawerContent)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: drawerActions,
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          const Expanded(child: SizedBox()),
          Container(
            color: ColorPalette.lightBackground,
            width: drawerWidth,
            height: screenHeight,
            child: Column(
              children: [
                drawerHead,
                child!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: drawerActions,
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
