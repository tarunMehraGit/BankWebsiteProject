import { LightningElement } from 'lwc';

export default class PublisherComponent extends LightningElement {

    quantity;
    productPrice;
    data = [
        {
            "Keyboard" : {
                'qty' : this.quantity,
                'Price' : this.productPrice,
            },
        }
    ]
    
    selectProduct;
    get options(){
        var productOptions = [];
        for(var product in this.data[0]){
            var obj={};
            obj.label = product;
            obj.value = product;
            productOptions.push(obj);
        }
        return productOptions;
    }
}