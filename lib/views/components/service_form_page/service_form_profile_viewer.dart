import 'package:flutter/material.dart';
import 'package:home_fix/models/user_profile_model.dart';
import 'package:home_fix/view_models/service_form_view_model.dart';
import 'package:provider/provider.dart';






class ProfileDropDownMenu extends StatefulWidget {
  const ProfileDropDownMenu({super.key});

  @override
  State<ProfileDropDownMenu> createState() => _ProfileDropDownMenuState();
}

class _ProfileDropDownMenuState extends State<ProfileDropDownMenu> {
  final GlobalKey _key = GlobalKey();
  bool _isMenuOpen = false;
  OverlayEntry? _overlayEntry;
  int? _currentSelectionIndex;

  @override
  void initState() {
    super.initState();
    // Set initial selection if profiles exist
    final vm = context.read<ServiceFormViewModel>();
    if (vm.userProfiles.isNotEmpty) {
      _currentSelectionIndex = 0;
      // Optionally, update the view model with the initial selection
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   vm.selectUserProfile(vm.userProfiles[0]);
      // });
    }
  }

  void _toggleMenu(ServiceFormViewModel vm) {
    if (_isMenuOpen) {
      _closeMenu();
    } else {
      _openMenu(vm);
    }
  }

  void _openMenu(ServiceFormViewModel vm) {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final list = List<Widget>.generate(vm.userProfiles.length, (index) {
      return InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              _currentSelectionIndex = index;
              vm.activeProfile =  vm.userProfiles[index];
            });
          }
          _closeMenu();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ProfileDropDownEntry(userProfile: vm.userProfiles[index]),
        ),
      );
    });

    list.add(
      ListTile(
        title: const Text("Add User Profile"),
        onTap: () {
          context.read<ServiceFormViewModel>().showAddUserProfilePage(context);
          _closeMenu();
        },
      ),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Full screen GestureDetector to close the menu when tapping outside
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: Material(
                elevation: 4.0,
                color: Theme.of(context).cardColor, // Standard dropdown color
                borderRadius: BorderRadius.circular(4.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 250, // Limit dropdown height
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: list,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    if (mounted) {
      setState(() {
        _isMenuOpen = true;
      });
    }
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isMenuOpen = false;
      });
    }
  }



  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServiceFormViewModel>();
    final selectedProfile = (_currentSelectionIndex != null && vm.userProfiles.isNotEmpty)
        ? vm.userProfiles[_currentSelectionIndex!]
        : null;

    vm.activeProfile =  vm.userProfiles[_currentSelectionIndex == null? 0 : _currentSelectionIndex!];
    return GestureDetector(
      onTap: (){_toggleMenu(vm);},
      child: InputDecorator(
        key: _key,
        decoration: InputDecoration(
          labelText: "Profile",
          border: const OutlineInputBorder(),
          suffixIcon: Icon(_isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        ),
        child: selectedProfile != null
            ? ProfileDropDownEntry(userProfile: selectedProfile)
            : const Text("No Profile Selected"), // Placeholder when no profile is selected or available
      ),
    );
  }
}

class ProfileDropDownEntry extends StatelessWidget {
  final UserProfileModel userProfile;
  const ProfileDropDownEntry({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userProfile.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userProfile.address,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
        const SizedBox(height: 2),
        Text(
          userProfile.phoneNumber,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      ],
    );
  }
}