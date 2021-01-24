
<a class="btn btn-success" id="next_btn" style="margin-top: 0;"><i class="glyphicon glyphicon-menu-right"></i> <span>Next</span></a>
 
<form action="/admin/sales-to-clients-archive/next" id="next_form" method="POST" style="display:none"> 
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
        if (count > 1) 
            toastr.warning('You should choose one row only');
        else if (count == 1) {
            // Reset input value
            $nextBtnInput.val(''); 
            // Gather IDs
            var message = "", firstMessage = "";
            $.each($checkedBoxes, function () {
                var row = $(this).closest("tr")[0];   
                var value = $(this).val();
                ids.push(value);
            }) 
            // Set input value
            $nextBtnInput.val(ids); 
            $nextForm.submit(); 
        } 
        else // No row selected 
            toastr.warning('You haven\'t selected anything');
        
    });
});
</script>
