import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:picto_widget/picto_widget.dart';

class MemoryPictoWidget extends StatefulWidget {
  final Picto picto;
  final bool show;

  final void Function(AnimationController) onTap;

  const MemoryPictoWidget({super.key, required this.picto, this.show = true, required this.onTap});

  @override
  State<MemoryPictoWidget> createState() => _MemoryPictoWidgetState();
}

class _MemoryPictoWidgetState extends State<MemoryPictoWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        print(_animation.value);
        return Transform(
          transform: Matrix4.identity()..rotateY(_animation.value),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: PictoWidget(
        onTap: () {
          widget.onTap.call(_controller);
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
    );
  }
}
