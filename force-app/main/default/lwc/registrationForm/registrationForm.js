import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import registerUser from '@salesforce/apex/RegistrationController.registerUser';

export default class RegistrationForm extends LightningElement {
    @track formData = {
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: ''
    };
    
    isLoading = false;

    // Simulates two-way binding & handles automatic phone formatting
    handleInputChange(event) {
        const { name, value } = event.target;
        
        if (name === 'phoneNumber') {
            this.formData[name] = this.formatPhoneNumber(value);
        } else {
            this.formData[name] = value;
        }
    }

    // Automatically formats input to (XXX) XXX-XXXX
    formatPhoneNumber(value) {
        if (!value) return value;
        const phoneNumber = value.replace(/[^\d]/g, '');
        const phoneNumberLength = phoneNumber.length;
        if (phoneNumberLength < 4) return phoneNumber;
        if (phoneNumberLength < 7) {
            return `(${phoneNumber.slice(0, 3)}) ${phoneNumber.slice(3)}`;
        }
        return `(${phoneNumber.slice(0, 3)}) ${phoneNumber.slice(3, 6)}-${phoneNumber.slice(6, 10)}`;
    }

    // Handles form validation and Apex submission
    async handleSubmit() {
        const allValid = [
            ...this.template.querySelectorAll('lightning-input')
        ].reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);

        if (!allValid) {
            this.showToast('Error', 'Please resolve form errors before submitting.', 'error');
            return;
        }

        this.isLoading = true;

        try {
            await registerUser({ userData: this.formData });
            this.showToast('Success', 'Registration successful!', 'success');
            this.resetForm();
        } catch (error) {
            this.showToast('Error', error.body?.message || 'An unknown error occurred.', 'error');
        } finally {
            this.isLoading = false;
        }
    }

    resetForm() {
        this.formData = { firstName: '', lastName: '', email: '', phoneNumber: '' };
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}