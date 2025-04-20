/**
 * LifeCare Medical Center - Medical Record Form JavaScript
 * This file contains JavaScript functionality specific to the medical record form
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initFormValidation();
    initMedicationList();
    initDiagnosisTags();
    initFileUpload();
});

/**
 * Mobile Navigation Toggle
 */
function initMobileNavigation() {
    const navToggle = document.createElement('button');
    navToggle.className = 'nav-toggle';
    navToggle.innerHTML = '<span></span><span></span><span></span>';
    navToggle.setAttribute('aria-label', 'Toggle Navigation');
    
    const nav = document.querySelector('nav');
    if (nav) {
        nav.parentNode.insertBefore(navToggle, nav);
        
        navToggle.addEventListener('click', function() {
            nav.classList.toggle('active');
            navToggle.classList.toggle('active');
            document.body.classList.toggle('nav-open');
        });
    }
}

/**
 * Form Validation
 */
function initFormValidation() {
    const recordForm = document.querySelector('form');
    
    if (recordForm) {
        recordForm.addEventListener('submit', function(event) {
            let isValid = true;
            
            // Validate required fields
            const requiredFields = recordForm.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    highlightInvalidField(field, 'This field is required');
                } else {
                    removeInvalidHighlight(field);
                }
            });
            
            // Validate vital signs (numeric values)
            const vitalSignInputs = document.querySelectorAll('.vital-sign-item input');
            vitalSignInputs.forEach(input => {
                if (input.value.trim() && isNaN(input.value)) {
                    isValid = false;
                    highlightInvalidField(input, 'Please enter a valid number');
                }
            });
            
            if (!isValid) {
                event.preventDefault();
                
                // Scroll to first invalid field
                const firstInvalidField = recordForm.querySelector('.invalid');
                if (firstInvalidField) {
                    firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    }
}

/**
 * Highlight invalid form field
 */
function highlightInvalidField(field, message) {
    field.classList.add('invalid');
    
    // Create or update error message
    let errorMessage = field.parentNode.querySelector('.error-text');
    if (!errorMessage) {
        errorMessage = document.createElement('div');
        errorMessage.className = 'error-text';
        field.parentNode.appendChild(errorMessage);
    }
    errorMessage.textContent = message;
}

/**
 * Remove invalid highlight from form field
 */
function removeInvalidHighlight(field) {
    field.classList.remove('invalid');
    const errorMessage = field.parentNode.querySelector('.error-text');
    if (errorMessage) {
        errorMessage.remove();
    }
}

/**
 * Medication List
 */
function initMedicationList() {
    const medicationList = document.querySelector('.medication-list');
    const addMedicationButton = document.querySelector('.add-medication');
    
    if (medicationList && addMedicationButton) {
        // Add new medication
        addMedicationButton.addEventListener('click', function() {
            const newMedicationItem = document.createElement('div');
            newMedicationItem.className = 'medication-item';
            newMedicationItem.innerHTML = `
                <div class="form-group">
                    <input type="text" placeholder="Medication Name" class="medication-name">
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Dosage" class="medication-dosage">
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Frequency" class="medication-frequency">
                </div>
                <button type="button" class="remove-medication">×</button>
            `;
            
            medicationList.appendChild(newMedicationItem);
            
            // Focus on the new medication name input
            const newMedicationNameInput = newMedicationItem.querySelector('.medication-name');
            newMedicationNameInput.focus();
            
            // Add event listener to remove button
            const removeButton = newMedicationItem.querySelector('.remove-medication');
            removeButton.addEventListener('click', function() {
                newMedicationItem.remove();
            });
        });
        
        // Remove existing medications
        const removeButtons = document.querySelectorAll('.remove-medication');
        removeButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.closest('.medication-item').remove();
            });
        });
    }
}

/**
 * Diagnosis Tags
 */
function initDiagnosisTags() {
    const diagnosisInput = document.querySelector('.add-diagnosis input');
    const addDiagnosisButton = document.querySelector('.add-diagnosis button');
    const diagnosisTags = document.querySelector('.diagnosis-tags');
    
    if (diagnosisInput && addDiagnosisButton && diagnosisTags) {
        // Add new diagnosis tag
        const addDiagnosisTag = () => {
            const diagnosisText = diagnosisInput.value.trim();
            
            if (diagnosisText) {
                // Create new tag
                const newTag = document.createElement('div');
                newTag.className = 'diagnosis-tag';
                newTag.innerHTML = `
                    ${diagnosisText}
                    <button type="button" class="remove-tag">×</button>
                `;
                
                diagnosisTags.appendChild(newTag);
                
                // Clear input
                diagnosisInput.value = '';
                diagnosisInput.focus();
                
                // Add event listener to remove button
                const removeButton = newTag.querySelector('.remove-tag');
                removeButton.addEventListener('click', function() {
                    newTag.remove();
                });
            }
        };
        
        // Add tag on button click
        addDiagnosisButton.addEventListener('click', addDiagnosisTag);
        
        // Add tag on Enter key press
        diagnosisInput.addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                addDiagnosisTag();
            }
        });
        
        // Remove existing tags
        const removeButtons = document.querySelectorAll('.remove-tag');
        removeButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.closest('.diagnosis-tag').remove();
            });
        });
    }
}

/**
 * File Upload
 */
function initFileUpload() {
    const fileUpload = document.querySelector('.file-upload');
    const fileInput = document.querySelector('.file-upload input');
    const uploadedFiles = document.querySelector('.uploaded-files');
    
    if (fileUpload && fileInput && uploadedFiles) {
        // Open file dialog on click
        fileUpload.addEventListener('click', function() {
            fileInput.click();
        });
        
        // Handle file selection
        fileInput.addEventListener('change', function() {
            const files = this.files;
            
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                
                // Create file item
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                fileItem.innerHTML = `
                    <i class="fas fa-file"></i>
                    <div class="file-name">${file.name}</div>
                    <div class="file-size">${formatFileSize(file.size)}</div>
                    <button type="button" class="remove-file">×</button>
                `;
                
                uploadedFiles.appendChild(fileItem);
                
                // Add event listener to remove button
                const removeButton = fileItem.querySelector('.remove-file');
                removeButton.addEventListener('click', function() {
                    fileItem.remove();
                });
            }
            
            // Clear file input
            this.value = '';
        });
        
        // Format file size
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
    }
}
