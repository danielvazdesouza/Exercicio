import { api, LightningElement } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name'
import ACCOUNT_NUMBER from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import ACCOUNT_ID from '@salesforce/schema/Account.Id';

export default class ExercicioUpdate extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = [ACCOUNT_ID, ACCOUNT_NAME , ACCOUNT_NUMBER, ACCOUNT_TYPE];

    handleSubmit(event){
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-form').submit(fields);
     }
}