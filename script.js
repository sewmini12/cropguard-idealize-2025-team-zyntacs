// CropGuard JavaScript

document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

function initializeApp() {
    setupNavigation();
    setupImageUpload();
    setupCommunityFeatures();
    setupWeatherFeatures();
    setupProfileFeatures();
}

// Navigation
function setupNavigation() {
    const navButtons = document.querySelectorAll('.nav-btn');
    const screens = document.querySelectorAll('.screen');
    const actionCards = document.querySelectorAll('.action-card');

    navButtons.forEach(button => {
        button.addEventListener('click', () => {
            const targetScreen = button.dataset.screen;
            switchScreen(targetScreen);
            
            // Update active nav button
            navButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });

    // Quick action navigation
    actionCards.forEach(card => {
        card.addEventListener('click', () => {
            const action = card.dataset.action;
            if (action) {
                switchScreen(action);
                // Update nav button
                navButtons.forEach(btn => btn.classList.remove('active'));
                document.querySelector(`[data-screen="${action}"]`).classList.add('active');
            }
        });
    });
}

function switchScreen(screenName) {
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => screen.classList.remove('active'));
    
    const targetScreen = document.getElementById(`${screenName}-screen`);
    if (targetScreen) {
        targetScreen.classList.add('active');
    }
}

// Image Upload and Analysis
function setupImageUpload() {
    const uploadArea = document.getElementById('upload-area');
    const fileInput = document.getElementById('file-input');
    const analyzeBtn = document.getElementById('analyze-btn');
    const analysisResults = document.getElementById('analysis-results');

    if (fileInput) {
        fileInput.addEventListener('change', handleFileSelect);
    }

    if (uploadArea) {
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#2e7d32';
            uploadArea.style.backgroundColor = '#f1f8e9';
        });

        uploadArea.addEventListener('dragleave', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#ccc';
            uploadArea.style.backgroundColor = '#fafafa';
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#ccc';
            uploadArea.style.backgroundColor = '#fafafa';
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                handleFile(files[0]);
            }
        });
    }

    if (analyzeBtn) {
        analyzeBtn.addEventListener('click', analyzeImage);
    }
}

function handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
        handleFile(file);
    }
}

function handleFile(file) {
    if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const uploadArea = document.getElementById('upload-area');
            uploadArea.innerHTML = `
                <img src="${e.target.result}" alt="Uploaded plant image" style="max-width: 100%; max-height: 200px; border-radius: 8px;">
                <p style="margin-top: 1rem;">Image uploaded successfully!</p>
            `;
            
            const analyzeBtn = document.getElementById('analyze-btn');
            analyzeBtn.style.display = 'inline-flex';
        };
        reader.readAsDataURL(file);
    } else {
        showNotification('Please select a valid image file (JPG, PNG)', 'error');
    }
}

function analyzeImage() {
    const analyzeBtn = document.getElementById('analyze-btn');
    const analysisResults = document.getElementById('analysis-results');
    
    // Show loading state
    analyzeBtn.innerHTML = `
        <span class="material-icons">hourglass_empty</span>
        Analyzing...
    `;
    analyzeBtn.disabled = true;

    // Simulate AI analysis
    setTimeout(() => {
        analysisResults.style.display = 'block';
        analysisResults.scrollIntoView({ behavior: 'smooth' });
        
        analyzeBtn.innerHTML = `
            <span class="material-icons">search</span>
            Analyze Again
        `;
        analyzeBtn.disabled = false;
        
        showNotification('Analysis complete! Check the results below.', 'success');
    }, 3000);
}

// Community Features
function setupCommunityFeatures() {
    setupTabs();
    setupPostActions();
    setupCreatePost();
}

function setupTabs() {
    const tabButtons = document.querySelectorAll('.tab-btn');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            tabButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // In a real app, this would filter posts
            console.log(`Switched to ${button.dataset.tab} tab`);
        });
    });
}

function setupPostActions() {
    const actionButtons = document.querySelectorAll('.action-btn');
    
    actionButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            const action = button.querySelector('.material-icons').textContent;
            
            if (action === 'thumb_up') {
                handleLike(button);
            } else if (action === 'comment') {
                handleComment(button);
            } else if (action === 'share') {
                handleShare(button);
            }
        });
    });
}

function handleLike(button) {
    const likeCount = button.childNodes[1];
    const currentCount = parseInt(likeCount.textContent.trim());
    likeCount.textContent = ` ${currentCount + 1}`;
    
    button.style.color = '#2e7d32';
    showNotification('Post liked!', 'success');
}

function handleComment(button) {
    showNotification('Comment feature would open here', 'info');
}

function handleShare(button) {
    showNotification('Post shared!', 'success');
}

function setupCreatePost() {
    const createPostBtn = document.getElementById('create-post-btn');
    
    if (createPostBtn) {
        createPostBtn.addEventListener('click', () => {
            showCreatePostModal();
        });
    }
}

function showCreatePostModal() {
    const modal = document.createElement('div');
    modal.className = 'modal-overlay';
    modal.innerHTML = `
        <div class="modal">
            <div class="modal-header">
                <h3>Create New Post</h3>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <textarea placeholder="Share your tip, problem, or question..." rows="4"></textarea>
                <select>
                    <option value="tip">Tip</option>
                    <option value="problem">Problem</option>
                    <option value="question">Question</option>
                </select>
                <input type="text" placeholder="Add tags (comma separated)">
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button class="btn btn-primary" onclick="createPost()">Post</button>
            </div>
        </div>
    `;
    
    // Add modal styles
    const style = document.createElement('style');
    style.textContent = `
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .modal {
            background: white;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            max-height: 80vh;
            overflow-y: auto;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        .modal-body {
            padding: 1rem;
        }
        .modal-body textarea, .modal-body select, .modal-body input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 1rem;
            font-family: inherit;
        }
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding: 1rem;
            border-top: 1px solid #eee;
        }
        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }
    `;
    document.head.appendChild(style);
    document.body.appendChild(modal);
}

function closeModal() {
    const modal = document.querySelector('.modal-overlay');
    if (modal) {
        modal.remove();
    }
}

function createPost() {
    closeModal();
    showNotification('Post created successfully!', 'success');
}

// Weather Features
function setupWeatherFeatures() {
    // Simulate weather data updates
    setInterval(updateWeatherData, 30000); // Update every 30 seconds
}

function updateWeatherData() {
    // In a real app, this would fetch from weather API
    console.log('Weather data updated');
}

// Profile Features
function setupProfileFeatures() {
    setupAchievements();
    setupSettings();
}

function setupAchievements() {
    const achievementCards = document.querySelectorAll('.achievement-card');
    
    achievementCards.forEach(card => {
        card.addEventListener('click', () => {
            if (card.classList.contains('earned')) {
                showNotification('Achievement unlocked!', 'success');
            } else {
                showNotification('Keep working towards this achievement!', 'info');
            }
        });
    });
}

function setupSettings() {
    // Add settings functionality here
}

// Utility Functions
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    const style = document.createElement('style');
    style.textContent = `
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            color: white;
            font-weight: 500;
            z-index: 1001;
            animation: slideIn 0.3s ease-out;
        }
        .notification.success {
            background: #4caf50;
        }
        .notification.error {
            background: #f44336;
        }
        .notification.info {
            background: #2196f3;
        }
        .notification.warning {
            background: #ff9800;
        }
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    `;
    
    if (!document.querySelector('style[data-notifications]')) {
        style.setAttribute('data-notifications', 'true');
        document.head.appendChild(style);
    }
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Search functionality
function setupSearch() {
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase();
            // Implement search logic here
            console.log('Searching for:', query);
        });
    }
}

// Data persistence
function saveToLocalStorage(key, data) {
    localStorage.setItem(key, JSON.stringify(data));
}

function loadFromLocalStorage(key) {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : null;
}

// Initialize user preferences
function loadUserPreferences() {
    const preferences = loadFromLocalStorage('cropguard_preferences');
    if (preferences) {
        // Apply saved preferences
        console.log('Loaded user preferences:', preferences);
    }
}

// Save user preferences
function saveUserPreferences() {
    const preferences = {
        theme: 'light',
        notifications: true,
        location: 'auto'
    };
    saveToLocalStorage('cropguard_preferences', preferences);
}

// Weather API simulation
async function fetchWeatherData(location) {
    // Simulate API call
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve({
                temperature: 24,
                humidity: 65,
                windSpeed: 8,
                condition: 'Partly Cloudy',
                location: location || 'San Francisco, CA'
            });
        }, 1000);
    });
}

// Disease detection API simulation
async function detectDisease(imageData) {
    // Simulate AI analysis
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve({
                disease: 'Tomato Late Blight',
                confidence: 87,
                severity: 'Medium',
                treatments: [
                    'Remove affected leaves immediately',
                    'Apply copper-based fungicide',
                    'Improve air circulation',
                    'Water at soil level'
                ]
            });
        }, 3000);
    });
}

// Export functions for global access
window.closeModal = closeModal;
window.createPost = createPost;
