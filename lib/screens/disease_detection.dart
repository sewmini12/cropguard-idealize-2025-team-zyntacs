import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  Map<String, dynamic>? _analysisResult;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),





  body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions







             Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              
              child: Row(
                children: [



                  // Detection Image
                  Container(
                    width: 150,
                    height: 200,
                
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/detection.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                             decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.medical_services,
                              size: 60,
                              color: Color.fromARGB(255, 166, 210, 167),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),





                  // Text Content
                 Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text(
                          'identify and cure plant diseases with cropguard',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 37, 107, 2),
                          ),
                        ),
                        const SizedBox(height: 8),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),

















            const SizedBox(height: 24),










      Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.green.shade200.withOpacity(0.4), Colors.green.shade400.withOpacity(0.4)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.green.shade100.withOpacity(0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TEXT SECTION (Left)
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Step 01',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Open cropguard and tap the camera button in the Plant Health tab.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 16),

      /// IMAGE SECTION (Right)
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/step1.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
),

      


const SizedBox(height: 24),





            // Duplicate How to Use Section
            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(top: 24),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green.shade200.withOpacity(0.4),
        Colors.green.shade400.withOpacity(0.4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.green.shade100.withOpacity(0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TEXT SECTION (Left)
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Step 02',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Place your sick plant at the center of the plant image.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 16),

      /// IMAGE SECTION (Right)
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/step2.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
),




const SizedBox(height: 24),

            // Third How to Use Section
            
            
            
            
            
            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(top: 24),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green.shade200.withOpacity(0.4),
        Colors.green.shade400.withOpacity(0.4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.green.shade100.withOpacity(0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TEXT SECTION (Left)
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Step 03',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Snap photos of the diseased parts of a leaf or multiple leaves.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 16),

      /// IMAGE SECTION (Right)
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/step3.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
),

 
            const SizedBox(height: 24),

            // Fourth How to Use Section
            
            
            
            
            
            
            
          Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(top: 24),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green.shade200.withOpacity(0.4),
        Colors.green.shade400.withOpacity(0.4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.green.shade100.withOpacity(0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TEXT SECTION (Left)
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Step 04',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Answer a couple of questions from our bot to get accurate results.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 16),

      /// IMAGE SECTION (Right)
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/step4.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
),



            const SizedBox(height: 24),





           Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(top: 24),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green.shade200.withOpacity(0.4),
        Colors.green.shade400.withOpacity(0.4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.green.shade100.withOpacity(0.5)),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TEXT SECTION (Left)
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Step 05',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'That’s it! Now you know the issue and how to cure it.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 16),

      /// IMAGE SECTION (Right)
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/step5.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  ),
),












            const SizedBox(height: 24),

            // Image Upload Section
            const Text(
              'Upload Plant Image',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Image Preview or Upload Area
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: _selectedImage != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: _clearImage,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Tap to upload image',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'JPG, PNG supported',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Upload Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Analyze Button
            if (_selectedImage != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isAnalyzing ? null : _analyzeImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isAnalyzing
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Analyzing...'),
                          ],
                        )
                      : const Text(
                          'Analyze Image',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),

            // Analysis Results
            if (_analysisResult != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Analysis Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildAnalysisResults(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisResults() {
    return Column(
      children: [
        // Disease Information
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _analysisResult!['severity'] == 'High'
                          ? Icons.warning
                          : _analysisResult!['severity'] == 'Medium'
                              ? Icons.error_outline
                              : Icons.check_circle,
                      color: _analysisResult!['severity'] == 'High'
                          ? Colors.red
                          : _analysisResult!['severity'] == 'Medium'
                              ? Colors.orange
                              : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _analysisResult!['disease'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Confidence: ${_analysisResult!['confidence']}%',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(_analysisResult!['description']),
              ],
            ),
          ),
        ),

        // Treatment Recommendations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.healing, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Treatment Recommendations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...(_analysisResult!['treatments'] as List<String>)
                    .map((treatment) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(child: Text(treatment)),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ),

        // Prevention Tips
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.shield, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Prevention Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...(_analysisResult!['prevention'] as List<String>)
                    .map((tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(child: Text(tip)),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromCamera();
                    },
                  ),
                  _buildSourceOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImageFromGallery();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
      _analysisResult = null;
    });
  }

  void _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _analysisResult = null; // Reset previous analysis
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error accessing camera: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _analysisResult = null; // Reset previous analysis
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error accessing gallery: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _analyzeImage() {
    setState(() {
      _isAnalyzing = true;
    });

    // Simulate AI analysis - in real app, call your AI service
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isAnalyzing = false;
        _analysisResult = {
          'disease': 'Tomato Leaf Blight',
          'confidence': 87,
          'severity': 'Medium',
          'description':
              'Early blight is a common fungal disease that affects tomato plants. It typically appears as dark spots with concentric rings on older leaves.',
          'treatments': [
            'Remove affected leaves immediately',
            'Apply copper-based fungicide every 7-14 days',
            'Improve air circulation around plants',
            'Water at soil level to avoid wetting leaves',
          ],
          'prevention': [
            'Rotate crops annually',
            'Use disease-resistant varieties',
            'Maintain proper plant spacing',
            'Apply mulch to prevent soil splash',
          ],
        };
      });
    });
  }
}
