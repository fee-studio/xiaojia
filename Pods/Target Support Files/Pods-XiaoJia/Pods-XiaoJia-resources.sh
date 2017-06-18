#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/CTAssetsPickerController/CTAssetsPickerController.bundle"
  install_resource "GPUImage/framework/Resources/lookup.png"
  install_resource "GPUImage/framework/Resources/lookup_amatorka.png"
  install_resource "GPUImage/framework/Resources/lookup_miss_etikate.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_1.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_2.png"
  install_resource "IDMPhotoBrowser/Classes/IDMPhotoBrowser.bundle"
  install_resource "IDMPhotoBrowser/Classes/IDMPBLocalizations.bundle"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Assets/JSQMessagesAssets.bundle"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Controllers/JSQMessagesViewController.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesCollectionViewCellIncoming.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesCollectionViewCellOutgoing.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesLoadEarlierHeaderView.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesToolbarContentView.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesTypingIndicatorFooterView.xib"
  install_resource "NSDate+TimeAgo/NSDateTimeAgo.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/QBImagePickerController/QBImagePicker.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/TOWebViewController/TOWebViewControllerLocalizable.bundle"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground@2x.png"
  install_resource "TSMessages/Pod/Assets/TSMessagesDefaultDesign.json"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/zh-Hans.lproj/UMFeedbackLocalizable.strings"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/bubble_min@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/microphone@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/save@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputText@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputTextHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputVoice@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputVoiceHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_add_photo@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_dialog_cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_dialog_content@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_01@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_02@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_03@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_default@2x.png"
  install_resource "YWFeedbackFMWK/YWFeedbackBundle.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/CTAssetsPickerController/CTAssetsPickerController.bundle"
  install_resource "GPUImage/framework/Resources/lookup.png"
  install_resource "GPUImage/framework/Resources/lookup_amatorka.png"
  install_resource "GPUImage/framework/Resources/lookup_miss_etikate.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_1.png"
  install_resource "GPUImage/framework/Resources/lookup_soft_elegance_2.png"
  install_resource "IDMPhotoBrowser/Classes/IDMPhotoBrowser.bundle"
  install_resource "IDMPhotoBrowser/Classes/IDMPBLocalizations.bundle"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Assets/JSQMessagesAssets.bundle"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Controllers/JSQMessagesViewController.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesCollectionViewCellIncoming.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesCollectionViewCellOutgoing.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesLoadEarlierHeaderView.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesToolbarContentView.xib"
  install_resource "JSQMessagesViewController/JSQMessagesViewController/Views/JSQMessagesTypingIndicatorFooterView.xib"
  install_resource "NSDate+TimeAgo/NSDateTimeAgo.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/QBImagePickerController/QBImagePicker.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/TOWebViewController/TOWebViewControllerLocalizable.bundle"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundError@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundErrorIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundMessage@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccess@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundSuccessIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarning@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon.png"
  install_resource "TSMessages/Pod/Assets/NotificationBackgroundWarningIcon@2x.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground.png"
  install_resource "TSMessages/Pod/Assets/NotificationButtonBackground@2x.png"
  install_resource "TSMessages/Pod/Assets/TSMessagesDefaultDesign.json"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/zh-Hans.lproj/UMFeedbackLocalizable.strings"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/bubble_min@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/microphone@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/save@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputText@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputTextHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputVoice@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/ToolViewInputVoiceHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_add_photo@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_dialog_cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_dialog_content@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_01@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_02@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_03@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.4/UMengFeedback_SDK/Resources/umeng_fb_audio_play_default@2x.png"
  install_resource "YWFeedbackFMWK/YWFeedbackBundle.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
