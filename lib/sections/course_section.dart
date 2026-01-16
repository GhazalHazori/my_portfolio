import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/animated_card.dart';
import 'package:video_player/video_player.dart';
import '../data.dart';

class AnimatedHoverCourseCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedHoverCourseCard({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  State<AnimatedHoverCourseCard> createState() =>
      _AnimatedHoverCourseCardState();
}

class _AnimatedHoverCourseCardState extends State<AnimatedHoverCourseCard> {
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

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final list = PortfolioData.courses;
    final mq = MediaQuery.of(context).size;
    final isMobile = mq.width <= 600;
    final isTablet = mq.width > 600 && mq.width <= 1200;

    final titleFontSize = isMobile ? 20.0 : (isTablet ? 23.0 : 26.0);
    final crossAxisCount = isMobile ? 1 : 2;
    final mainAxisExtent = isMobile ? 280.0 : (isTablet ? 290.0 : 300.0);
    final spacing = isMobile ? 10.0 : (isTablet ? 12.0 : 14.0);
    final titleSpacing = isMobile ? 12.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Courses",
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
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, i) {
            final c = list[i];
            final isMobileCard = mq.width <= 600;
            final cardTitleSize = isMobileCard ? 14.0 : 16.0;
            final cardDescSize = isMobileCard ? 12.0 : 13.0;
            final hPadding = isMobileCard ? 10.0 : 12.0;
            final imagHeight = isMobileCard ? 120.0 : 150.0;

            return ScrollAnimatedCard(
              delay: i * 150,
              child: AnimatedHoverCourseCard(
                onTap: () {
                  _showCourseDialog(context, c);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: imagHeight,
                      child: _VideoOrImageWithControls(
                        project: Project(
                          title: c.title,
                          description: c.description,
                          image: c.image,
                          videoUrl: c.videoUrl,
                          tags: [],
                          url: "",
                        ),
                        onExpand: () {
                          _showCourseDialog(context, c);
                        },
                      ),
                    ),
                    SizedBox(height: isMobileCard ? 6 : 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPadding),
                      child: Text(
                        c.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cardTitleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobileCard ? 3 : 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPadding),
                      child: Text(
                        c.description,
                        maxLines: isMobileCard ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[300], fontSize: cardDescSize),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showCourseDialog(BuildContext context, Course c) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: c.videoUrl != null && c.videoUrl!.isNotEmpty
                    ? _FullScreenVideoPlayer(videoUrl: c.videoUrl!)
                    : _buildFullImage(c.image ?? ''),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFullImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.white, size: 64),
            ),
          );
        },
      );
    } else if (imagePath.isNotEmpty) {
      return Image.asset(imagePath, fit: BoxFit.contain);
    }
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.white, size: 64),
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

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.white),
            ),
          );
        },
      );
    } else {
      return Image.asset(imagePath, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasVideo =
        widget.project.videoUrl != null && widget.project.videoUrl!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: hasVideo ? _togglePlay : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: !hasVideo
                  ? _buildImage(widget.project.image!)
                  : !initialized
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_controller!),
                        if (!playing)
                          const Icon(
                            Icons.play_circle_fill,
                            size: 60,
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
            left: 8,
            bottom: 8,
            child: IconButton(
              icon: Icon(
                playing ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: _togglePlay,
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: EdgeInsets.zero,
                minimumSize: const Size(35, 35),
              ),
            ),
          ),

          Positioned(
            left: 50,
            bottom: 8,
            child: TextButton(
              onPressed: _changeSpeed,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Text(
                '${speed}x',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        Positioned(
          right: 8,
          bottom: 8,
          child: IconButton(
            icon: const Icon(Icons.fullscreen, color: Colors.white, size: 24),
            onPressed: widget.onExpand,
            style: IconButton.styleFrom(
              backgroundColor: Colors.black54,
              padding: EdgeInsets.zero,
              minimumSize: const Size(32, 32),
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
