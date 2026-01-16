import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final list = PortfolioData.projects;
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final titleFontSize = isMobile ? 20.0 : (isTablet ? 23.0 : 26.0);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);
    final mainAxisExtent = isMobile ? 280.0 : (isTablet ? 300.0 : 310.0);
    final spacing = isMobile ? 10.0 : (isTablet ? 12.0 : 14.0);
    final titleSpacing = isMobile ? 12.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Projects",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: titleSpacing),

        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final p = list[i];
            final isMobileCard = mq.width <= 600;
            final titleSize = isMobileCard ? 13.0 : 15.0;
            final descSize = isMobileCard ? 12.0 : 13.0;
            final hPadding = isMobileCard ? 10.0 : 12.0;
            final imagHeight = isMobileCard ? 120.0 : 150.0;

            return _ScrollAnimatedCard(
              delay: i * 150,
              child: _AnimatedHoverCard(
                onTap: () => _open(p.url),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: imagHeight,
                      child: _VideoOrImageWithControls(
                        project: p,
                        onExpand: () => _showMediaDialog(context, p),
                      ),
                    ),
                    SizedBox(height: isMobileCard ? 6 : 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPadding),
                      child: Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobileCard ? 3 : 4),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPadding),
                      child: Text(
                        p.description,
                        maxLines: isMobileCard ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: descSize, color: Colors.grey[300]),
                      ),
                    ),

                    SizedBox(height: isMobileCard ? 8 : 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobileCard ? 8 : 10),
                      child:  Wrap(
                               spacing: isMobileCard ? 4 : 5,
                               runSpacing: isMobileCard ? 4 : 5,
                               children: p.tags
                                  
                                  .map(
                                    (e) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobileCard ? 8 : 10,
                                        vertical: isMobileCard ? 2 : 3,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                            200,
                                            150,
                                            100,
                                            200,
                                          ),
                                          width: 0.8,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: isMobileCard ? 9.0 : 11.0,
                                          color: const Color.fromARGB(
                                            255,
                                            200,
                                            150,
                                            255,
                                          ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                                  ),
                                  ),
                                  SizedBox(height: isMobileCard ? 8 : 10),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showMediaDialog(BuildContext context, Project p) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: p.videoUrl != null && p.videoUrl!.isNotEmpty
                    ? _FullScreenVideoPlayer(videoUrl: p.videoUrl!)
                    : Image.asset(p.image ?? '', fit: BoxFit.contain),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollAnimatedCard extends StatefulWidget {
  final Widget child;
  final int delay;
  const _ScrollAnimatedCard({required this.child, required this.delay});

  @override
  State<_ScrollAnimatedCard> createState() => _ScrollAnimatedCardState();
}

class _ScrollAnimatedCardState extends State<_ScrollAnimatedCard> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          Future.delayed(Duration(milliseconds: widget.delay), () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _visible ? 1 : 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(_visible ? 0 : 60, 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}

class _AnimatedHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedHoverCard({required this.child, required this.onTap});

  @override
  State<_AnimatedHoverCard> createState() => _AnimatedHoverCardState();
}

class _AnimatedHoverCardState extends State<_AnimatedHoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovering
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color:  Color.fromARGB(255, 37, 15, 68),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovering
                ? const Color.fromARGB(255, 150, 100, 200)
                : const Color.fromARGB(100, 150, 100, 200),
            width: _hovering ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? const Color.fromARGB(255, 150, 100, 200).withOpacity(0.4)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _hovering ? 20 : 8,
              spreadRadius: _hovering ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(14),
          child: widget.child,
        ),
      ),
    );
  }
}

class _VideoOrImageWithControls extends StatefulWidget {
  final Project project;
  final VoidCallback onExpand;
  const _VideoOrImageWithControls({
    required this.project,
    required this.onExpand,
  });

  @override
  State<_VideoOrImageWithControls> createState() =>
      _VideoOrImageWithControlsState();
}

class _VideoOrImageWithControlsState extends State<_VideoOrImageWithControls> {
  VideoPlayerController? _controller;
  bool initialized = false;
  bool playing = false;
  double speed = 1.0;

  @override
  void initState() {
    super.initState();
    final v = widget.project.videoUrl;

    if (v != null && v.isNotEmpty) {
      _controller = v.startsWith("http")
          ? VideoPlayerController.network(v)
          : VideoPlayerController.asset(v);

      _controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() => initialized = true);
        _controller!.setLooping(true);
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!initialized) return;
    setState(() {
      if (playing) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      playing = !playing;
    });
  }

  void _changeSpeed() {
    if (!initialized) return;

    setState(() {
      speed = speed == 1.0
          ? 1.5
          : speed == 1.5
          ? 2.0
          : 1.0;
      _controller!.setPlaybackSpeed(speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final hasVideo =
        widget.project.videoUrl != null && widget.project.videoUrl!.isNotEmpty;

    final buttonSize = isMobile ? 30.0 : 35.0;
    final iconSize = isMobile ? 18.0 : 24.0;
    final playIconSize = isMobile ? 48.0 : 60.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: hasVideo ? _togglePlay : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: !hasVideo
                  ? Image.asset(widget.project.image!, fit: BoxFit.cover)
                  : !initialized
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_controller!),
                        if (!playing)
                          Icon(
                            Icons.play_circle_fill,
                            size: playIconSize,
                            color: Colors.white,
                          ),
                      ],
                    ),
            ),
          ),
        ),

        /// SHOW CONTROLS ONLY IF VIDEO EXISTS
        if (hasVideo) ...[
          Positioned(
            left: isMobile ? 4 : 8,
            bottom: isMobile ? 4 : 8,
            child: IconButton(
              icon: Icon(
                playing ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: iconSize,
              ),
              onPressed: _togglePlay,
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: EdgeInsets.zero,
                minimumSize: Size(buttonSize, buttonSize),
              ),
            ),
          ),

          Positioned(
            left: isMobile ? 40 : 50,
            bottom: isMobile ? 4 : 8,
            child: TextButton(
              onPressed: _changeSpeed,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6 : 8,
                  vertical: isMobile ? 2 : 4,
                ),
              ),
              child: Text(
                '${speed}x',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 11.0 : 12.0,
                ),
              ),
            ),
          ),
        ],
        Positioned(
          right: isMobile ? 4 : 8,
          bottom: isMobile ? 4 : 8,
          child: IconButton(
            icon: Icon(Icons.fullscreen, color: Colors.white, size: iconSize),
            onPressed: widget.onExpand,
            style: IconButton.styleFrom(
              backgroundColor: Colors.black54,
              padding: EdgeInsets.zero,
              minimumSize: Size(buttonSize - 2, buttonSize - 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const _FullScreenVideoPlayer({required this.videoUrl});

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.videoUrl.startsWith("http")
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.asset(widget.videoUrl);

    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(
          () => _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play(),
        );
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
