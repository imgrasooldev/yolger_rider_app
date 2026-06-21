import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/colors.dart';
import '../../../config/helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/widgets/custom_appbar_without_navbar.dart';
import '../../../utils/widgets/custom_scaffold.dart';
import '../../../utils/widgets/toast_message.dart';
import '../../system_settings/bloc/system_settings_bloc.dart';
import '../../system_settings/bloc/system_settings_state.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ToastManager.show(
        context: context,
        message: 'Unable to open',
        type: ToastType.error,
      );
    }
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedback.lightImpact();
    ToastManager.show(
      context: context,
      message: message,
      type: ToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBarWithoutNavbar(
        title: AppLocalizations.of(context)!.support,
      ),
      body: BlocBuilder<SystemSettingsBloc, SystemSettingsState>(
        builder: (context, state) {
          final value = state.settings?.systemSettings?.value;
          final String phoneNumber = value?.sellerSupportNumber ?? '';
          final String email = value?.sellerSupportEmail ?? '';

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildContactCard(
                  context: context,
                  icon: Icons.phone,
                  title: AppLocalizations.of(context)!.callUs,
                  subtitle: phoneNumber,
                  onTap: phoneNumber.isEmpty
                      ? null
                      : () => _launchUrl(context, 'tel:$phoneNumber'),
                  onLongPress: phoneNumber.isEmpty
                      ? null
                      : () => _copyToClipboard(
                            context,
                            phoneNumber,
                            AppLocalizations.of(context)!.phoneNumberCopied,
                          ),
                ),
                SizedBox(height: 16.h),
                _buildContactCard(
                  context: context,
                  icon: Icons.email,
                  title: AppLocalizations.of(context)!.emailUs,
                  subtitle: email,
                  onTap: email.isEmpty
                      ? null
                      : () => _launchUrl(
                            context,
                            'mailto:$email?subject=Support Request',
                          ),
                  onLongPress: email.isEmpty
                      ? null
                      : () => _copyToClipboard(
                            context,
                            email,
                            AppLocalizations.of(context)!.emailCopied,
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    required VoidCallback? onLongPress,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: isTablet(context: context) ? 18.r : 22.r,
              backgroundColor:
                  AppColors.primaryColor.withValues(alpha: 0.1),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: isTablet(context: context) ? 22.r : 22.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet(context: context) ? 20 : 14.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isTablet(context: context) ? 18 : 12.sp,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  Icons.touch_app,
                  size: isTablet(context: context) ? 14.r : 15.sp,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                SizedBox(height: 4.h),
                Text(
                  AppLocalizations.of(context)!.tapToContact,
                  style: TextStyle(
                    fontSize: isTablet(context: context) ? 14 : 8.sp,
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
