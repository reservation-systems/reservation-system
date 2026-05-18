/**
 * Restaurant Reservation System - Admin JavaScript
 * Admin-specific functionality
 */

// ============================================
// ADMIN DASHBOARD FUNCTIONS
// ============================================

/**
 * Update dashboard statistics (demo)
 */
function updateDashboardStats() {
    // Simulate real-time stat updates
    const statElements = document.querySelectorAll('.stat-card .info h3');

    statElements.forEach(el => {
        const currentValue = parseInt(el.textContent.replace(/,/g, ''));
        if (!isNaN(currentValue)) {
            // Random fluctuation between -5 and +5
            const change = Math.floor(Math.random() * 11) - 5;
            const newValue = currentValue + change;
            el.textContent = newValue.toLocaleString();
        }
    });
}

/**
 * Initialize chart placeholders
 */
function initCharts() {
    const chartPlaceholders = document.querySelectorAll('.chart-placeholder');

    chartPlaceholders.forEach(placeholder => {
        // Add interactive hover effect
        placeholder.addEventListener('mouseenter', () => {
            placeholder.style.background = 'linear-gradient(135deg, #e5c76b20, #c9a22720)';
        });

        placeholder.addEventListener('mouseleave', () => {
            placeholder.style.background = '';
        });
    });
}

// ============================================
// TABLE MANAGEMENT FUNCTIONS
// ============================================

/**
 * Change table status
 * @param {HTMLElement} tableCard - The table card element
 * @param {string} newStatus - New status (available, occupied, reserved)
 */
function changeTableStatus(tableCard, newStatus) {
    // Remove all status classes
    tableCard.classList.remove('available', 'occupied', 'reserved');

    // Add new status class
    tableCard.classList.add(newStatus);

    // Show notification
    const tableNumber = tableCard.querySelector('.table-number').textContent;
    showToast(`Table ${tableNumber} is now ${newStatus}`, 'success');
}

/**
 * Toggle table status on click
 * @param {HTMLElement} tableCard - The table card element
 */
function toggleTableStatus(tableCard) {
    const statuses = ['available', 'occupied', 'reserved'];
    let currentStatus = '';

    for (const status of statuses) {
        if (tableCard.classList.contains(status)) {
            currentStatus = status;
            break;
        }
    }

    const currentIndex = statuses.indexOf(currentStatus);
    const nextIndex = (currentIndex + 1) % statuses.length;
    const nextStatus = statuses[nextIndex];

    changeTableStatus(tableCard, nextStatus);
}

// ============================================
// CUSTOMER MANAGEMENT FUNCTIONS
// ============================================

/**
 * View customer details
 * @param {number} customerId - Customer ID
 */
function viewCustomer(customerId) {
    // Demo: Show customer details in modal
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal">
                <div class="modal-header">
                    <h3>Customer Details</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="user-cell" style="margin-bottom: 1.5rem;">
                        <div class="user-avatar">JD</div>
                        <div class="user-info">
                            <p><strong>John Doe</strong></p>
                            <p class="email">john.doe@example.com</p>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Phone</label>
                            <p>+1 (555) 123-4567</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Member Since</label>
                            <p>January 15, 2024</p>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Total Reservations</label>
                            <p>24</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Loyalty Points</label>
                            <p>2,450</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Membership Level</label>
                        <span class="badge badge-confirmed">Gold Member</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Close</button>
                    <button class="btn btn-primary" onclick="editCustomer(${customerId})">Edit</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Edit customer
 * @param {number} customerId - Customer ID
 */
function editCustomer(customerId) {
    closeModal(document.querySelector('.modal-close'));
    showToast('Edit customer form would open here', 'info');
}

/**
 * Delete customer
 * @param {number} customerId - Customer ID
 * @param {string} customerName - Customer name
 */
function deleteCustomer(customerId, customerName) {
    showConfirm(
        `Are you sure you want to delete customer "${customerName}"?`,
        () => {
            showToast('Customer deleted successfully', 'success');
            // Remove row from table
            const row = document.querySelector(`tr[data-customer-id="${customerId}"]`);
            if (row) {
                row.remove();
            }
        }
    );
}

// ============================================
// RESERVATION MANAGEMENT FUNCTIONS
// ============================================

/**
 * View reservation details
 * @param {number} reservationId - Reservation ID
 */
function viewReservation(reservationId) {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 600px;">
                <div class="modal-header">
                    <h3>Reservation Details</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="reservation-info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label class="form-label">Reservation ID</label>
                            <p>#RES-${String(reservationId).padStart(4, '0')}</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Status</label>
                            <span class="badge badge-confirmed">Confirmed</span>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Customer</label>
                            <p>John Doe</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Contact</label>
                            <p>+1 (555) 123-4567</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Date</label>
                            <p>December 25, 2024</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Time</label>
                            <p>7:00 PM</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Guests</label>
                            <p>4 people</p>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Table</label>
                            <p>Table 5 (Window)</p>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 1rem;">
                        <label class="form-label">Special Requests</label>
                        <p>Anniversary dinner. Please prepare a small dessert with candle.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Close</button>
                    <button class="btn btn-success" onclick="confirmReservation(${reservationId})">Confirm</button>
                    <button class="btn btn-danger" onclick="cancelReservationAdmin(${reservationId})">Cancel</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Confirm a reservation
 * @param {number} reservationId - Reservation ID
 */
function confirmReservation(reservationId) {
    closeModal(document.querySelector('.modal-close'));
    showToast('Reservation confirmed successfully', 'success');
}

/**
 * Cancel a reservation (admin)
 * @param {number} reservationId - Reservation ID
 */
function cancelReservationAdmin(reservationId) {
    closeModal(document.querySelector('.modal-close'));
    showConfirm(
        'Are you sure you want to cancel this reservation?',
        () => {
            showToast('Reservation cancelled successfully', 'success');
        }
    );
}

// ============================================
// MENU MANAGEMENT FUNCTIONS
// ============================================

/**
 * Add new menu item
 */
function addMenuItem() {
    showToast('Add menu item form would open here', 'info');
}

/**
 * Edit menu item
 * @param {number} itemId - Menu item ID
 */
function editMenuItem(itemId) {
    showToast(`Editing menu item #${itemId}`, 'info');
}

/**
 * Delete menu item
 * @param {number} itemId - Menu item ID
 * @param {string} itemName - Menu item name
 */
function deleteMenuItem(itemId, itemName) {
    showConfirm(
        `Are you sure you want to delete "${itemName}"?`,
        () => {
            showToast('Menu item deleted successfully', 'success');
            const card = document.querySelector(`[data-item-id="${itemId}"]`);
            if (card) {
                card.remove();
            }
        }
    );
}

/**
 * Toggle menu item availability
 * @param {number} itemId - Menu item ID
 */
function toggleMenuItem(itemId) {
    const card = document.querySelector(`[data-item-id="${itemId}"]`);
    if (card) {
        const badge = card.querySelector('.status-badge');
        if (badge) {
            const isAvailable = badge.classList.contains('badge-confirmed');
            if (isAvailable) {
                badge.className = 'badge badge-cancelled';
                badge.textContent = 'Unavailable';
                showToast('Item marked as unavailable', 'warning');
            } else {
                badge.className = 'badge badge-confirmed';
                badge.textContent = 'Available';
                showToast('Item marked as available', 'success');
            }
        }
    }
}

// ============================================
// STAFF MANAGEMENT FUNCTIONS
// ============================================

/**
 * Add new staff member
 */
function addStaff() {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Add New Staff Member</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" placeholder="Enter full name">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input type="tel" class="form-control" placeholder="Enter phone number">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Role</label>
                        <select class="form-control">
                            <option>Select Role</option>
                            <option>Manager</option>
                            <option>Chef</option>
                            <option>Waiter</option>
                            <option>Host</option>
                            <option>Bartender</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Shift</label>
                        <select class="form-control">
                            <option>Select Shift</option>
                            <option>Morning (6AM - 2PM)</option>
                            <option>Evening (2PM - 10PM)</option>
                            <option>Night (10PM - 6AM)</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Cancel</button>
                    <button class="btn btn-primary" onclick="saveStaff()">Save</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Save staff member
 */
function saveStaff() {
    closeModal(document.querySelector('.modal-close'));
    showToast('Staff member added successfully', 'success');
}

/**
 * Edit staff member
 * @param {number} staffId - Staff ID
 */
function editStaff(staffId) {
    showToast(`Editing staff member #${staffId}`, 'info');
}

/**
 * Delete staff member
 * @param {number} staffId - Staff ID
 * @param {string} staffName - Staff name
 */
function deleteStaff(staffId, staffName) {
    showConfirm(
        `Are you sure you want to remove "${staffName}"?`,
        () => {
            showToast('Staff member removed successfully', 'success');
            const card = document.querySelector(`[data-staff-id="${staffId}"]`);
            if (card) {
                card.remove();
            }
        }
    );
}

// ============================================
// OFFERS MANAGEMENT FUNCTIONS
// ============================================

/**
 * Add new offer
 */
function addOffer() {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Add New Offer</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Offer Name</label>
                        <input type="text" class="form-control" placeholder="e.g., Summer Special">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" rows="3" placeholder="Enter offer description"></textarea>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Discount Type</label>
                            <select class="form-control">
                                <option>Percentage</option>
                                <option>Fixed Amount</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Discount Value</label>
                            <input type="number" class="form-control" placeholder="e.g., 20">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Valid From</label>
                            <input type="date" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Valid Until</label>
                            <input type="date" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Terms & Conditions</label>
                        <textarea class="form-control" rows="2" placeholder="Enter terms"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Cancel</button>
                    <button class="btn btn-primary" onclick="saveOffer()">Save Offer</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Save offer
 */
function saveOffer() {
    closeModal(document.querySelector('.modal-close'));
    showToast('Offer created successfully', 'success');
}

/**
 * Edit offer
 * @param {number} offerId - Offer ID
 */
function editOffer(offerId) {
    showToast(`Editing offer #${offerId}`, 'info');
}

/**
 * Delete offer
 * @param {number} offerId - Offer ID
 * @param {string} offerName - Offer name
 */
function deleteOffer(offerId, offerName) {
    showConfirm(
        `Are you sure you want to delete "${offerName}"?`,
        () => {
            showToast('Offer deleted successfully', 'success');
        }
    );
}

// ============================================
// REVIEWS MANAGEMENT FUNCTIONS
// ============================================

/**
 * Approve review
 * @param {number} reviewId - Review ID
 */
function approveReview(reviewId) {
    showToast('Review approved and published', 'success');
}

/**
 * Delete review
 * @param {number} reviewId - Review ID
 */
function deleteReview(reviewId) {
    showConfirm(
        'Are you sure you want to delete this review?',
        () => {
            showToast('Review deleted successfully', 'success');
            const review = document.querySelector(`[data-review-id="${reviewId}"]`);
            if (review) {
                review.remove();
            }
        }
    );
}

/**
 * Reply to review
 * @param {number} reviewId - Review ID
 */
function replyToReview(reviewId) {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Reply to Review</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Your Reply</label>
                        <textarea class="form-control" rows="4" placeholder="Write your response..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Cancel</button>
                    <button class="btn btn-primary" onclick="submitReply(${reviewId})">Post Reply</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Submit reply
 * @param {number} reviewId - Review ID
 */
function submitReply(reviewId) {
    closeModal(document.querySelector('.modal-close'));
    showToast('Reply posted successfully', 'success');
}

// ============================================
// PAYMENT MANAGEMENT FUNCTIONS
// ============================================

/**
 * View payment details
 * @param {number} paymentId - Payment ID
 */
function viewPayment(paymentId) {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Payment Details</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Transaction ID</label>
                        <p>#TXN-${String(paymentId).padStart(6, '0')}</p>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Customer</label>
                        <p>John Doe</p>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Amount</label>
                        <p style="font-size: 1.5rem; color: var(--primary-color); font-weight: 700;">$125.00</p>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Payment Method</label>
                        <p><i class="fas fa-credit-card"></i> Visa ending in 4242</p>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <span class="badge badge-confirmed">Completed</span>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <p>December 20, 2024 at 7:30 PM</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Close</button>
                    <button class="btn btn-primary" onclick="printReceipt(${paymentId})">Print Receipt</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Print receipt
 * @param {number} paymentId - Payment ID
 */
function printReceipt(paymentId) {
    showToast('Printing receipt...', 'info');
}

/**
 * Process refund
 * @param {number} paymentId - Payment ID
 */
function processRefund(paymentId) {
    showConfirm(
        'Are you sure you want to process a refund for this payment?',
        () => {
            showToast('Refund processed successfully', 'success');
        }
    );
}

// ============================================
// MEMBERSHIP MANAGEMENT FUNCTIONS
// ============================================

/**
 * Edit membership tier
 * @param {string} tier - Tier name (bronze, silver, gold)
 */
function editMembershipTier(tier) {
    showToast(`Editing ${tier} tier settings`, 'info');
}

/**
 * View tier members
 * @param {string} tier - Tier name
 */
function viewTierMembers(tier) {
    showToast(`Viewing all ${tier} members`, 'info');
}

// ============================================
// INITIALIZATION
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize charts
    initCharts();

    // Initialize table cards
    const tableCards = document.querySelectorAll('.table-card');
    tableCards.forEach(card => {
        card.addEventListener('click', () => toggleTableStatus(card));
    });

    // Simulate real-time stats update (every 30 seconds)
    if (document.querySelector('.admin-dashboard')) {
        setInterval(updateDashboardStats, 30000);
    }
});
