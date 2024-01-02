import 'package:flenex/flenex.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:iara/ui/screens/home/controllers/home_controller.dart';
import 'package:iara/utils/theme.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../intl/lang_constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();
  final _appTheme = Get.find<AppTheme>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.errorCallback = showAlertError;
  }

  Future<void> showAlertError(String errorMessage) async {
    await displayInfoBar(context, builder: (context, close) {
       return InfoBar(
        title: Text(LangConstants.error.tr),
        content: Text(errorMessage),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.error,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 600;
            return GetBuilder<HomeController>(
              builder: (_) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: <Widget>[
                        // Seus primeiros três widgets
                        SizedBox(
                          child: InfoLabel(
                            label: _controller.lenex?.meets?.first.name ?? 'Nadswy lenex',
                            child: ComboBox<Meet?>(
                              value: _controller.meetSelected ,
                              items: _controller.lenex?.meets?.map((e) => ComboBoxItem<Meet?>(value: e, child: Text(e.name))).toList() ?? [],
                              onChanged: (item) {
                                _controller.setMeet(item  );
                              },

                            ),
                          ),
                        ) ,

                      ],
                    ),
                    20.heightBox,

                  ],
                );
              },
            );
          },
        ).expand(),

        // Adicione outros widgets conforme necessário
      ],
    );
  }


}

// Inclua outras classes ou widgets auxiliares conforme necessário
