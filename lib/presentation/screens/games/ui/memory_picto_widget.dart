import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:picto_widget/picto_widget.dart';

class MemoryPictoWidget extends StatefulWidget {
  final Picto picto;

  final void Function() onTap;

  final void Function(AnimationController) onBuild;

  final bool isSelected;
  final bool isVisible;
  final bool? isRight;

  const MemoryPictoWidget({
    super.key,
    required this.picto,
    required this.isSelected,
    this.isVisible = false,
    this.isRight,
    required this.onTap,
    required this.onBuild,
  });

  @override
  State<MemoryPictoWidget> createState() => _MemoryPictoWidgetState();
}

class _MemoryPictoWidgetState extends State<MemoryPictoWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void initState() {
    widget.onBuild(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.reverse();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..rotateY(widget.isVisible
                  ? 0
                  : widget.isSelected
                      ? _animation.value * 3.14
                      : (_animation.value * 3.14 * 2)),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (widget.isRight != null && widget.isSelected)
              Container(
                width: 96 + 8,
                height: 119 + 8,
                decoration: BoxDecoration(
                  color: widget.isRight! ? const Color(0xff3CD039) : const Color(0xffFF0000),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            (widget.isSelected || widget.isVisible)
                ? Center(
                    child: PictoWidget(
                      onTap: () {
                        //TODO: Maybe should talk the picto
                      },
                      image: widget.picto.resource.network != null
                          ? CachedNetworkImage(
                              imageUrl: widget.picto.resource.network!,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Image.asset(
                                fit: BoxFit.fill,
                                "assets/img/${widget.picto.text}.webp",
                              ),
                            )
                          : Image.asset(
                              fit: BoxFit.fill,
                              "assets/img/${widget.picto.text}.webp",
                            ),
                      text: widget.picto.text,
                      colorNumber: widget.picto.type,
                      width: 96,
                      height: 119,
                    ),
                  )
                : GestureDetector(
                    onTap: widget.onTap,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        width: 96,
                        height: 119,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: colorScheme.primary, width: 4),
                        ),
                        padding: const EdgeInsets.all(0.5),
                        child: Center(
                          child: Image.asset(
                            AppImages.kGamesMark,
                            height: 46,
                            width: 46,
                          ),
                        ),
                      ),
                    ),
                  ),
            if (widget.isRight != null && widget.isSelected)
              Positioned(
                right: -10,
                top: -10,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: widget.isRight! ? const Color(0xff3CD039) : Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      widget.isRight! ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
