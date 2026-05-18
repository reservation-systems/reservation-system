/**
 * Restaurant Reservation System - Main JavaScript
 * Frontend functionality for customer and admin pages
 */

// ============================================
// UTILITY FUNCTIONS
// ============================================

/**
 * Show a confirmation dialog
 * @param {string} message - The message to display
 * @param {Function} onConfirm - Callback when user confirms
 * @param {Function} onCancel - Callback when user cancels
 */
function showConfirm(message, onConfirm, onCancel) {
    const overlay = document.createElement('div');
    overlay.className = 'modal-overlay active';
    overlay.innerHTML = `
        <div class="modal">
            <div class="modal-header">
                <h3>Confirm Action</h3>
                <button class="modal-close" onclick="closeModal(this)">&times;</button>
            </div>
            <div class="modal-body">
                <p>${message}</p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline" onclick="closeModal(this)">Cancel</button>
                <button class="btn btn-danger" id="confirm-btn">Confirm</button>
            </div>
        </div>
    `;
    document.body.appendChild(overlay);

    const confirmBtn = overlay.querySelector('#confirm-btn');
    confirmBtn.addEventListener('click', () => {
        closeModal(confirmBtn);
        if (onConfirm) onConfirm();
    });

    const cancelBtn = overlay.querySelector('.btn-outline');
    cancelBtn.addEventListener('click', () => {
        if (onCancel) onCancel();
    });
}

/**
 * Show a success message
 * @param {string} message - The message to display
 */
function showSuccess(message) {
    showAlert(message, 'success');
}

/**
 * Show an error message
 * @param {string} message - The message to display
 */
function showError(message) {
    showAlert(message, 'danger');
}

/**
 * Show an alert message
 * @param {string} message - The message to display
 * @param {string} type - Alert type (success, danger, warning, info)
 */
function showAlert(message, type = 'info') {
    const alert = document.createElement('div');
    alert.className = `alert alert-${type}`;
    alert.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle'}"></i>
        ${message}
    `;

    const container = document.querySelector('.container') || document.body;
    container.insertBefore(alert, container.firstChild);

    setTimeout(() => {
        alert.remove();
    }, 5000);
}

/**
 * Close a modal
 * @param {HTMLElement} element - Element inside the modal
 */
function closeModal(element) {
    const overlay = element.closest('.modal-overlay');
    if (overlay) {
        overlay.remove();
    }
}

/**
 * Toggle mobile menu
 */
function toggleMobileMenu() {
    const navMenu = document.querySelector('.nav-menu');
    if (navMenu) {
        navMenu.classList.toggle('active');
    }
}

/**
 * Toggle admin sidebar
 */
function toggleSidebar() {
    const sidebar = document.querySelector('.admin-sidebar');
    const main = document.querySelector('.admin-main');

    if (sidebar && main) {
        sidebar.classList.toggle('collapsed');
        main.classList.toggle('expanded');

        // Create or remove overlay
        let overlay = document.querySelector('.sidebar-overlay');
        if (sidebar.classList.contains('collapsed')) {
            if (!overlay) {
                overlay = document.createElement('div');
                overlay.className = 'sidebar-overlay';
                overlay.onclick = toggleSidebar;
                document.body.appendChild(overlay);
            }
            setTimeout(() => overlay.classList.add('active'), 10);
        } else if (overlay) {
            overlay.classList.remove('active');
            setTimeout(() => overlay.remove(), 300);
        }
    }
}

// ============================================
// SEARCH & FILTER FUNCTIONS
// ============================================

/**
 * Search table rows
 * @param {string} inputId - ID of the search input
 * @param {string} tableId - ID of the table to search
 * @param {number} columnIndex - Column index to search (optional)
 */
function searchTable(inputId, tableId, columnIndex = null) {
    const input = document.getElementById(inputId);
    const table = document.getElementById(tableId);

    if (!input || !table) return;

    const filter = input.value.toLowerCase();
    const rows = table.querySelectorAll('tbody tr');

    rows.forEach(row => {
        let text = '';
        if (columnIndex !== null) {
            const cell = row.cells[columnIndex];
            if (cell) text = cell.textContent || cell.innerText;
        } else {
            text = row.textContent || row.innerText;
        }

        row.style.display = text.toLowerCase().includes(filter) ? '' : 'none';
    });
}

/**
 * Filter table by status
 * @param {string} selectId - ID of the filter select
 * @param {string} tableId - ID of the table to filter
 * @param {number} statusColumnIndex - Column index containing status
 */
function filterByStatus(selectId, tableId, statusColumnIndex) {
    const select = document.getElementById(selectId);
    const table = document.getElementById(tableId);

    if (!select || !table) return;

    const filter = select.value.toLowerCase();
    const rows = table.querySelectorAll('tbody tr');

    rows.forEach(row => {
        const statusCell = row.cells[statusColumnIndex];
        if (!statusCell) return;

        const status = statusCell.textContent.toLowerCase();
        row.style.display = (filter === '' || status === filter) ? '' : 'none';
    });
}

// ============================================
// FORM FUNCTIONS
// ============================================

/**
 * Clear form fields
 * @param {string} formId - ID of the form to clear
 */
function clearForm(formId) {
    const form = document.getElementById(formId);
    if (form) {
        form.reset();
        // Clear validation states
        form.querySelectorAll('.is-invalid').forEach(el => {
            el.classList.remove('is-invalid');
        });
        form.querySelectorAll('.invalid-feedback').forEach(el => {
            el.remove();
        });
    }
}

/**
 * Show loading state on button
 * @param {HTMLElement} button - The button element
 * @param {boolean} loading - Whether to show loading
 */
function setButtonLoading(button, loading) {
    if (loading) {
        button.dataset.originalText = button.innerHTML;
        button.innerHTML = '<span class="spinner" style="width: 20px; height: 20px; border-width: 2px;"></span> Loading...';
        button.disabled = true;
    } else {
        button.innerHTML = button.dataset.originalText || 'Submit';
        button.disabled = false;
    }
}

// ============================================
// TAB FUNCTIONS
// ============================================

/**
 * Switch between tabs
 * @param {string} tabId - ID of the tab to show
 * @param {HTMLElement} trigger - The element that triggered the tab switch
 */
function switchTab(tabId, trigger) {
    // Hide all tab contents
    const tabContents = document.querySelectorAll('.tab-content');
    tabContents.forEach(content => {
        content.classList.remove('active');
    });

    // Remove active class from all tab triggers
    const tabTriggers = document.querySelectorAll('.tab-trigger');
    tabTriggers.forEach(t => {
        t.classList.remove('active');
    });

    // Show selected tab
    const selectedTab = document.getElementById(tabId);
    if (selectedTab) {
        selectedTab.classList.add('active');
    }

    // Add active class to trigger
    if (trigger) {
        trigger.classList.add('active');
    }
}

// ============================================
// RATING FUNCTIONS
// ============================================

/**
 * Initialize star rating
 * @param {string} containerId - ID of the rating container
 */
function initStarRating(containerId) {
    const container = document.getElementById(containerId);
    if (!container) return;

    const stars = container.querySelectorAll('i');
    let selectedRating = 0;

    stars.forEach((star, index) => {
        // Hover effect
        star.addEventListener('mouseenter', () => {
            stars.forEach((s, i) => {
                s.classList.toggle('active', i <= index);
            });
        });

        // Click to select
        star.addEventListener('click', () => {
            selectedRating = index + 1;
            stars.forEach((s, i) => {
                s.classList.toggle('active', i < selectedRating);
            });

            // Update hidden input if exists
            const ratingInput = document.getElementById('rating-value');
            if (ratingInput) {
                ratingInput.value = selectedRating;
            }
        });
    });

    // Reset on mouse leave
    container.addEventListener('mouseleave', () => {
        stars.forEach((s, i) => {
            s.classList.toggle('active', i < selectedRating);
        });
    });
}

// ============================================
// NOTIFICATION FUNCTIONS
// ============================================

/**
 * Show a toast notification
 * @param {string} message - The message to display
 * @param {string} type - Notification type (success, error, warning, info)
 */
function showToast(message, type = 'info') {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
        <span>${message}</span>
    `;

    // Add toast styles
    toast.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: ${type === 'success' ? '#27ae60' : type === 'error' ? '#e74c3c' : type === 'warning' ? '#f39c12' : '#3498db'};
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 8px;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 10000;
        animation: slideIn 0.3s ease;
    `;

    document.body.appendChild(toast);

    setTimeout(() => {
        toast.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// ============================================
// INITIALIZATION
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize mobile menu toggle
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', toggleMobileMenu);
    }

    // Initialize sidebar toggle
    const sidebarToggle = document.querySelector('.sidebar-toggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', toggleSidebar);
    }

    // Initialize star ratings
    const ratingContainers = document.querySelectorAll('.rating-input');
    ratingContainers.forEach((container, index) => {
        container.id = container.id || `rating-${index}`;
        initStarRating(container.id);
    });

    // Add smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add animation keyframes
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
    `;
    document.head.appendChild(style);
});

// ============================================
// DEMO DATA FUNCTIONS
// ============================================

/**
 * Demo function to simulate adding a menu item to preorder
 * @param {string} itemName - Name of the menu item
 */
function addToPreorder(itemName) {
    showToast(`"${itemName}" added to your preorder!`, 'success');
}

/**
 * Demo function to simulate reservation cancellation
 * @param {string} reservationId - ID of the reservation
 */
function cancelReservation(reservationId) {
    showConfirm(
        'Are you sure you want to cancel this reservation?',
        () => {
            showToast('Reservation cancelled successfully', 'success');
            // In a real app, this would update the backend
            const row = document.querySelector(`[data-reservation-id="${reservationId}"]`);
            if (row) {
                row.classList.add('cancelled');
                const statusBadge = row.querySelector('.badge');
                if (statusBadge) {
                    statusBadge.className = 'badge badge-cancelled';
                    statusBadge.textContent = 'Cancelled';
                }
            }
        }
    );
}

/**
 * Demo function to simulate deleting an item
 * @param {string} itemType - Type of item being deleted
 * @param {string} itemName - Name of the item
 */
function deleteItem(itemType, itemName) {
    showConfirm(
        `Are you sure you want to delete this ${itemType}: "${itemName}"?`,
        () => {
            showToast(`${itemType} deleted successfully`, 'success');
        }
    );
}

/**
 * Demo function to simulate saving changes
 * @param {string} formId - ID of the form being saved
 */
function saveChanges(formId) {
    const form = document.getElementById(formId);
    if (form) {
        const submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn) {
            setButtonLoading(submitBtn, true);

            setTimeout(() => {
                setButtonLoading(submitBtn, false);
                showToast('Changes saved successfully!', 'success');
            }, 1500);
        }
    }
}
