import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  String currentAsset = 'nose_asset_1.png'; // Initially selected asset for Nose

  // List to store selected assets for all combinations
  List<List<String>> selectedAssets = [];
  List<List<String>> selectedItems = [];
  // Map of available sub-properties for each property
  final Map<String, List<String>> subProperties = {
    'Face': ['Hair', 'Nose', 'Eyes'],
    'Hairs': ['Hats', 'Eyebrow', 'Beared'],
  };

  // Map of available assets for each sub-property
  final Map<String, Map<String, List<String>>> propertyAssets = {
    'Hair': {
      'HairStyle': [
        'assets/hairStyle/bun.svg',
        'assets/hairStyle/short.svg',
      ],
    },
    'Eyebrow': {
      'Eyebrowstyle': [
        'assets/Eyebrow/arched.svg',
        'assets/Eyebrow/beans.svg',
      ]
    },
    'Nose': {
      'NoseShape': [
        'assets/nose/crooked.svg',
        'assets/nose/long.svg',
        'assets/nose/normal.svg'
      ]
    },
    'Beared': {
      'Bearedstyle': ['assets/Beard/beard.svg', 'assets/Beard/fullbeard.svg']
    },
    'Eyes': {
      'EyeColor': ['assets/Eyes/arched.svg']
    },
    'Hats': {
      'HatsDesign': ['assets/Hats/hijab.svg', 'assets/Hats/ippa.svg']
    },
  };

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
    _propertyTabController =
        TabController(length: subProperties.length, vsync: this);
    _subPropertyTabController = TabController(
        length: subProperties[currentProperty]!.length, vsync: this);
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
      currentSubProperty = subProperties[currentProperty]![0];
      currentAsset = propertyAssets[currentSubProperty]!.values.first.first;
      _subPropertyTabController.index =
          0; // Reset the index of the lower tab controller
    });
  }

  void _updateSubProperty() {
    setState(() {
      currentSubProperty =
          subProperties[currentProperty]![_subPropertyTabController.index];
      currentAsset = propertyAssets[currentSubProperty]!.values.first.first;
    });
  }

  // void _updateAssetByPage() {
  //   setState(() {
  //     final currentPage = _pageController.page!.round();
  //     final assets = propertyAssets[currentSubProperty]!.values.first;
  //     currentAsset = assets[currentPage];
  //   });
  // }

  // void updateAsset(String asset) {
  //   setState(() {
  //     currentAsset = asset;
  //     final assetIndex =
  //         propertyAssets[currentSubProperty]!.values.first.indexOf(asset);
  //     _pageController.animateToPage(
  //       assetIndex,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //     // Save the selected asset for the current combination
  //     selectedAssets.add([currentProperty, currentSubProperty, asset]);
  //   });
  // }

  void updateSelectedItems(String category, String selectedAsset) {
    // Check if there's already an entry for the category
    bool found = false;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i][0] == category) {
        selectedItems[i][1] = selectedAsset; // Replace existing selection
        found = true;
        break;
      }
    }
    if (!found) {
      selectedItems.add([category, selectedAsset]); // Add new selection
    }
  }

  void _updateAssetByPage() {
    setState(() {
      final currentPage = _pageController.page!.round();
      final assets = propertyAssets[currentSubProperty]![currentSubProperty];
      if (assets != null && assets.isNotEmpty) {
        currentAsset = assets[currentPage];
        updateSelectedItems(currentSubProperty, currentAsset);
      }
    });
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
                    ),
                    child: SvgPicture.asset(
                      propertyAssets[currentSubProperty]!.values.first[index],
                      width: MediaQuery.of(context).size.width * 0.25,
                      fit: BoxFit.cover,
                    ),
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
}
