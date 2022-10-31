import { LightningElement , track } from 'lwc';
import SamsungImage from '@salesforce/resourceUrl/SamsungImage'
import VivoImage from '@salesforce/resourceUrl/VivoImage'

export default class ParentComponent extends LightningElement {
    
    samsung = SamsungImage;
    vivo = VivoImage; 
    details;
    product="";
    Quantity;
    data = [
        {  
            "Samsung" : {
                'Product_Image' : this.samsung,
                'Price' : 15000 +' Rs',
                'Description' : 'It has a 5.8-inch Quad HD+ Super AMOLED display with an 18.5:9 aspect ratio. Touch response and colours are superb and it also supports HDR. In India, the phone uses an Exynos 9810 octa-core SoC and comes with 4GB of RAM a choice of 64GB or 256GB internal storage, which is expandable.'
            },
            "Vivo" : {
                'Product_Image' : this.vivo,
                'Price' : 12000 + ' Rs',
                'Description' : 'The phone comes with a 6.30-inch touchscreen display with a resolution of 1080x2340 pixels. Vivo V11 is powered by a 2.2GHz MediaTek Helio P60 (MT6771) processor. It comes with 6GB of RAM. ... '
            }
        }
    ];
    get options(){
        var optionList=[];
        for(var product in this.data[0]){
            var productObj = {};
            productObj.label = product + ((this.Quantity) > 0 && this.product == product ? '('+this.Quantity+')' : '' );
            productObj.value = product;
            optionList.push(productObj);
        }
        return optionList;
    }
    getInformation(event){
        if(this.product != event.target.value){
            this.Quantity = 0;
        }
        this.product = event.target.value;
        this.details = this.data[0][this.product];
    }
    getValue(event){
        this.Quantity = event.detail;
    }
}