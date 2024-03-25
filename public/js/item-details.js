jQuery(document).ready(function () { 
  jQuery('#confirm-delete-item-btn').on('click', function(){

    var itemId = jQuery(this).data('id');
    console.log(`itemID = ${itemId}`);
    jQuery.ajax({
      url: `/item/${itemId}`,
      type: 'DELETE',
      success: function(response) {
        window.location.href = '/';
      },
      error: function(xhr, status, error) {
        console.log(`Error deleting rental item. error: ${error?.message}`);
      }
    })
  });

});

function printQrCode() {
    var qrGuidContent = $('#qr-container').clone();
    var printContent = $('<div></div>').append(qrGuidContent);
  
    var printWindow = window.open('', '_blank');
    printWindow.document.write('<html><head><title>Print</title>');
    printWindow.document.write('<style>');
    printWindow.document.write('@media print {');
    printWindow.document.write('body { margin: 0; }');
    printWindow.document.write('#print-content { display: flex; justify-content: center; align-items: center; height: 100vh; }');
    printWindow.document.write('#qr-container { text-align: center; }'); 
    printWindow.document.write('}');
    printWindow.document.write('</style>');
    printWindow.document.write('</head><body>');
    printWindow.document.write('<div id="print-content">');
    printWindow.document.write(printContent.html());
    printWindow.document.write('</div>');
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
  }