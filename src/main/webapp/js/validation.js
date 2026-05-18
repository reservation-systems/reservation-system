/**
 * Restaurant Reservation System - Form Validation
 * Client-side validation for all forms
 */

// ============================================
// VALIDATION RULES
// ============================================

const ValidationRules = {
    // Email validation
    email: {
        pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        message: 'Please enter a valid email address'
    },

    // Phone validation (international format)
    phone: {
        pattern: /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/,
        message: 'Please enter a valid phone number'
    },

    // Password validation (min 8 chars, at least 1 letter and 1 number)
    password: {
        pattern: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$/,
        message: 'Password must be at least 8 characters with at least 1 letter and 1 number'
    },

    // Name validation (letters and spaces only)
    name: {
        pattern: /^[a-zA-Z\s]{2,50}$/,
        message: 'Name must be 2-50 characters and contain only letters'
    },

    // Required field
    required: {
        test: (value) => value.trim().length > 0,
        message: 'This field is required'
    },

    // Minimum length
    minLength: (min) => ({
        test: (value) => value.trim().length >= min,
        message: `Must be at least ${min} characters`
    }),

    // Maximum length
    maxLength: (max) => ({
        test: (value) => value.trim().length <= max,
        message: `Must be no more than ${max} characters`
    }),

    // Numeric only
    numeric: {
        pattern: /^\d+$/,
        message: 'Please enter numbers only'
    },

    // Date validation (must be future date)
    futureDate: {
        test: (value) => {
            const selectedDate = new Date(value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            return selectedDate >= today;
        },
        message: 'Please select a future date'
    },

    // Credit card validation (Luhn algorithm)
    creditCard: {
        pattern: /^\d{13,19}$/,
        message: 'Please enter a valid credit card number'
    },

    // CVV validation
    cvv: {
        pattern: /^\d{3,4}$/,
        message: 'CVV must be 3 or 4 digits'
    },

    // Expiry date validation (MM/YY format)
    expiryDate: {
        pattern: /^(0[1-9]|1[0-2])\/\d{2}$/,
        message: 'Please enter a valid expiry date (MM/YY)'
    }
};

// ============================================
// VALIDATION FUNCTIONS
// ============================================

/**
 * Validate a single field
 * @param {HTMLElement} field - The input field to validate
 * @param {Array} rules - Array of validation rules to apply
 * @returns {boolean} - Whether the field is valid
 */
function validateField(field, rules) {
    const value = field.value;
    let isValid = true;
    let errorMessage = '';

    for (const rule of rules) {
        if (rule.pattern) {
            if (!rule.pattern.test(value)) {
                isValid = false;
                errorMessage = rule.message;
                break;
            }
        } else if (rule.test) {
            if (!rule.test(value)) {
                isValid = false;
                errorMessage = rule.message;
                break;
            }
        }
    }

    // Update UI
    updateFieldValidationUI(field, isValid, errorMessage);

    return isValid;
}

/**
 * Update field validation UI
 * @param {HTMLElement} field - The input field
 * @param {boolean} isValid - Whether the field is valid
 * @param {string} errorMessage - Error message to display
 */
function updateFieldValidationUI(field, isValid, errorMessage) {
    // Remove existing error
    const existingError = field.parentElement.querySelector('.invalid-feedback');
    if (existingError) {
        existingError.remove();
    }

    // Update field styling
    field.classList.remove('is-invalid');

    if (!isValid) {
        field.classList.add('is-invalid');

        // Add error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'invalid-feedback';
        errorDiv.textContent = errorMessage;
        field.parentElement.appendChild(errorDiv);
    }
}

/**
 * Validate an entire form
 * @param {string} formId - ID of the form to validate
 * @returns {boolean} - Whether the form is valid
 */
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Get all fields with data-validate attribute
    const fields = form.querySelectorAll('[data-validate]');

    fields.forEach(field => {
        const validationTypes = field.dataset.validate.split(' ');
        const rules = [];

        validationTypes.forEach(type => {
            if (type.startsWith('min:')) {
                const min = parseInt(type.split(':')[1]);
                rules.push(ValidationRules.minLength(min));
            } else if (type.startsWith('max:')) {
                const max = parseInt(type.split(':')[1]);
                rules.push(ValidationRules.maxLength(max));
            } else if (ValidationRules[type]) {
                rules.push(ValidationRules[type]);
            }
        });

        if (!validateField(field, rules)) {
            isValid = false;
        }
    });

    return isValid;
}

/**
 * Clear all validation errors from a form
 * @param {string} formId - ID of the form
 */
function clearValidationErrors(formId) {
    const form = document.getElementById(formId);
    if (!form) return;

    form.querySelectorAll('.is-invalid').forEach(field => {
        field.classList.remove('is-invalid');
    });

    form.querySelectorAll('.invalid-feedback').forEach(error => {
        error.remove();
    });
}

// ============================================
// FORM-SPECIFIC VALIDATION
// ============================================

/**
 * Validate login form
 * @param {string} formId - ID of the login form
 * @returns {boolean} - Whether the form is valid
 */
function validateLoginForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    const email = form.querySelector('[name="email"]');
    const password = form.querySelector('[name="password"]');
    let isValid = true;

    if (email) {
        if (!validateField(email, [ValidationRules.required, ValidationRules.email])) {
            isValid = false;
        }
    }

    if (password) {
        if (!validateField(password, [ValidationRules.required, ValidationRules.minLength(6)])) {
            isValid = false;
        }
    }

    return isValid;
}

/**
 * Validate registration form
 * @param {string} formId - ID of the registration form
 * @returns {boolean} - Whether the form is valid
 */
function validateRegisterForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Validate first name
    const firstName = form.querySelector('[name="firstName"]');
    if (firstName && !validateField(firstName, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate last name
    const lastName = form.querySelector('[name="lastName"]');
    if (lastName && !validateField(lastName, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate email
    const email = form.querySelector('[name="email"]');
    if (email && !validateField(email, [ValidationRules.required, ValidationRules.email])) {
        isValid = false;
    }

    // Validate phone
    const phone = form.querySelector('[name="phone"]');
    if (phone && !validateField(phone, [ValidationRules.required, ValidationRules.phone])) {
        isValid = false;
    }

    // Validate password
    const password = form.querySelector('[name="password"]');
    if (password && !validateField(password, [ValidationRules.required, ValidationRules.password])) {
        isValid = false;
    }

    // Validate confirm password
    const confirmPassword = form.querySelector('[name="confirmPassword"]');
    if (confirmPassword && password) {
        if (confirmPassword.value !== password.value) {
            updateFieldValidationUI(confirmPassword, false, 'Passwords do not match');
            isValid = false;
        }
    }

    // Validate terms checkbox
    const terms = form.querySelector('[name="terms"]');
    if (terms && !terms.checked) {
        showError('You must agree to the terms and conditions');
        isValid = false;
    }

    return isValid;
}

/**
 * Validate reservation form
 * @param {string} formId - ID of the reservation form
 * @returns {boolean} - Whether the form is valid
 */
function validateReservationForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Validate date
    const date = form.querySelector('[name="date"]');
    if (date && !validateField(date, [ValidationRules.required, ValidationRules.futureDate])) {
        isValid = false;
    }

    // Validate time
    const time = form.querySelector('[name="time"]');
    if (time && !validateField(time, [ValidationRules.required])) {
        isValid = false;
    }

    // Validate guests
    const guests = form.querySelector('[name="guests"]');
    if (guests) {
        const guestsValue = parseInt(guests.value);
        if (isNaN(guestsValue) || guestsValue < 1 || guestsValue > 20) {
            updateFieldValidationUI(guests, false, 'Number of guests must be between 1 and 20');
            isValid = false;
        }
    }

    // Validate name
    const name = form.querySelector('[name="name"]');
    if (name && !validateField(name, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate email
    const email = form.querySelector('[name="email"]');
    if (email && !validateField(email, [ValidationRules.required, ValidationRules.email])) {
        isValid = false;
    }

    // Validate phone
    const phone = form.querySelector('[name="phone"]');
    if (phone && !validateField(phone, [ValidationRules.required, ValidationRules.phone])) {
        isValid = false;
    }

    return isValid;
}

/**
 * Validate payment form
 * @param {string} formId - ID of the payment form
 * @returns {boolean} - Whether the form is valid
 */
function validatePaymentForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Validate card number
    const cardNumber = form.querySelector('[name="cardNumber"]');
    if (cardNumber && !validateField(cardNumber, [ValidationRules.required, ValidationRules.creditCard])) {
        isValid = false;
    }

    // Validate cardholder name
    const cardName = form.querySelector('[name="cardName"]');
    if (cardName && !validateField(cardName, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate expiry date
    const expiry = form.querySelector('[name="expiry"]');
    if (expiry && !validateField(expiry, [ValidationRules.required, ValidationRules.expiryDate])) {
        isValid = false;
    }

    // Validate CVV
    const cvv = form.querySelector('[name="cvv"]');
    if (cvv && !validateField(cvv, [ValidationRules.required, ValidationRules.cvv])) {
        isValid = false;
    }

    return isValid;
}

/**
 * Validate profile form
 * @param {string} formId - ID of the profile form
 * @returns {boolean} - Whether the form is valid
 */
function validateProfileForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Validate first name
    const firstName = form.querySelector('[name="firstName"]');
    if (firstName && !validateField(firstName, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate last name
    const lastName = form.querySelector('[name="lastName"]');
    if (lastName && !validateField(lastName, [ValidationRules.required, ValidationRules.name])) {
        isValid = false;
    }

    // Validate email
    const email = form.querySelector('[name="email"]');
    if (email && !validateField(email, [ValidationRules.required, ValidationRules.email])) {
        isValid = false;
    }

    // Validate phone
    const phone = form.querySelector('[name="phone"]');
    if (phone && !validateField(phone, [ValidationRules.required, ValidationRules.phone])) {
        isValid = false;
    }

    return isValid;
}

/**
 * Validate review form
 * @param {string} formId - ID of the review form
 * @returns {boolean} - Whether the form is valid
 */
function validateReviewForm(formId) {
    clearValidationErrors(formId);

    const form = document.getElementById(formId);
    if (!form) return false;

    let isValid = true;

    // Validate rating
    const rating = form.querySelector('[name="rating"]');
    if (rating && (!rating.value || rating.value < 1)) {
        showError('Please select a rating');
        isValid = false;
    }

    // Validate review text
    const review = form.querySelector('[name="review"]');
    if (review && !validateField(review, [ValidationRules.required, ValidationRules.minLength(10)])) {
        isValid = false;
    }

    return isValid;
}

// ============================================
// REAL-TIME VALIDATION
// ============================================

/**
 * Initialize real-time validation for a form
 * @param {string} formId - ID of the form
 */
function initRealTimeValidation(formId) {
    const form = document.getElementById(formId);
    if (!form) return;

    const fields = form.querySelectorAll('[data-validate]');

    fields.forEach(field => {
        // Validate on blur
        field.addEventListener('blur', () => {
            const validationTypes = field.dataset.validate.split(' ');
            const rules = [];

            validationTypes.forEach(type => {
                if (type.startsWith('min:')) {
                    const min = parseInt(type.split(':')[1]);
                    rules.push(ValidationRules.minLength(min));
                } else if (type.startsWith('max:')) {
                    const max = parseInt(type.split(':')[1]);
                    rules.push(ValidationRules.maxLength(max));
                } else if (ValidationRules[type]) {
                    rules.push(ValidationRules[type]);
                }
            });

            validateField(field, rules);
        });

        // Clear error on input
        field.addEventListener('input', () => {
            field.classList.remove('is-invalid');
            const error = field.parentElement.querySelector('.invalid-feedback');
            if (error) {
                error.remove();
            }
        });
    });
}

// ============================================
// INITIALIZATION
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize real-time validation for all forms
    const forms = document.querySelectorAll('form[data-validate]');
    forms.forEach(form => {
        initRealTimeValidation(form.id);
    });
});
