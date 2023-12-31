import 'package:fluent_ui/fluent_ui.dart';
import 'package:logger/logger.dart';
import 'package:velocity_x/velocity_x.dart';


class TerminalWidget extends StatefulWidget {
  String onTextEntered;
  TerminalWidget({super.key, required this.onTextEntered });

  @override
  _TerminalWidgetState createState() => _TerminalWidgetState();
}

class _TerminalWidgetState extends State<TerminalWidget> {
  final _scrollController = ScrollController();
  double _logFontSize = 14;
  bool _followBottom = true;
  bool _scrollListenerEnabled = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

    Logger().d('initState called');
    _scrollController.addListener(() {
      if (!_scrollListenerEnabled) return;
      var scrolledToBottom = _scrollController.offset >=
          _scrollController.position.maxScrollExtent;
      setState(() {
        _followBottom = scrolledToBottom;
      });
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Logger().d('didChangeDependencies called');
    if (_followBottom) {
      Future.delayed(Duration.zero, _scrollToBottom);
    }
  }

  void _scrollToBottom() async {
    _scrollListenerEnabled = false;

    setState(() {
      _followBottom = true;
    });

    var scrollPosition = _scrollController.position;
    await _scrollController.animateTo(
      scrollPosition.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    _scrollListenerEnabled = true;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFF0B0F2A),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child:widget.onTextEntered.text.sm.color(Color(0xFFF1A700)).make(),
      ),
    );
  }
}
