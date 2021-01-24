<a class="btn btn-success" id="next_btn" style="margin-top: 0;"><i class="glyphicon glyphicon-menu-right"></i> <span>Next</span></a>
 
<form action="/admin/sales-to-clients/next" id="next_form" method="POST" style="display:none"> 
    {{ csrf_field() }}
    <input type="hidden" name="ids" id="next_btn_input" value="">
    <input type="submit" class="" value="">
</form> 

<script>
window.addEventListener("load", function load(event){
    // Next btn selectors
    var $nextBtnBtn = $('#next_btn');  
    var $nextBtnInput = $('#next_btn_input'); 
    var $nextForm = $('#next_form'); 
    // Next btn listener
    $nextBtnBtn.click(function () {  
        var ids = [];
        var $checkedBoxes = $('#dataTable input[type=checkbox]:checked').not('.select_all');
        var count = $checkedBoxes.length;
        if (count) {
            // Reset input value
            $nextBtnInput.val(''); 
            // Gather IDs
            var message = "", firstMessage = "", returnWarning = false;
            $.each($checkedBoxes, function () {
                var row = $(this).closest("tr")[0]; 
                message = row.cells[1].innerHTML;   
                if(firstMessage == "")
                    firstMessage = message;
                else if(firstMessage != message) {
                    returnWarning = true;
                    return;
                } 
                var value = $(this).val();
                ids.push(value);
            }) 
            // Set input value
            $nextBtnInput.val(ids); 
            if(!returnWarning) $nextForm.submit();
            else toastr.warning('You should choose the same client');
        } else {
            // No row selected
            toastr.warning('You haven\'t selected anything');
        }
    });
});
</script>
