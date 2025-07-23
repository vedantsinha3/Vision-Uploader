import 'dart:async';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; 

// Constants for SharedPreferences
const String kServerUrlKey = 'server_url';
// Default server base URL (without the /upload path)
const String kDefaultServerBaseUrl = 'http://10.34.4.137:5000';
const String kUploadPath = '/upload';


const Color primaryDarkRed = Color(0xFFB71C1C); 
const Color secondaryAccentRed = Color(0xFFD32F2F); 
const Color darkSurface = Color(0xFF1E1E1E); 
const Color darkBackground = Color(0xFF121212); 
const Color cardColor = Color(0xFF252525); 
const Color accentGray = Color(0xFFBDBDBD); 
const Color lightTextOnDark = Colors.white;
const Color slightlyDimTextOnDark = Color(0xDDFFFFFF); 
const Color hintTextColor = Color(0xFFAAAAAA); 

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, 
    statusBarIconBrightness: Brightness.light, 
    systemNavigationBarColor: darkBackground,     
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine Label Scanner',
      debugShowCheckedModeBanner: false, // Remove debug banner for cleaner look
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryDarkRed,
        
        // Define the color scheme using the dark red as a seed
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryDarkRed,
          brightness: Brightness.dark,
          primary: primaryDarkRed,
          secondary: secondaryAccentRed,
          tertiary: accentGray,
          surface: darkSurface,
          background: darkBackground,
          error: Colors.orangeAccent,
          onPrimary: lightTextOnDark,
          onSecondary: lightTextOnDark,
          onSurface: lightTextOnDark,
          onBackground: lightTextOnDark,
          onError: Colors.black,
        ),

        scaffoldBackgroundColor: darkBackground,

        appBarTheme: const AppBarTheme(
          backgroundColor: primaryDarkRed,
          foregroundColor: lightTextOnDark,
          elevation: 4.0,
          centerTitle: true, // Center app bar title for a more polished look
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5, // Slight letter spacing for elegance
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDarkRed,
            foregroundColor: lightTextOnDark,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            elevation: 3, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), 
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5, 
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: accentGray,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
        ),

        cardTheme: CardTheme(
          color: cardColor,
          elevation: 4.0, // More elevation for better shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // More rounded corners
            side: BorderSide(color: Colors.grey[850]!, width: 0.5), // Subtle border
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          shadowColor: Colors.black.withOpacity(0.4), // Custom shadow color
        ),

        dialogTheme: DialogTheme(
          backgroundColor: cardColor, // Use card color for consistency
          elevation: 8.0, // Higher elevation for dialog prominence
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          titleTextStyle: const TextStyle(
            color: lightTextOnDark, 
            fontSize: 20, 
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          contentTextStyle: const TextStyle(
            color: slightlyDimTextOnDark, 
            fontSize: 16,
            height: 1.4, 
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkBackground.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[700]!, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[700]!, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: secondaryAccentRed, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          hintStyle: TextStyle(color: hintTextColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),

        iconTheme: const IconThemeData(
          color: accentGray,
          size: 24, 
        ),
        
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryDarkRed,
          linearTrackColor: Colors.grey, 
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: cardColor,
          modalBackgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          modalElevation: 8,
        ),

        
        textTheme: Typography.material2021(platform: TargetPlatform.android)
            .white
            .copyWith(
              displayLarge: const TextStyle(color: lightTextOnDark, fontWeight: FontWeight.bold),
              displayMedium: const TextStyle(color: lightTextOnDark, fontWeight: FontWeight.bold),
              bodyLarge: const TextStyle(color: slightlyDimTextOnDark),
              bodyMedium: const TextStyle(color: slightlyDimTextOnDark),
              titleMedium: const TextStyle(color: lightTextOnDark, fontWeight: FontWeight.w500),
              headlineSmall: const TextStyle(color: lightTextOnDark, fontWeight: FontWeight.bold),
              labelLarge: const TextStyle(color: lightTextOnDark, fontWeight: FontWeight.w500),
            ),
        useMaterial3: true, 
      ),
      home: const ImageUploader(),
    );
  }
}


Future<String> getUploadUrl() async {
  final prefs = await SharedPreferences.getInstance();
  final baseUrl = prefs.getString(kServerUrlKey) ?? kDefaultServerBaseUrl;
  return '$baseUrl$kUploadPath';
}

// Settings Screen Widget
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _serverUrlController = TextEditingController();
  bool _isEditingUrl = false;

  @override
  void initState() {
    super.initState();
    _loadServerUrl();
  }

  Future<void> _loadServerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _serverUrlController.text =
          prefs.getString(kServerUrlKey) ?? kDefaultServerBaseUrl;
    });
  }

  Future<void> _saveServerUrl() async {
    if (_serverUrlController.text.isEmpty) {
      if (mounted) {
        _showErrorSnackBar('Server URL cannot be empty.');
      }
      return;
    }
    Uri? uri = Uri.tryParse(_serverUrlController.text);
    if (uri == null || !uri.isAbsolute || (uri.scheme != 'http' && uri.scheme != 'https')) {
         if (mounted) {
           _showErrorSnackBar('Invalid URL format. Use http:// or https://');
         }
         return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kServerUrlKey, _serverUrlController.text);
    if (mounted) {
      setState(() {
        _isEditingUrl = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('Server URL saved successfully'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Server Connection',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.cloud,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Text(
                      'Server Base URL:',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _serverUrlController,
                      decoration: InputDecoration(
                        hintText: 'e.g., http://your-server.com:port',
                        prefixIcon: const Icon(Icons.link),
                        suffixIcon: _isEditingUrl 
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                tooltip: 'Cancel',
                                onPressed: () {
                                  setState(() {
                                    _loadServerUrl();
                                    _isEditingUrl = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.edit),
                                tooltip: 'Edit URL',
                                onPressed: () {
                                  setState(() {
                                    _isEditingUrl = true;
                                  });
                                },
                              ),
                        // Remove the 'enabled' property to ensure the text field is always editable
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: _isEditingUrl 
                                ? theme.colorScheme.primary
                                : Colors.grey[700]!,
                            width: _isEditingUrl ? 2.0 : 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: _isEditingUrl 
                                ? theme.colorScheme.primary
                                : Colors.grey[700]!,
                            width: _isEditingUrl ? 2.0 : 1.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      style: TextStyle(
                        color: lightTextOnDark,
                        fontWeight: _isEditingUrl ? FontWeight.normal : FontWeight.w300,
                      ),
                      onTap: () {
                        if (!_isEditingUrl) {
                          setState(() {
                            _isEditingUrl = true;
                          });
                        }
                      },
                      // Enable or disable the text field based on editing state
                      enabled: true,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'The upload path "$kUploadPath" will be appended to this URL.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: slightlyDimTextOnDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _isEditingUrl ? _saveServerUrl : null,
                        icon: const Icon(Icons.save),
                        label: const Text('Save URL'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          // Make the button more visible when active
                          backgroundColor: _isEditingUrl 
                              ? theme.colorScheme.primary 
                              : theme.colorScheme.surface,
                          foregroundColor: _isEditingUrl 
                              ? theme.colorScheme.onPrimary 
                              : theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Version info section
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Text(
                      'Wine Label Scanner',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.0',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.tertiary),
                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _serverUrlController.dispose();
    super.dispose();
  }
}

// Image Uploader Screen Widget
class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});
  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> with SingleTickerProviderStateMixin {
  File? _image;
  bool _isLoading = false;
  String _statusMessage = 'Ready. Select an image.';
  final Duration _requestTimeout = const Duration(seconds: 60);
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 90, // High quality but not full to reduce file size
      );
      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _image = File(pickedFile.path);
            _statusMessage = "Image ready for upload.";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        _showCustomDialog("Image Picker Error",
            "Could not pick image: ${e.toString()}");
      }
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      elevation: 8,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Select Image Source',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.photo_camera, color: theme.colorScheme.primary),
                ),
                title: Text('Take a picture', style: theme.textTheme.bodyLarge),
                subtitle: Text('Open camera to capture a new photo', style: theme.textTheme.bodySmall),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.photo_library, color: theme.colorScheme.primary),
                ),
                title: Text('Choose from gallery', style: theme.textTheme.bodyLarge),
                subtitle: Text('Select an existing photo', style: theme.textTheme.bodySmall),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(source: ImageSource.gallery);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _clearImage() {
    // Reset animation 
    _animationController.reset();
    
    setState(() {
      _image = null;
      _statusMessage = 'Ready. Select an image.';
    });
    
    // fade in animation
    _animationController.forward();
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      _showCustomDialog("No Image", "Please select an image to upload.");
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Uploading image…';
      });
    }

    String serverUploadUrl = '';
    try {
      serverUploadUrl = await getUploadUrl();
      if (serverUploadUrl.isEmpty || serverUploadUrl == kUploadPath) {
        _showCustomDialog('Configuration Error',
            'Server URL is not set or is invalid. Please configure it in settings.');
        if (mounted) {
          setState(() => _statusMessage = 'Upload failed: Server URL not set');
        }
        return;
      }

      final uri = Uri.parse(serverUploadUrl);
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          _image!.path,
          filename: 'wine_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ));

      final streamedResponse = await request.send().timeout(_requestTimeout);
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200) {
        _handleSuccessfulUpload();
      } else {
        _showCustomDialog('Server Error',
            'Status code: ${streamedResponse.statusCode}\nResponse: $responseBody');
        if (mounted) {
          setState(() => _statusMessage = 'Upload failed');
        }
      }
    } on TimeoutException {
      _handleUploadTimeout();
    } on FormatException catch (e) {
      _showCustomDialog('Configuration Error',
          'Invalid server URL format ($serverUploadUrl). Please check settings.\nDetails: ${e.message}');
      if (mounted) {
        setState(() => _statusMessage = 'Upload failed: Invalid server URL');
      }
    } on http.ClientException catch (e) {
      _showCustomDialog('Network Error',
          'Failed to connect to the server. Please check your network connection and server address.\nDetails: ${e.message}');
      if (mounted) {
        setState(() => _statusMessage = 'Upload failed: Network issue');
      }
    } catch (e) {
      _showCustomDialog(
          'Upload Error', 'An unexpected error occurred: ${e.toString()}');
      if (mounted) {
        setState(() => _statusMessage = 'Upload failed');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleSuccessfulUpload() {
    if (mounted) {
      setState(
          () => _statusMessage = 'Upload successful. Analysis in background.');
    }
    _showCustomDialog(
      'Upload Complete',
      'Your wine label was successfully uploaded to the server and will be processed shortly.',
      icon: Icons.check_circle,
      iconColor: Colors.green,
    );
  }

  void _handleUploadTimeout() {
    if (mounted) {
      setState(() =>
          _statusMessage = 'Upload sent. Server processing may be in progress.');
    }
    _showCustomDialog(
      'Upload Sent (Timeout)',
      'The image was sent, but the server took too long to confirm. Analysis might be running in the background. Please check later.',
      icon: Icons.hourglass_top,
      iconColor: Colors.amber,
    );
  }

  void _showCustomDialog(String title, String content, {IconData? icon, Color? iconColor}) {
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).colorScheme.primary,
                size: 48,
              ),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(content, textAlign: TextAlign.center),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('OK'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wine_bar, size: 28), // Wine icon
            const SizedBox(width: 12),
            const Text('Wine Label Scanner'),
          ],
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or app title
                  if (_image == null)
                    Column(
                      children: [
                        Icon(
                          Icons.wine_bar, 
                          size: 72, 
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Wine Label Scanner',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload a wine label to identify',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: slightlyDimTextOnDark,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  
                  // Image preview card
                  Card(
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.4),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    _image!,
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: theme.colorScheme.onSurface.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo_camera_outlined,
                                          size: 80,
                                          color: theme.iconTheme.color?.withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No image selected',
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap the button below to select a wine label',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          if (_image != null && !_isLoading)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: TextButton.icon(
                                onPressed: _clearImage,
                                icon: Icon(Icons.delete_outline,
                                    color: theme.colorScheme.error),
                                label: Text('Remove Image',
                                    style: TextStyle(color: theme.colorScheme.error)),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showImageSourceActionSheet(context),
                          icon: const Icon(Icons.add_a_photo_outlined),
                          label: Text(_image == null ? 'Select Wine Label' : 'Change Image'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _image == null ? theme.colorScheme.primary : Colors.blueGrey[700],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      if (_image != null) const SizedBox(width: 16),
                      if (_image != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _uploadImage,
                            icon: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.cloud_upload_outlined),
                            label: Text(_isLoading ? 'Uploading...' : 'Upload Label'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryAccentRed,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              disabledBackgroundColor: Colors.grey[700],
                              disabledForegroundColor: Colors.grey[400],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Status indicator
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey<String>(_statusMessage), // For proper animation
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor().withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getStatusIcon(),
                            color: _getStatusColor(),
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _statusMessage,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _getStatusColor().withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Bottom info text
                  const SizedBox(height: 16),
                  const Text(
                    'Quickly identify wine labels with AI technology',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: slightlyDimTextOnDark,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getStatusColor() {
    if (_statusMessage.contains('failed') || _statusMessage.contains('Error')) {
      return Colors.red[400]!;
    } else if (_statusMessage.contains('successful') || _statusMessage.contains('ready')) {
      return Colors.green[400]!;
    } else if (_statusMessage.contains('Uploading')) {
      return Colors.blue[400]!;
    } else if (_statusMessage.contains('progress')) {
      return Colors.orange[400]!;
    } else {
      return accentGray; // Default color
    }
  }
  

  IconData _getStatusIcon() {
    if (_statusMessage.contains('failed') || _statusMessage.contains('Error')) {
      return Icons.error_outline;
    } else if (_statusMessage.contains('successful')) {
      return Icons.check_circle_outline;
    } else if (_statusMessage.contains('ready')) {
      return Icons.photo_outlined;
    } else if (_statusMessage.contains('Uploading')) {
      return Icons.cloud_upload_outlined;
    } else if (_statusMessage.contains('progress')) {
      return Icons.hourglass_top;
    } else {
      return Icons.info_outline; // Default icon
    }
  }
}