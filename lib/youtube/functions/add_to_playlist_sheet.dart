import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:namida/controller/current_color.dart';
import 'package:namida/controller/navigator_controller.dart';
import 'package:namida/youtube/controller/youtube_controller.dart';
import 'package:namida/youtube/controller/youtube_playlist_controller.dart' as pc;
import 'package:namida/core/extensions.dart';
import 'package:namida/core/icon_fonts/broken_icons.dart';
import 'package:namida/core/translations/language.dart';
import 'package:namida/main.dart';
import 'package:namida/ui/dialogs/edit_tags_dialog.dart';
import 'package:namida/ui/widgets/custom_widgets.dart';
import 'package:namida/youtube/youtube_playlists_view.dart';

void showAddToPlaylistSheet({
  BuildContext? ctx,
  required Iterable<String> ids,
  required Map<String, String?> idsNamesLookup,
  String playlistNameToAdd = '',
}) async {
  final pcontroller = pc.YoutubePlaylistController.inst;

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final context = ctx ?? rootContext;

  final videoNamesSubtitle = ids
          .map((id) => idsNamesLookup[id] ?? YoutubeController.inst.getBackupVideoInfo(id)?.title ?? YoutubeController.inst.fetchVideoDetailsFromCacheSync(id)?.name ?? id)
          .take(3)
          .join(', ') +
      (ids.length > 3 ? '... + ${ids.length - 3}' : '');

  await Future.delayed(Duration.zero); // delay bcz sometimes doesnt show
  // ignore: use_build_context_synchronously
  showModalBottomSheet(
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0.multipliedRadius),
          color: context.theme.scaffoldBackgroundColor,
        ),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                lang.PLAYLISTS,
                style: context.textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: playlistNameToAdd == ''
                  ? Text(
                      videoNamesSubtitle,
                      style: context.textTheme.displaySmall,
                    )
                  : RichText(
                      text: TextSpan(
                        text: playlistNameToAdd,
                        style: context.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: " ($videoNamesSubtitle)",
                            style: context.textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 6.0),
            Expanded(
              child: YoutubePlaylistsView(idsToAdd: ids, displayMenu: false),
            ),
            const SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 18.0),
                Expanded(
                  child: NamidaInkWell(
                    bgColor: CurrentColor.inst.color.withAlpha(40),
                    height: 48.0,
                    borderRadius: 12.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Broken.add),
                        const SizedBox(width: 8.0),
                        Text(
                          lang.CREATE,
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    onTap: () {
                      NamidaNavigator.inst.navigateDialog(
                        dialog: Form(
                          key: formKey,
                          child: CustomBlurryDialog(
                            title: lang.CONFIGURE,
                            actions: [
                              const CancelButton(),
                              NamidaButton(
                                text: lang.ADD,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    pcontroller.addNewPlaylist(controller.text);
                                    NamidaNavigator.inst.closeDialog();
                                  }
                                },
                              ),
                            ],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                CustomTagTextField(
                                  controller: controller,
                                  hintText: '',
                                  labelText: lang.NAME,
                                  validator: (value) => pcontroller.validatePlaylistName(value),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 18.0),
              ],
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    },
  );
}
