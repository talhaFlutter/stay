import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarCreationScreen extends StatefulWidget {
  @override
  _AvatarCreationScreenState createState() => _AvatarCreationScreenState();
}

class _AvatarCreationScreenState extends State<AvatarCreationScreen>
    with TickerProviderStateMixin {
  late TabController _propertyTabController;
  late TabController _subPropertyTabController;
  late PageController _pageController;

  String currentProperty = 'Face'; // Initially selected property
  String currentSubProperty = 'Hair'; // Initially selected sub-property
  dynamic currentAsset =
      Colors.black; // Initially selected asset for Hair Color

  // List to store selected assets for all combinations
  List<List<dynamic>> selectedAssets = [];
  List<List<String>> selectedItems = [];
  // Map of available sub-properties for each property
  final Map<String, List<String>> subProperties = {
    'Base': ['Skin', 'Skin Color', 'Hair', 'Hair Color'],
    'Part': ['Nose', 'Eyes', 'Mouth', 'Beared'],
    'Face': ['Hats', 'Glasses', 'Top', 'Eyebrow'],
  };

  final Map<String, Map<String, List<dynamic>>> propertyAssets = {
    'Hair': {
      'HairStyle': [
        'assets/hairStyle/bun.svg',
        'assets/hairStyle/short.svg',
      ],
    },
    'Hair Color': {
      'HairColor': [
        Colors.black,
        Colors.brown,
        Colors.grey,
      ],
    },
    'Eyebrow': {
      'Eyebrowstyle': [
        'assets/Eyebrow/arched.svg',
        'assets/Eyebrow/beans.svg',
      ],
    },
    'Nose': {
      'NoseShape': [
        'assets/nose/crooked.svg',
        'assets/nose/long.svg',
        'assets/nose/normal.svg',
      ],
    },
    'Eyes': {
      'EyeColor': ['assets/Eyes/arched.svg'],
    },
    'Hats': {
      'HatsDesign': [
        'assets/Hats/hijab.svg',
        'assets/Hats/kippa.svg',
      ],
    },
    'Beared': {
      'Bearedstyle': ['assets/Beard/beard.svg', 'assets/Beard/fullbeard.svg']
    },
    'Mouth': {
      'Mouthstyle': ['assets/Mouth/childish.svg', 'assets/Mouth/confident.svg']
    },
    'Eyes': {
      'EyeColor': ['assets/Eyes/arched.svg']
    },
    'Hats': {
      'HatsDesign': ['assets/Hats/hijab.svg', 'assets/Hats/kippa.svg']
    },
    'Skin': {
      'Skin': ['assets/Skin/skinf.svg', 'assets/Skin/skins.svg']
    },
    'Skin Color': {
      'SkinTone': [
        Colors.lightBlue, // Example skin tone colors
        Colors.brown,
        Colors.pink,
      ],
    },
    'Top': {
      'TopStyle': [
        'assets/Top/top.svg',
        'assets/Top/topH.svg',
      ],
    },
    'Glasses': {
      'GlassesDesign': [
        'assets/Glasses/rectangle.svg',
        'assets/Glasses/round.svg',
      ],
    },
  };
  Color selectedHairColor = Colors.black; // Initialize with default color

  @override
  void dispose() {
    _propertyTabController.dispose();
    _subPropertyTabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _propertyTabController = TabController(
      length: subProperties.keys.length, // Adjusted length here
      vsync: this,
    );

    // Ensure that currentProperty is initialized to a valid key
    currentProperty = subProperties.keys.first;

    _subPropertyTabController = TabController(
      length: subProperties[currentProperty]!.length, // Adjusted length here
      vsync: this,
    );

    // Ensure that currentSubProperty is initialized to a valid sub-property
    currentSubProperty = subProperties[currentProperty]!.first;

    _propertyTabController.addListener(_updateProperty);
    _subPropertyTabController.addListener(_updateSubProperty);
    _pageController = PageController(
      viewportFraction: 0.25, // Set the fraction of the viewport width
    );
    _pageController.addListener(_updateAssetByPage);
  }

  void _updateProperty() {
    setState(() {
      currentProperty =
          subProperties.keys.elementAt(_propertyTabController.index);
      if (currentProperty == 'Clothes') {
        currentSubProperty = subProperties[currentProperty]!
            .first; // Select the first sub-property for Clothes
        _subPropertyTabController = TabController(
          length: subProperties[currentProperty]!
              .length, // Use length of Clothes sub-properties
          vsync: this,
        );
        currentAsset = propertyAssets[currentProperty]!
            .values
            .first
            .first; // Select the first asset for Clothes
        _subPropertyTabController.index =
            0; // Reset the index of subPropertyTabController
      } else {
        currentSubProperty = subProperties[currentProperty]!
            .first; // Select the first sub-property for Face
        currentAsset = propertyAssets[currentSubProperty]!
            .values
            .first
            .first; // Select the first asset for Face
      }
    });
  }

  void _updateSubProperty() {
    setState(() {
      currentSubProperty =
          subProperties[currentProperty]![_subPropertyTabController.index];
      currentAsset = propertyAssets[currentSubProperty]!.values.first.first;
    });
  }

  void updateSelectedItems(String category, dynamic selectedAsset) {
    // Check if there's already an entry for the category
    bool found = false;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i][0] == category) {
        selectedItems[i][1] =
            selectedAsset.toString(); // Replace existing selection
        found = true;
        break;
      }
    }
    if (!found) {
      selectedItems
          .add([category, selectedAsset.toString()]); // Add new selection
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Creation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar Display (placeholder)
          Container(
            height: 200,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: Text('Avatar Display Placeholder'),
          ),
          // Upper Scrolling Bar for Property Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50,
              child: TabBar(
                controller: _propertyTabController,
                labelColor: Colors.deepPurple,
                unselectedLabelColor: Colors.deepPurple,
                indicatorColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                tabs: subProperties.keys.map((property) {
                  return Tab(
                    child: Text(
                      property,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Lower Scrolling Bar for Sub-Property Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50,
              child: TabBar(
                controller: _subPropertyTabController,
                labelColor: Colors.deepPurple,
                unselectedLabelColor: Colors.deepPurple,
                indicatorColor: Colors.purple,
                indicatorWeight: 1,
                tabs: subProperties[currentProperty]!.map((subProperty) {
                  return Tab(text: subProperty);
                }).toList(),
              ),
            ),
          ),
          // Lowest Scrolling Bar for Asset Selection
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _pageController,
              itemCount:
                  propertyAssets[currentSubProperty]!.values.first.length,
              itemBuilder: (context, index) {
                final asset =
                    propertyAssets[currentSubProperty]!.values.first[index];
                return GestureDetector(
                  onTap: () {
                    final asset =
                        propertyAssets[currentSubProperty]!.values.first[index];
                    updateSelectedItems(currentSubProperty, asset);
                    setState(() {
                      currentAsset = asset;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentAsset == asset
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: (currentSubProperty == 'Hair Color' ||
                                  currentSubProperty == 'Skin Color') &&
                              asset is Color
                          ? asset
                          : null, // Display color box if HairColor
                    ),
                    child: (currentSubProperty != 'Hair Color' &&
                            currentSubProperty != 'Skin Color')
                        ? _applyHairColorFilter(asset)
                        : null, // Don't display SVG if HairColor
                  ),
                );
              },
            ),
          ),

          // Save button
          ElevatedButton(
            onPressed: () {
              // Print or do something with the selected assets
              print(selectedItems);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _applyHairColorFilter(String asset) {
    if (currentProperty == 'Face' && currentSubProperty == 'Hair') {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          selectedHairColor,
          BlendMode.modulate,
        ),
        child: SvgPicture.asset(
          asset,
          width: MediaQuery.of(context).size.width * 0.25,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SvgPicture.asset(
        asset,
        width: MediaQuery.of(context).size.width * 0.25,
        fit: BoxFit.cover,
      );
    }
  }

  void _updateSelectedHairColor(Color color) {
    setState(() {
      selectedHairColor = color;
    });
  }

// Update the hair color when it changes
  void _updateAssetByPage() {
    setState(() {
      final currentPage = _pageController.page!.round();
      final assets = propertyAssets[currentSubProperty]!['$currentSubProperty'];
      if (assets != null && assets.isNotEmpty) {
        if (currentSubProperty == 'HairColor') {
          selectedHairColor = assets[currentPage];
          // Update the hair assets
          _updateHairAssets(selectedHairColor);
        } else {
          currentAsset = assets[currentPage];
          updateSelectedItems(currentSubProperty, currentAsset);
        }
      }
    });
  }

// Update the hair assets with the new color
  void _updateHairAssets(Color color) {
    setState(() {
      for (var subProp in subProperties[currentProperty]!) {
        if (propertyAssets[subProp]!.containsKey('HairStyle')) {
          propertyAssets[subProp]!['HairStyle']!.forEach((asset) {});
        }
      }
    });
  }
}
