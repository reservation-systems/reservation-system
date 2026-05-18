/**
 * Restaurant Reservation System - Reservation JavaScript
 * Reservation-specific functionality
 */

// ============================================
// RESERVATION FORM FUNCTIONS
// ============================================

/**
 * Initialize reservation form
 */
function initReservationForm() {
    const form = document.getElementById('reservation-form');
    if (!form) return;

    // Set minimum date to today
    const dateInput = form.querySelector('[name="date"]');
    if (dateInput) {
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);
    }

    // Time slot selection
    const timeSlots = form.querySelectorAll('.time-slot');
    timeSlots.forEach(slot => {
        slot.addEventListener('click', () => {
            timeSlots.forEach(s => s.classList.remove('selected'));
            slot.classList.add('selected');

            const timeInput = form.querySelector('[name="time"]');
            if (timeInput) {
                timeInput.value = slot.dataset.time;
            }
        });
    });

    // Guest count buttons
    const guestBtns = form.querySelectorAll('.guest-btn');
    guestBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            guestBtns.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');

            const guestsInput = form.querySelector('[name="guests"]');
            if (guestsInput) {
                guestsInput.value = btn.dataset.guests;
            }
        });
    });

    // Table preference selection
    const tableOptions = form.querySelectorAll('.table-option input');
    tableOptions.forEach(option => {
        option.addEventListener('change', () => {
            tableOptions.forEach(o => {
                const label = o.nextElementSibling;
                if (label) {
                    label.style.borderColor = o.checked ? 'var(--primary-color)' : 'transparent';
                }
            });
        });
    });
}

/**
 * Check table availability
 * @param {string} date - Selected date
 * @param {string} time - Selected time
 * @param {number} guests - Number of guests
 */
function checkAvailability(date, time, guests) {
    // Demo: Show loading state
    const checkBtn = document.getElementById('check-availability-btn');
    if (checkBtn) {
        const originalText = checkBtn.innerHTML;
        checkBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Checking...';
        checkBtn.disabled = true;

        setTimeout(() => {
            checkBtn.innerHTML = originalText;
            checkBtn.disabled = false;

            // Show availability results
            showAvailabilityResults([
                { table: 'Table 1', type: 'Window', capacity: 4 },
                { table: 'Table 5', type: 'Booth', capacity: 4 },
                { table: 'Table 8', type: 'Outdoor', capacity: 6 }
            ]);
        }, 1500);
    }
}

/**
 * Show availability results
 * @param {Array} tables - Available tables
 */
function showAvailabilityResults(tables) {
    const container = document.getElementById('availability-results');
    if (!container) return;

    let html = '<h4>Available Tables</h4><div class="available-tables">';

    tables.forEach(table => {
        html += `
            <div class="available-table-card" onclick="selectTable('${table.table}')">
                <i class="fas fa-utensils"></i>
                <h5>${table.table}</h5>
                <p>${table.type} • ${table.capacity} seats</p>
            </div>
        `;
    });

    html += '</div>';
    container.innerHTML = html;
    container.style.display = 'block';
}

/**
 * Select a table
 * @param {string} tableName - Name of the selected table
 */
function selectTable(tableName) {
    const tableInput = document.querySelector('[name="tablePreference"]');
    if (tableInput) {
        tableInput.value = tableName;
    }

    // Highlight selected table
    const cards = document.querySelectorAll('.available-table-card');
    cards.forEach(card => {
        if (card.querySelector('h5').textContent === tableName) {
            card.classList.add('selected');
        } else {
            card.classList.remove('selected');
        }
    });

    showToast(`Table ${tableName} selected`, 'success');
}

/**
 * Submit reservation
 * @param {Event} event - Form submit event
 */
function submitReservation(event) {
    event.preventDefault();

    if (!validateReservationForm('reservation-form')) {
        return;
    }

    const form = document.getElementById('reservation-form');
    const submitBtn = form.querySelector('button[type="submit"]');

    // Show loading state
    if (submitBtn) {
        setButtonLoading(submitBtn, true);
    }

    // Simulate API call
    setTimeout(() => {
        if (submitBtn) {
            setButtonLoading(submitBtn, false);
        }

        // Show success modal
        showReservationSuccess();
    }, 2000);
}

/**
 * Show reservation success modal
 */
function showReservationSuccess() {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="text-align: center; max-width: 450px;">
                <div class="modal-body" style="padding: 2.5rem;">
                    <div style="width: 80px; height: 80px; background: var(--success-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem;">
                        <i class="fas fa-check" style="font-size: 2.5rem; color: white;"></i>
                    </div>
                    <h2 style="margin-bottom: 1rem; color: var(--secondary-color);">Reservation Confirmed!</h2>
                    <p style="color: var(--dark-gray); margin-bottom: 1.5rem;">Your reservation has been successfully made. We've sent a confirmation email with all the details.</p>
                    <div style="background: var(--light-gray); padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                        <p style="margin-bottom: 0.5rem;"><strong>Reservation ID:</strong> #RES-7842</p>
                        <p style="margin-bottom: 0;"><strong>Date:</strong> ${new Date().toLocaleDateString()}</p>
                    </div>
                    <button class="btn btn-primary" onclick="closeModal(this); window.location.href='my-reservations.html';" style="width: 100%;">View My Reservations</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

// ============================================
// MY RESERVATIONS FUNCTIONS
// ============================================

/**
 * Filter reservations by status
 * @param {string} status - Status to filter by
 */
function filterReservations(status) {
    const cards = document.querySelectorAll('.reservation-card');

    cards.forEach(card => {
        if (status === 'all' || card.dataset.status === status) {
            card.style.display = 'grid';
        } else {
            card.style.display = 'none';
        }
    });

    // Update active filter button
    const filterBtns = document.querySelectorAll('.filter-btn');
    filterBtns.forEach(btn => {
        btn.classList.toggle('active', btn.dataset.filter === status);
    });
}

/**
 * Edit reservation
 * @param {number} reservationId - Reservation ID
 */
function editReservation(reservationId) {
    showToast('Edit reservation form would open', 'info');
}

/**
 * View reservation details
 * @param {number} reservationId - Reservation ID
 */
function viewReservationDetails(reservationId) {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Reservation Details</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="reservation-detail-item">
                        <span class="label">Reservation ID</span>
                        <span class="value">#RES-${String(reservationId).padStart(4, '0')}</span>
                    </div>
                    <div class="reservation-detail-item">
                        <span class="label">Date & Time</span>
                        <span class="value">Dec 25, 2024 at 7:00 PM</span>
                    </div>
                    <div class="reservation-detail-item">
                        <span class="label">Guests</span>
                        <span class="value">4 people</span>
                    </div>
                    <div class="reservation-detail-item">
                        <span class="label">Table</span>
                        <span class="value">Table 5 (Window View)</span>
                    </div>
                    <div class="reservation-detail-item">
                        <span class="label">Status</span>
                        <span class="badge badge-confirmed">Confirmed</span>
                    </div>
                    <div class="reservation-detail-item">
                        <span class="label">Special Requests</span>
                        <span class="value">Anniversary dinner celebration</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Close</button>
                    <button class="btn btn-primary" onclick="editReservation(${reservationId})">Edit</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

// ============================================
// MENU FUNCTIONS
// ============================================

/**
 * Filter menu by category
 * @param {string} category - Category to filter by
 * @param {HTMLElement} btn - The button that triggered the filter
 */
function filterMenu(category, btn) {
    const items = document.querySelectorAll('.menu-item');

    items.forEach(item => {
        if (category === 'all' || item.dataset.category === category) {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });

    // Update active button
    const categoryBtns = document.querySelectorAll('.category-btn');
    categoryBtns.forEach(b => b.classList.remove('active'));
    if (btn) {
        btn.classList.add('active');
    }
}

/**
 * Add item to preorder
 * @param {number} itemId - Menu item ID
 * @param {string} itemName - Menu item name
 * @param {number} price - Item price
 */
function addToPreorder(itemId, itemName, price) {
    // Get existing preorder from localStorage
    let preorder = JSON.parse(localStorage.getItem('preorder') || '[]');

    // Check if item already exists
    const existingItem = preorder.find(item => item.id === itemId);
    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        preorder.push({ id: itemId, name: itemName, price: price, quantity: 1 });
    }

    // Save to localStorage
    localStorage.setItem('preorder', JSON.stringify(preorder));

    // Update cart count
    updateCartCount();

    showToast(`"${itemName}" added to preorder!`, 'success');
}

/**
 * Update cart count badge
 */
function updateCartCount() {
    const preorder = JSON.parse(localStorage.getItem('preorder') || '[]');
    const totalItems = preorder.reduce((sum, item) => sum + item.quantity, 0);

    const cartBadge = document.querySelector('.cart-badge');
    if (cartBadge) {
        cartBadge.textContent = totalItems;
        cartBadge.style.display = totalItems > 0 ? 'flex' : 'none';
    }
}

/**
 * View preorder cart
 */
function viewPreorderCart() {
    const preorder = JSON.parse(localStorage.getItem('preorder') || '[]');

    if (preorder.length === 0) {
        showToast('Your preorder cart is empty', 'warning');
        return;
    }

    let itemsHtml = '';
    let total = 0;

    preorder.forEach(item => {
        const itemTotal = item.price * item.quantity;
        total += itemTotal;
        itemsHtml += `
            <div class="preorder-item" style="display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--medium-gray);">
                <div>
                    <p style="margin-bottom: 0; font-weight: 500;">${item.name}</p>
                    <p style="margin-bottom: 0; font-size: 0.875rem; color: var(--dark-gray);">$${item.price.toFixed(2)} x ${item.quantity}</p>
                </div>
                <p style="margin-bottom: 0; font-weight: 600;">$${itemTotal.toFixed(2)}</p>
            </div>
        `;
    });

    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 450px;">
                <div class="modal-header">
                    <h3>Your Preorder</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    ${itemsHtml}
                    <div style="display: flex; justify-content: space-between; padding-top: 1rem; margin-top: 1rem; border-top: 2px solid var(--medium-gray);">
                        <p style="margin-bottom: 0; font-size: 1.25rem; font-weight: 600;">Total</p>
                        <p style="margin-bottom: 0; font-size: 1.25rem; font-weight: 700; color: var(--primary-color);">$${total.toFixed(2)}</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="clearPreorder(); closeModal(this);">Clear</button>
                    <button class="btn btn-primary" onclick="closeModal(this); window.location.href='payment.html';">Proceed to Payment</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

/**
 * Clear preorder cart
 */
function clearPreorder() {
    localStorage.removeItem('preorder');
    updateCartCount();
    showToast('Preorder cart cleared', 'info');
}

// ============================================
// OFFERS FUNCTIONS
// ============================================

/**
 * Copy offer code
 * @param {string} code - Offer code to copy
 */
function copyOfferCode(code) {
    navigator.clipboard.writeText(code).then(() => {
        showToast(`Code "${code}" copied to clipboard!`, 'success');
    }).catch(() => {
        // Fallback for browsers that don't support clipboard API
        const textarea = document.createElement('textarea');
        textarea.value = code;
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
        showToast(`Code "${code}" copied to clipboard!`, 'success');
    });
}

/**
 * Apply offer to reservation
 * @param {string} offerCode - Offer code
 */
function applyOffer(offerCode) {
    showToast(`Offer "${offerCode}" applied to your reservation!`, 'success');
}

// ============================================
// LOYALTY FUNCTIONS
// ============================================

/**
 * Redeem reward
 * @param {string} rewardId - Reward ID
 * @param {string} rewardName - Reward name
 * @param {number} points - Points required
 */
function redeemReward(rewardId, rewardName, points) {
    showConfirm(
        `Redeem "${rewardName}" for ${points} points?`,
        () => {
            showToast(`Reward redeemed successfully!`, 'success');
        }
    );
}

/**
 * View loyalty history
 */
function viewLoyaltyHistory() {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="max-width: 500px;">
                <div class="modal-header">
                    <h3>Points History</h3>
                    <button class="modal-close" onclick="closeModal(this)">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="points-history">
                        <div class="history-item" style="display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--medium-gray);">
                            <div>
                                <p style="margin-bottom: 0; font-weight: 500;">Reservation Completed</p>
                                <p style="margin-bottom: 0; font-size: 0.875rem; color: var(--dark-gray);">Dec 20, 2024</p>
                            </div>
                            <span style="color: var(--success-color); font-weight: 600;">+250 pts</span>
                        </div>
                        <div class="history-item" style="display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--medium-gray);">
                            <div>
                                <p style="margin-bottom: 0; font-weight: 500;">Review Submitted</p>
                                <p style="margin-bottom: 0; font-size: 0.875rem; color: var(--dark-gray);">Dec 18, 2024</p>
                            </div>
                            <span style="color: var(--success-color); font-weight: 600;">+100 pts</span>
                        </div>
                        <div class="history-item" style="display: flex; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--medium-gray);">
                            <div>
                                <p style="margin-bottom: 0; font-weight: 500;">Reward Redeemed</p>
                                <p style="margin-bottom: 0; font-size: 0.875rem; color: var(--dark-gray);">Dec 15, 2024</p>
                            </div>
                            <span style="color: var(--accent-color); font-weight: 600;">-500 pts</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="closeModal(this)">Close</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);
}

// ============================================
// PAYMENT FUNCTIONS
// ============================================

/**
 * Process payment
 * @param {Event} event - Form submit event
 */
function processPayment(event) {
    event.preventDefault();

    if (!validatePaymentForm('payment-form')) {
        return;
    }

    const form = document.getElementById('payment-form');
    const submitBtn = form.querySelector('button[type="submit"]');

    if (submitBtn) {
        setButtonLoading(submitBtn, true);
    }

    // Simulate payment processing
    setTimeout(() => {
        if (submitBtn) {
            setButtonLoading(submitBtn, false);
        }

        showPaymentSuccess();
    }, 2500);
}

/**
 * Show payment success modal
 */
function showPaymentSuccess() {
    const modalContent = `
        <div class="modal-overlay active">
            <div class="modal" style="text-align: center; max-width: 450px;">
                <div class="modal-body" style="padding: 2.5rem;">
                    <div style="width: 80px; height: 80px; background: var(--success-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem;">
                        <i class="fas fa-check" style="font-size: 2.5rem; color: white;"></i>
                    </div>
                    <h2 style="margin-bottom: 1rem; color: var(--secondary-color);">Payment Successful!</h2>
                    <p style="color: var(--dark-gray); margin-bottom: 1.5rem;">Your payment has been processed successfully. Thank you for your order!</p>
                    <div style="background: var(--light-gray); padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                        <p style="margin-bottom: 0.5rem;"><strong>Transaction ID:</strong> #TXN-${Math.floor(Math.random() * 1000000)}</p>
                        <p style="margin-bottom: 0;"><strong>Amount:</strong> $125.00</p>
                    </div>
                    <button class="btn btn-primary" onclick="closeModal(this); window.location.href='customer-dashboard.html';" style="width: 100%;">Back to Dashboard</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalContent);

    // Clear preorder after successful payment
    localStorage.removeItem('preorder');
    updateCartCount();
}

/**
 * Format card number input
 * @param {HTMLElement} input - Card number input
 */
function formatCardNumber(input) {
    let value = input.value.replace(/\D/g, '');
    value = value.substring(0, 16);

    // Add spaces every 4 digits
    const parts = value.match(/.{1,4}/g);
    if (parts) {
        input.value = parts.join(' ');
    } else {
        input.value = value;
    }
}

/**
 * Format expiry date input
 * @param {HTMLElement} input - Expiry date input
 */
function formatExpiryDate(input) {
    let value = input.value.replace(/\D/g, '');
    value = value.substring(0, 4);

    if (value.length >= 2) {
        input.value = value.substring(0, 2) + '/' + value.substring(2);
    } else {
        input.value = value;
    }
}

// ============================================
// INITIALIZATION
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize reservation form
    initReservationForm();

    // Update cart count on page load
    updateCartCount();

    // Initialize card number formatting
    const cardNumberInput = document.querySelector('[name="cardNumber"]');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', () => formatCardNumber(cardNumberInput));
    }

    // Initialize expiry date formatting
    const expiryInput = document.querySelector('[name="expiry"]');
    if (expiryInput) {
        expiryInput.addEventListener('input', () => formatExpiryDate(expiryInput));
    }
});









