import { LightningElement } from 'lwc';

export default class ComboBoxExample extends LightningElement {
    //country;state;city;
    allData = [
        {
            "India" : {
                "Rajasthan" : {
                    "Ajmer" : "300501",
                    "Jaipur" : "302003",
                    "Bikaner" : "302001",   
                },
                "Punjab" : {
                    "Amritsar" : "143001",
                    "Patiala" : "143005",
                    "Chandigarh" : "143006"
                },
                "Madhya Pradesh" : {
                    "Bhopal" : "462001",
                    "Ujjain" : "462002",
                    "Indore" : "462003"                  
                }   
            },
            "Australia" : {
                "New South Wales" : {
                    "Albury-Wodonga" : "1500101",
                    "Forster" : "1500102",
                    "Wyong" : "1500103"
                },
                "South Australia" : {
                    "Adelaide" : "1200501",
                    "Renmark" : "1200502",
                    "Millicent" : "1200503"
                },
                "Victoria" : {
                    "Hamilton"  : "1800601",
                    "Melbourne" : "1800602",
                    "Sunbury" : "1800603"
                }
            },
            "New Zealand" : {
                "Auckland" : {
                    "Auckland" : "130401",
                    "Devonport" : "130402",
                    "Waiuku" : "130403"
                },
                "Wellington" : {
                    "Masterton" : "1001201",
                    "Upper Hutt" : "1001202",
                    "Wellington" : "1001203"
                },
                "Waikato" : {
                    "Hamilton" : "1700101",
                    "Paeroa" : "1700102",
                    "Waihi" : "1700103"
                }
            }
        },
    ];   
    country = "";
    state = "";
    city = "";
    stateOptions;
    cityOptions;
    pinCode ;
    get countryOptions(){
        var countryOptions = [];
        for(var country in this.allData[0]){
            var obj = {};
            obj.label = country;
            //console.log('$$' + country);
            obj.value = country;
            countryOptions.push(obj);
        }   
        return countryOptions;
    }
    stateNames(event){
        this.stateOptions = [];
        this.country = event.target.value;
        for(var state in this.allData[0][this.country]){
            var stateObj = {};
            stateObj.label = state;
            stateObj.value = state;
            //console.log('##' + state);
            this.stateOptions.push(stateObj);
        }
    }
    cityNames(event){
        this.cityOptions = [];
        this.state = event.target.value;
        for(var city in this.allData[0][this.country][this.state]){
            var cityObj = {};
            cityObj.label = city;
            //console.log('@@--' + city);
            cityObj.value = this.allData[0][this.country][this.state][city];
            this.cityOptions.push(cityObj);
        }
    } 

    pinCodeName(event){
        this.pinCode = event.target.value;
       // console.log('Pin : ' + this.pinCode);
    }
}