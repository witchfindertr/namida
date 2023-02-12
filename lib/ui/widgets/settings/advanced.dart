import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namida/controller/indexer_controller.dart';
import 'package:namida/controller/settings_controller.dart';
import 'package:namida/core/constants.dart';
import 'package:namida/core/icon_fonts/broken_icons.dart';
import 'package:namida/core/translations/strings.dart';
import 'package:namida/core/extensions.dart';
import 'package:namida/main.dart';
import 'package:namida/ui/widgets/custom_widgets.dart';
import 'package:namida/ui/widgets/setting_dialog.dart';
import 'package:namida/ui/widgets/settings_card.dart';

class AdvancedSettings extends StatelessWidget {
  AdvancedSettings({super.key});

  final SettingsController stg = SettingsController.inst;
  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      title: Language.inst.ADVANCED_SETTINGS,
      subtitle: Language.inst.ADVANCED_SETTINGS_SUBTITLE,
      icon: Broken.brush_1,
      child: Column(
        children: [
          CustomListTile(
            icon: Broken.rotate_left_1,
            title: Language.inst.CLEAR_IMAGE_CACHE,
            trailing: Obx(
              () => Text(
                Indexer.inst.getImageCacheSize().fileSizeFormatted,
                style: Get.textTheme.displayMedium?.copyWith(color: context.theme.colorScheme.onBackground.withAlpha(200)),
              ),
            ),
            onTap: () {
              Get.dialog(
                CustomBlurryDialog(
                  isWarning: true,
                  normalTitleStyle: true,
                  bodyText: Language.inst.CLEAR_IMAGE_CACHE_WARNING,
                  actions: [
                    ElevatedButton(
                      onPressed: () => Get.close(1),
                      child: Text(Language.inst.CANCEL),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Indexer.inst.clearImageCache();
                        Get.close(1);
                      },
                      child: Text(Language.inst.CLEAR.toUpperCase()),
                    ),
                  ],
                ),
              );
            },
          ),
          CustomListTile(
            icon: Broken.rotate_left_1,
            title: Language.inst.CLEAR_WAVEFORM_DATA,
            trailing: Obx(
              () => Text(
                Indexer.inst.getWaveformDataSize().fileSizeFormatted,
                style: Get.textTheme.displayMedium?.copyWith(color: context.theme.colorScheme.onBackground.withAlpha(200)),
              ),
            ),
            onTap: () {
              Get.dialog(
                CustomBlurryDialog(
                  isWarning: true,
                  normalTitleStyle: true,
                  title: Language.inst.CLEAR_WAVEFORM_DATA,
                  bodyText: Language.inst.CLEAR_WAVEFORM_DATA_WARNING,
                  actions: [
                    ElevatedButton(
                      onPressed: () => Get.close(1),
                      child: Text(Language.inst.CANCEL),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Indexer.inst.clearWaveformData();
                        Get.close(1);
                      },
                      child: Text(Language.inst.CLEAR.toUpperCase()),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
