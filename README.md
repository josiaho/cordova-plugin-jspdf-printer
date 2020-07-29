# cordova-plugin-jspdf-printer
A plugin for cordova to print a [jsPDF](https://github.com/MrRio/jsPDF) generated PDF on OSX/macOS 10.9+

## Installation
Install the latest head version:

    $ cordova plugin add cordova-plugin-jspdf-printer


## Usage
The plugin creates an object `printJSPDF` and is accessible after *deviceready* has been fired. This object contains a three functions:

### printJSPDF.getPrinters([callback])
```javascript
printJSPDF.getPrinters(function(x){
	alert(x) // Array of Printer Names
});
```

### printJSPDF.getPrinterDescription(printerName[,callback])
```javascript
printJSPDF.getPrinterDescription('printerName', function(d){
	alert(d) // Description of Named Printer
});
```

### printJSPDF.printPDF(doc.output(), printerName, width, height[, callback])
```javascript
// Create jsPDF Document
var doc = new jsPDF('p', 'mm', [165.3,287.85]);
	doc.text('Sample Text', 15, 80);

// Print jsPDF Document
printJSPDF.printPDF(doc.output(), 'DYMO LabelWriter 450 Turbo', 165.3, 287.85, function(d){
	console.log(d)
});
```
