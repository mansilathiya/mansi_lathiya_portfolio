import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _sending = true;
    });

    try {
      final subject = Uri.encodeComponent(_subjectController.text.trim());

      final body = Uri.encodeComponent('''
${_nameController.text.trim()}
${_emailController.text.trim()}

${_messageController.text.trim()}
''');

      final uri = Uri.parse(
        'mailto:${PortfolioData.email}'
        '?subject=$subject'
        '&body=$body',
      );

      log('Mail URI: $uri');

      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!launched) {
        throw Exception('Unable to open the email application.');
      }

      if (!mounted) return;

      _formKey.currentState?.reset();

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      setState(() {
        _sending = false;
        _sent = true;
      });

      Future.delayed(AppConstants.duration6Second, () {
        if (mounted) {
          setState(() => _sent = false);
        }
      });
    } catch (e, s) {
      log('sendEmail Error: $e');
      log('StackTrace: $s');

      if (mounted) {
        setState(() => _sending = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to open the email application.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = responsive.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.hPad,
        vertical: responsive.sectionV,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            spacing: 56,
            children: [
              const SectionTitle(
                subtitle: "CONTACT ME",
                title: "Let's Work Together",
                description: "Let's build something amazing together",
              ),
              isMobile
                  ? Column(
                      spacing: 24,
                      children: [
                        _ContactInfoCard(isDark: isDark),
                        _ContactFormCard(
                          isDark: isDark,
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailController,
                          subjectController: _subjectController,
                          messageController: _messageController,
                          sending: _sending,
                          sent: _sent,
                          onSend: sendEmail,
                        ),
                      ],
                    )
                  : Row(
                      spacing: 28,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: _ContactInfoCard(isDark: isDark),
                        ),
                        Expanded(
                          flex: 5,
                          child: _ContactFormCard(
                            isDark: isDark,
                            formKey: _formKey,
                            nameController: _nameController,
                            emailController: _emailController,
                            subjectController: _subjectController,
                            messageController: _messageController,
                            sending: _sending,
                            sent: _sent,
                            onSend: sendEmail,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Contact Info Card
class _ContactInfoCard extends StatelessWidget {
  final bool isDark;
  const _ContactInfoCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: _cardDecoration(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.waving_hand_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  // 'Available for Work',
                  PortfolioData.availableWork,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Flutter Developer · Firebase · REST APIs",
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            "Contact Details",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _InfoTile(
            isDark: isDark,
            icon: Icons.email_outlined,
            label: "Email",
            value: PortfolioData.email,
            url: "mailto:${PortfolioData.email}",
          ),
          // _InfoTile(
          //   isDark: isDark,
          //   icon: Icons.phone_outlined,
          //   label: "Phone",
          //   value: PortfolioData.phone,
          //   url: "tel:${PortfolioData.phone}"",
          // ),
          _InfoTile(
            isDark: isDark,
            icon: Icons.location_on_outlined,
            label: "Location",
            value: PortfolioData.location,
          ),
          const SizedBox(height: 28),
          Text(
            "Find Me On",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 10,
            children: [
              _SocialChip(
                faIcon: FontAwesomeIcons.github,
                label: "GitHub",
                url: PortfolioData.github,
                isDark: isDark,
              ),
              _SocialChip(
                faIcon: FontAwesomeIcons.linkedin,
                label: "LinkedIn",
                url: PortfolioData.linkedin,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Contact Form Card
class _ContactFormCard extends StatelessWidget {
  final bool isDark;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController,
      emailController,
      subjectController,
      messageController;
  final bool sending, sent;
  final VoidCallback onSend;

  const _ContactFormCard({
    required this.isDark,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.sending,
    required this.sent,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: _cardDecoration(isDark),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send a Message",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Fill out the form and I'll get back to you shortly.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (_, constraints) {
                final useRow = constraints.maxWidth > 480;
                final nameField = _FormField(
                  controller: nameController,
                  label: "Your Name",
                  hint: "Enter your name",
                  icon: Icons.person_outline_rounded,
                  isDark: isDark,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? "Please enter your name"
                      : null,
                );
                final emailField = _FormField(
                  controller: emailController,
                  label: "Email Address",
                  hint: "Enter your email address",
                  icon: Icons.email_outlined,
                  isDark: isDark,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[\w.]+@[\w.]+\.\w+$').hasMatch(v)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                );
                if (useRow) {
                  return Row(
                    spacing: 16,
                    children: [
                      Expanded(child: nameField),
                      Expanded(child: emailField),
                    ],
                  );
                }
                return Column(spacing: 16, children: [nameField, emailField]);
              },
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: subjectController,
              label: "Subject",
              // hint: "Project Collaboration",
              hint: "Enter Subject",
              icon: Icons.subject_rounded,
              isDark: isDark,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? "Please enter subject"
                  : null,
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: messageController,
              label: "Message",
              // hint: "Tell me about your project or opportunity...",
              hint: "Enter your message",
              icon: Icons.chat_bubble_outline_rounded,
              isDark: isDark,
              maxLines: 5,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? "Please enter your message"
                  : null,
            ),
            const SizedBox(height: 24),
            if (sent)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                      size: 20,
                    ),
                    Flexible(
                      child: Text(
                        "Mail client opened! Message ready to send.",
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: sending
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ),
                    )
                  : _GradientSendButton(onTap: onSend),
            ),
          ],
        ),
      ),
    );
  }
}

// Info Tile
class _InfoTile extends StatefulWidget {
  final bool isDark;
  final IconData icon;
  final String label, value;
  final String? url;

  const _InfoTile({
    required this.isDark,
    required this.icon,
    required this.label,
    required this.value,
    this.url,
  });

  @override
  State<_InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<_InfoTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.url != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.url != null
            ? () => launchUrl(Uri.parse(widget.url!))
            : () => Clipboard.setData(ClipboardData(text: widget.value)),
        child: AnimatedContainer(
          duration: AppConstants.duration200,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hover
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : (widget.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: context.textSecondary,
                      ),
                    ),
                    Text(
                      widget.value,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _hover ? AppColors.primary : null,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.url != null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: _hover ? AppColors.primary : context.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Social Chip
class _SocialChip extends StatefulWidget {
  final FaIconData faIcon;
  final String label, url;
  final bool isDark;

  const _SocialChip({
    required this.faIcon,
    required this.label,
    required this.url,
    required this.isDark,
  });

  @override
  State<_SocialChip> createState() => _SocialChipState();
}

class _SocialChipState extends State<_SocialChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: AppConstants.duration200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: _hover ? AppColors.primaryGradient : null,
            color: _hover
                ? null
                : (widget.isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hover
                  ? Colors.transparent
                  : (widget.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder),
            ),
          ),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.faIcon,
                size: 15,
                color: _hover ? Colors.white : AppColors.primary,
              ),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hover ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Form Field
class _FormField extends StatefulWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final bool isDark;
  final int maxLines;
  final String? Function(String?) validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.isDark,
    required this.validator,
    this.maxLines = 1,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (f) => setState(() => _focused = f),
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        validator: widget.validator,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: context.textSecondary.withValues(alpha: 0.6),
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: _focused ? AppColors.primary : context.textSecondary,
          ),
          prefixIcon: widget.maxLines == 1
              ? Icon(
                  widget.icon,
                  size: 18,
                  color: _focused ? AppColors.primary : context.textSecondary,
                )
              : null,
          filled: true,
          fillColor: widget.isDark
              ? AppColors.darkSurface
              : AppColors.lightCard,
          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.maxLines > 1 ? 18 : 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: widget.isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.accent.withValues(alpha: 0.8),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
        ),
      ),
    );
  }
}

// Gradient Send Button
class _GradientSendButton extends StatefulWidget {
  final VoidCallback onTap;
  const _GradientSendButton({required this.onTap});

  @override
  State<_GradientSendButton> createState() => _GradientSendButtonState();
}

class _GradientSendButtonState extends State<_GradientSendButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.duration200,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _hover ? 0.45 : 0.25,
                ),
                blurRadius: _hover ? 20 : 10,
                offset: Offset(0, _hover ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.send_rounded, color: Colors.white, size: 18),
              Text(
                "Send Message",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Card decoration
BoxDecoration _cardDecoration(bool isDark) => BoxDecoration(
  color: isDark ? AppColors.darkCard : AppColors.lightSurface,
  borderRadius: BorderRadius.circular(24),
  border: Border.all(
    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.07),
      blurRadius: 24,
      offset: const Offset(0, 6),
    ),
  ],
);
