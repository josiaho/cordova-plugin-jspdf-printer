
var printJSPDF = {
	getPrinters: function (success, fail) {
		cordova.exec(success, fail, "printJSPDF", 'getPrinters', []);
	},
    getPrinterDescription: function (printerName, success, fail) {
		cordova.exec(function (res){
            var r = res.split('Type = "')[1].split('";')[0];
            success(r);
    	}, fail, "printJSPDF", 'getPrinterDescription', [printerName]);
    },
    printPDF: function (data, printerName, width, height, success, fail) {
        // Convert jsPDF .output() to buffer (fixes embeded images)
        var buffer = new ArrayBuffer(data.length);
        var array = new Uint8Array(buffer);
        for (var i = 0; i < data.length; i++) {
            array[i] = data.charCodeAt(i);
        }
        // Encode output to base64
        var binary = '';
        var bytes = new Uint8Array( buffer );
        var len = bytes.byteLength;
        for (var i = 0; i < len; i++) {
            binary += String.fromCharCode( bytes[ i ] );
        }
        var nbuffer = window.btoa( binary );
        
        cordova.exec(success, fail, "printJSPDF", 'printPDF', [nbuffer, printerName, width, height]);
    }
};

module.exports = printJSPDF
